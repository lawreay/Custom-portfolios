<?php
/**
 * Portfolio Admin Login System
 */

require_once '../config.php';

$login_error = '';
$reset_sent = '';

// Check if already logged in
if (is_logged_in()) {
    header("Location: dashboard.php");
    exit();
}

// Handle Login
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login'])) {
    $username = escape_input($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    if (empty($username) || empty($password)) {
        $login_error = 'Username and password required';
    } else {
        $query = "SELECT id, password, full_name FROM portfolio_users WHERE username = ? OR email = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param("ss", $username, $username);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($user = $result->fetch_assoc()) {
            if (verify_password($password, $user['password'])) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $username;
                $_SESSION['full_name'] = $user['full_name'];
                $_SESSION['login_time'] = time();
                
                header("Location: dashboard.php");
                exit();
            } else {
                $login_error = 'Invalid password';
            }
        } else {
            $login_error = 'User not found';
        }
    }
}

// Handle Password Recovery
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['recover'])) {
    $email = escape_input($_POST['recovery_email'] ?? '');
    
    if (empty($email)) {
        $login_error = 'Email required';
    } else {
        $query = "SELECT id, email FROM portfolio_users WHERE email = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($user = $result->fetch_assoc()) {
            $token = generate_recovery_token();
            $expiry = date('Y-m-d H:i:s', time() + 3600); // 1 hour
            
            $update_query = "UPDATE portfolio_users SET reset_token = ?, reset_token_expiry = ? WHERE id = ?";
            $update_stmt = $mysqli->prepare($update_query);
            $update_stmt->bind_param("ssi", $token, $expiry, $user['id']);
            
            if ($update_stmt->execute()) {
                $recovery_link = ADMIN_URL . "reset-password.php?token=" . $token;
                $email_body = "
                    <h2>Password Recovery</h2>
                    <p>You requested to reset your portfolio admin password.</p>
                    <p><a href='" . $recovery_link . "'>Click here to reset your password</a></p>
                    <p>This link expires in 1 hour.</p>
                    <p>If you didn't request this, ignore this email.</p>
                ";
                
                if (send_email($email, "Portfolio Admin - Password Recovery", $email_body, true)) {
                    $reset_sent = 'Recovery link sent to your email';
                } else {
                    $login_error = 'Error sending email. Please try again later.';
                }
            }
        } else {
            // Don't reveal if email exists for security
            $reset_sent = 'If email exists, recovery link has been sent';
        }
    }
}

?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio Admin Login</title>
    <script src="https://cdn.tailwindcss.com/3.4.17"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in { animation: fadeIn 0.6s ease forwards; }
        * { box-sizing: border-box; }
        html, body { overflow-x: hidden; }
        input, button { font: inherit; }
        @media (max-width: 420px) {
            .login-card { padding: 1.25rem !important; border-radius: 1rem !important; }
            .login-title { font-size: 1.75rem !important; }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-900 to-slate-800 min-h-screen flex items-center justify-center px-4 py-8">
    <div class="w-full max-w-md animate-fade-in">
        <!-- Login Card -->
        <div class="login-card bg-slate-800 rounded-2xl shadow-2xl border border-slate-700 p-6 sm:p-8 mb-4">
            <div class="text-center mb-8">
                <div class="w-16 h-16 rounded-xl mx-auto mb-4 flex items-center justify-center bg-gradient-to-br from-indigo-500 to-pink-500">
                    <span class="text-2xl font-bold text-white">L</span>
                </div>
                <h1 class="login-title text-3xl font-bold text-white mb-2">LAWREAY</h1>
                <p class="text-slate-400">Portfolio Admin</p>
            </div>

            <?php if ($login_error): ?>
                <div class="mb-6 p-4 rounded-lg bg-red-900/20 border border-red-700/50 text-red-200 text-sm">
                    <?php echo htmlspecialchars($login_error); ?>
                </div>
            <?php endif; ?>

            <?php if ($reset_sent): ?>
                <div class="mb-6 p-4 rounded-lg bg-green-900/20 border border-green-700/50 text-green-200 text-sm">
                    <?php echo htmlspecialchars($reset_sent); ?>
                </div>
            <?php endif; ?>

            <!-- Login Form -->
            <form method="POST" id="loginForm" class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-2">Username or Email</label>
                    <input type="text" name="username" required class="w-full px-4 py-3 sm:py-2 rounded-lg bg-slate-700 border border-slate-600 text-white placeholder-slate-400 focus:outline-none focus:border-indigo-500 transition"
                        placeholder="Key Name or Email">
                </div>
                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-2">Password</label>
                    <input type="password" name="password" required class="w-full px-4 py-3 sm:py-2 rounded-lg bg-slate-700 border border-slate-600 text-white placeholder-slate-400 focus:outline-none focus:border-indigo-500 transition"
                        placeholder="••••••••">
                </div>
                <button type="submit" name="login" class="w-full py-3 sm:py-2 bg-gradient-to-r from-indigo-600 to-pink-600 text-white font-semibold rounded-lg hover:shadow-lg transition">
                    Login
                </button>
            </form>

            <div class="mt-6 border-t border-slate-700 pt-6">
                <p class="text-slate-400 text-sm text-center mb-4">Forgot your password?</p>
                <form method="POST" id="recoveryForm" class="space-y-3">
                    <input type="email" name="recovery_email" required placeholder="Enter your email" class="w-full px-4 py-3 sm:py-2 rounded-lg bg-slate-700 border border-slate-600 text-white placeholder-slate-400 focus:outline-none focus:border-indigo-500 transition text-sm">
                    <button type="submit" name="recover" class="w-full py-3 sm:py-2 bg-slate-700 hover:bg-slate-600 text-slate-200 font-medium rounded-lg transition text-sm">
                        Send Recovery Link
                    </button>
                </form>
            </div>
        </div>

        <div class="text-center text-slate-500 text-xs">
            &copy; <?php echo date('Y'); ?> LAWREAY. All rights reserved.
    </div>
</body>
</html>

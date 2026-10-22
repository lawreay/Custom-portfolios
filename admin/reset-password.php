<?php
/**
 * Password Recovery & Reset
 */

require_once '../config.php';

// Check if token provided
if (!isset($_GET['token']) || empty($_GET['token'])) {
    die("Invalid recovery link");
}

$token = escape_input($_GET['token']);
$reset_error = '';
$reset_success = '';

// Verify token exists and not expired
$query = "SELECT id, email FROM portfolio_users WHERE reset_token = ? AND reset_token_expiry > NOW()";
$stmt = $mysqli->prepare($query);
$stmt->bind_param("s", $token);
$stmt->execute();
$result = $stmt->get_result();

if (!$user = $result->fetch_assoc()) {
    die("Invalid or expired recovery link. <a href='login.php'>Back to login</a>");
}

// Handle password reset
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $new_password = $_POST['new_password'] ?? '';
    $confirm_password = $_POST['confirm_password'] ?? '';
    
    if (empty($new_password) || empty($confirm_password)) {
        $reset_error = 'Both password fields required';
    } elseif (strlen($new_password) < 6) {
        $reset_error = 'Password must be at least 6 characters';
    } elseif ($new_password !== $confirm_password) {
        $reset_error = 'Passwords do not match';
    } else {
        $hashed_password = hash_password($new_password);
        
        $update_query = "UPDATE portfolio_users SET password = ?, reset_token = NULL, reset_token_expiry = NULL WHERE id = ?";
        $update_stmt = $mysqli->prepare($update_query);
        $update_stmt->bind_param("si", $hashed_password, $user['id']);
        
        if ($update_stmt->execute()) {
            $reset_success = 'Password reset successfully! Redirecting to login...';
            header("Refresh: 3; url=login.php");
        } else {
            $reset_error = 'Error updating password';
        }
    }
}

?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <script src="https://cdn.tailwindcss.com/3.4.17"></script>
    <style>
        * { box-sizing: border-box; }
        html, body { overflow-x: hidden; }
        input, button { font: inherit; }
        @media (max-width: 420px) {
            .reset-card { padding: 1.25rem !important; border-radius: 1rem !important; }
            .reset-title { font-size: 1.75rem !important; }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-900 to-slate-800 min-h-screen flex items-center justify-center px-4 py-8">
    <div class="w-full max-w-md">
        <div class="reset-card bg-slate-800 rounded-2xl shadow-2xl border border-slate-700 p-6 sm:p-8">
            <div class="text-center mb-8">
                <h1 class="reset-title text-3xl font-bold text-white mb-2">Reset Password</h1>
                <p class="text-slate-400">Enter your new password</p>
            </div>

            <?php if ($reset_error): ?>
                <div class="mb-6 p-4 rounded-lg bg-red-900/20 border border-red-700/50 text-red-200 text-sm">
                    <?php echo htmlspecialchars($reset_error); ?>
                </div>
            <?php endif; ?>

            <?php if ($reset_success): ?>
                <div class="mb-6 p-4 rounded-lg bg-green-900/20 border border-green-700/50 text-green-200 text-sm">
                    <?php echo htmlspecialchars($reset_success); ?>
                </div>
            <?php else: ?>
                <form method="POST" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-slate-300 mb-2">New Password</label>
                        <input type="password" name="new_password" required class="w-full px-4 py-3 sm:py-2 rounded-lg bg-slate-700 border border-slate-600 text-white focus:outline-none focus:border-indigo-500 transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-300 mb-2">Confirm Password</label>
                        <input type="password" name="confirm_password" required class="w-full px-4 py-3 sm:py-2 rounded-lg bg-slate-700 border border-slate-600 text-white focus:outline-none focus:border-indigo-500 transition">
                    </div>
                    <button type="submit" class="w-full py-3 sm:py-2 bg-gradient-to-r from-indigo-600 to-pink-600 text-white font-semibold rounded-lg hover:shadow-lg transition">
                        Reset Password
                    </button>
                </form>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>

<?php
/**
 * Debug Password Verification
 */

require_once __DIR__ . '/config.php';

echo "<h2>Debug: Password Verification</h2>";

// Check admin user
$query = "SELECT id, username, email, password FROM portfolio_users WHERE username = 'admin'";
$result = $mysqli->query($query);

if ($result && $result->num_rows > 0) {
    $user = $result->fetch_assoc();
    echo "<p><strong>User found:</strong> " . htmlspecialchars($user['username']) . "</p>";
    echo "<p><strong>Email:</strong> " . htmlspecialchars($user['email']) . "</p>";
    echo "<p><strong>Password Hash:</strong> " . htmlspecialchars($user['password']) . "</p>";
    
    // Test verification
    $test_password = 'admin123';
    $is_valid = password_verify($test_password, $user['password']);
    
    echo "<p><strong>Password Verification Result:</strong> " . ($is_valid ? " VALID" : " INVALID") . "</p>";
    
    if (!$is_valid) {
        echo "<h3>Fixing Password...</h3>";
        
        // Generate correct hash
        $correct_hash = password_hash('admin123', PASSWORD_BCRYPT, ['cost' => 10]);
        echo "<p>New Hash: " . htmlspecialchars($correct_hash) . "</p>";
        
        // Update password
        $update_query = "UPDATE portfolio_users SET password = ? WHERE username = 'admin'";
        $stmt = $mysqli->prepare($update_query);
        $stmt->bind_param("s", $correct_hash);
        
        if ($stmt->execute()) {
            echo "<p> Password updated successfully!</p>";
            
            // Verify again
            $new_verify = password_verify($test_password, $correct_hash);
            echo "<p><strong>New Verification:</strong> " . ($new_verify ? " VALID" : " INVALID") . "</p>";
        } else {
            echo "<p> Error updating password: " . $mysqli->error . "</p>";
        }
    }
} else {
    echo "<p>User 'admin' not found in database!</p>";
    
    echo "<h3>Creating Admin User...</h3>";
    
    $username = 'admin';
    $email = 'lawreay1@gmail.com';
    $password = password_hash('admin123', PASSWORD_BCRYPT, ['cost' => 10]);
    $full_name = 'Lawrence Phuka Chikapa';
    
    $insert_query = "INSERT INTO portfolio_users (username, email, password, full_name) VALUES (?, ?, ?, ?)";
    $stmt = $mysqli->prepare($insert_query);
    $stmt->bind_param("ssss", $username, $email, $password, $full_name);
    
    if ($stmt->execute()) {
        echo "<p> Admin user created successfully!</p>";
    } else {
        echo "<p> Error creating user: " . $mysqli->error . "</p>";
    }
}

echo "<p><a href='admin/login.php'>Back to Login</a></p>";
?>

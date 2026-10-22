<?php
/**
 * Database Setup Script - Run once to initialize the portfolio admin system
 */

// Database Configuration
$host = 'sql110.infinityfree.com';
$user = 'root';
$pass = '';
$db = 'if0_41898653_lawreay';

// Create connection
$mysqli = new mysqli($host, $user, $pass);

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

echo "Connected to MySQL successfully.<br>";

// Create database if it doesn't exist
$create_db = "CREATE DATABASE IF NOT EXISTS `" . $db . "`";
if ($mysqli->query($create_db)) {
    echo "Database created or already exists.<br>";
} else {
    die("Error creating database: " . $mysqli->error);
}

// Select the database
if (!$mysqli->select_db($db)) {
    die("Error selecting database: " . $mysqli->error);
}

echo "Database selected.<br>";

// Read and execute the schema file
$schema_file = __DIR__ . '/database_schema.sql';
if (!file_exists($schema_file)) {
    die("Schema file not found: " . $schema_file);
}

$sql = file_get_contents($schema_file);

// Execute multiple SQL statements
$statements = array_filter(array_map('trim', explode(';', $sql)), function($s) {
    return !empty($s) && strpos($s, '--') !== 0;
});

foreach ($statements as $statement) {
    if (!empty(trim($statement))) {
        if (!$mysqli->query($statement)) {
            echo "Error executing statement: " . $mysqli->error . "<br>";
            echo "Statement: " . substr($statement, 0, 100) . "...<br>";
        }
    }
}

echo "<strong> Database setup completed successfully!</strong><br>";
echo "<p>Demo Login Credentials:</p>";
echo "<p><strong>Username:</strong> admin<br>";
echo "<strong>Password:</strong> admin123</p>";
echo "<p><a href='admin/login.php'>Go to Login Page</a></p>";

$mysqli->close();
?>

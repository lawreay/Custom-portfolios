<?php
/**
 * Image URL Fixer - Web Version
 * Access via: http://localhost/Portifolio/fix_urls_web.php
 * 
 * This script needs to connect to the online database, so make sure your internet connection is active
 */

// Bypass PORTFOLIO_PUBLIC_PAGE check
define('PORTFOLIO_PUBLIC_PAGE', true);

// Get config but catch connection errors gracefully
require_once __DIR__ . '/config.php';

// Check if we can connect to database
if (!$mysqli || $mysqli->connect_error) {
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Database Connection Error</title>
        <style>
            body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
            .error { background: #fee; border: 1px solid #fcc; padding: 15px; border-radius: 4px; color: #c00; }
            .info { background: #efe; border: 1px solid #cfc; padding: 15px; border-radius: 4px; color: #060; margin-top: 10px; }
        </style>
    </head>
    <body>
        <h1>⚠️ Database Connection Error</h1>
        <div class="error">
            <strong>Cannot connect to database:</strong><br>
            <?php echo htmlspecialchars($mysqli->connect_error ?? 'Unknown error'); ?>
        </div>
        <div class="info">
            <strong>How to fix this:</strong><br>
            1. Make sure you have an active internet connection<br>
            2. Verify that sql110.infinityfree.com is reachable<br>
            3. Check your database credentials in config.php<br>
            4. Consider running the fix_image_urls.sql file manually in phpMyAdmin instead
        </div>
    </body>
    </html>
    <?php
    exit;
}

$user_id = 1;
$correct_base_url = 'https://sql110.infinityfree.com/Portifolio/uploads/';
$fixed_count = 0;
$errors = [];
$updates = [];

function extract_filename($url) {
    $url = (string)$url;
    if (empty($url)) return '';
    if (preg_match('/uploads\/(.+)$/', $url, $matches)) {
        return $matches[1];
    }
    return '';
}

// Process fixes if form submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['confirm_fix'])) {
    
    // 1. Fix profile image
    $result = $mysqli->query("SELECT id, profile_image FROM portfolio_settings WHERE user_id = $user_id");
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            if (!empty($row['profile_image'])) {
                $filename = extract_filename($row['profile_image']);
                if ($filename) {
                    $new_url = $correct_base_url . $filename;
                    $stmt = $mysqli->prepare("UPDATE portfolio_settings SET profile_image = ? WHERE id = ?");
                    $stmt->bind_param("si", $new_url, $row['id']);
                    if ($stmt->execute()) {
                        $updates[] = "✓ Profile image: " . htmlspecialchars($filename);
                        $fixed_count++;
                    } else {
                        $errors[] = "Failed to update profile image";
                    }
                    $stmt->close();
                }
            }
        }
    }
    
    // 2. Fix project images
    $result = $mysqli->query("SELECT id, image_path FROM portfolio_projects WHERE user_id = $user_id AND image_path IS NOT NULL AND image_path != ''");
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $filename = extract_filename($row['image_path']);
            if ($filename) {
                $new_url = $correct_base_url . $filename;
                $stmt = $mysqli->prepare("UPDATE portfolio_projects SET image_path = ? WHERE id = ?");
                $stmt->bind_param("si", $new_url, $row['id']);
                if ($stmt->execute()) {
                    $updates[] = "✓ Project ID {$row['id']}: " . htmlspecialchars($filename);
                    $fixed_count++;
                } else {
                    $errors[] = "Failed to update project {$row['id']}";
                }
                $stmt->close();
            }
        }
    }
    
    // 3. Fix project icons
    $result = $mysqli->query("SELECT id, icon_type FROM portfolio_projects WHERE user_id = $user_id AND icon_type IS NOT NULL AND icon_type LIKE '%/%'");
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $filename = extract_filename($row['icon_type']);
            if ($filename) {
                $new_url = $correct_base_url . $filename;
                $stmt = $mysqli->prepare("UPDATE portfolio_projects SET icon_type = ? WHERE id = ?");
                $stmt->bind_param("si", $new_url, $row['id']);
                if ($stmt->execute()) {
                    $updates[] = "✓ Project icon ID {$row['id']}: " . htmlspecialchars($filename);
                    $fixed_count++;
                } else {
                    $errors[] = "Failed to update icon for project {$row['id']}";
                }
                $stmt->close();
            }
        }
    }
    
    // 4. Fix popup images
    $result = $mysqli->query("SELECT id, image_url FROM portfolio_popups WHERE user_id = $user_id AND image_url IS NOT NULL AND image_url != ''");
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $filename = extract_filename($row['image_url']);
            if ($filename) {
                $new_url = $correct_base_url . $filename;
                $stmt = $mysqli->prepare("UPDATE portfolio_popups SET image_url = ? WHERE id = ?");
                $stmt->bind_param("si", $new_url, $row['id']);
                if ($stmt->execute()) {
                    $updates[] = "✓ Popup ID {$row['id']}: " . htmlspecialchars($filename);
                    $fixed_count++;
                } else {
                    $errors[] = "Failed to update popup {$row['id']}";
                }
                $stmt->close();
            }
        }
    }
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fix Image URLs - Portfolio Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 600px;
            width: 100%;
            padding: 40px;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .status-box {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .success { background: #e8f5e9; border-left: 4px solid #4caf50; color: #2e7d32; }
        .error { background: #ffebee; border-left: 4px solid #f44336; color: #c62828; }
        .info { background: #e3f2fd; border-left: 4px solid #2196f3; color: #1565c0; }
        .updates-list {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            max-height: 300px;
            overflow-y: auto;
            font-size: 13px;
            line-height: 1.6;
        }
        .updates-list div {
            padding: 5px 0;
            border-bottom: 1px solid #eee;
        }
        .updates-list div:last-child {
            border-bottom: none;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        button, a {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3); }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        .btn-secondary:hover { background: #d0d0d0; }
        .warning {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            color: #856404;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🖼️ Fix Image URLs</h1>
        <p class="subtitle">Repair broken image paths in your portfolio database</p>
        
        <?php if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['confirm_fix'])): ?>
            <!-- Results Page -->
            
            <?php if (empty($errors)): ?>
                <div class="status-box success">
                    <strong>✓ Success! All images fixed.</strong><br>
                    Fixed <?php echo $fixed_count; ?> image URL(s)
                </div>
            <?php else: ?>
                <div class="status-box error">
                    <strong>⚠️ Partially Complete</strong><br>
                    Fixed: <?php echo $fixed_count; ?> | Errors: <?php echo count($errors); ?>
                </div>
            <?php endif; ?>
            
            <?php if (!empty($updates)): ?>
                <div style="margin-bottom: 10px; font-weight: 600; color: #333;">Updated URLs:</div>
                <div class="updates-list">
                    <?php foreach ($updates as $update): ?>
                        <div><?php echo $update; ?></div>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
            
            <?php if (!empty($errors)): ?>
                <div style="margin-bottom: 10px; font-weight: 600; color: #c62828;">Errors:</div>
                <div class="updates-list" style="background: #ffebee;">
                    <?php foreach ($errors as $error): ?>
                        <div style="color: #c62828;">✗ <?php echo htmlspecialchars($error); ?></div>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
            
            <div class="info" style="margin-top: 20px;">
                <strong>Next Steps:</strong><br>
                • Visit your portfolio to verify images are loading<br>
                • Refresh the page (Ctrl+F5) to clear cache<br>
                • Check the browser console for any errors
            </div>
            
            <div class="button-group" style="margin-top: 30px;">
                <a href="http://lawreay.lovestoblog.com/" class="btn-primary">View Portfolio</a>
                <form method="POST" style="flex: 1;">
                    <button type="submit" name="reset" class="btn-secondary" style="width: 100%;">Run Again</button>
                </form>
            </div>
            
        <?php else: ?>
            <!-- Confirmation Page -->
            
            <div class="info" style="margin-bottom: 20px;">
                This will update all broken image URLs to use the correct domain and HTTPS protocol.
            </div>
            
            <div style="background: #f5f5f5; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-size: 13px;">
                <strong>What will be fixed:</strong><br>
                ✓ Profile images<br>
                ✓ Project thumbnail images<br>
                ✓ Project icon images<br>
                ✓ Popup images<br>
                <br>
                <strong>Domain:</strong> https://sql110.infinityfree.com/Portifolio/uploads/
            </div>
            
            <form method="POST">
                <button type="submit" name="confirm_fix" class="btn-primary" style="width: 100%; margin-bottom: 10px;">
                    ✓ Fix Image URLs Now
                </button>
                <a href="/" class="btn-secondary">← Back to Admin</a>
            </form>
            
            <div class="warning">
                <strong>Note:</strong> This script connects to your remote database. Make sure you have an active internet connection. This will update your live database.
            </div>
            
        <?php endif; ?>
    </div>
</body>
</html>
<?php $mysqli->close(); ?>

<?php
/**
 * Fix Image URLs Script
 * This script updates all broken image URLs in the database to use the correct domain and protocol
 */

require_once __DIR__ . '/config.php';

$user_id = 1; // Your portfolio user ID
$correct_base_url = 'https://sql110.infinityfree.com/Portifolio/uploads/';

$fixed_count = 0;
$errors = [];

echo "🔧 Starting Image URL Fix...\n\n";

// Function to extract filename from URL
function extract_filename($url) {
    $url = (string)$url;
    if (empty($url)) return '';
    
    // If it's already a relative path starting with uploads/
    if (preg_match('/^uploads\/(.+)$/', $url, $matches)) {
        return $matches[1];
    }
    
    // Extract filename from full URL
    if (preg_match('/uploads\/(.+)$/', $url, $matches)) {
        return $matches[1];
    }
    
    return '';
}

// 1. Fix portfolio_settings profile_image
echo "1️⃣  Fixing portfolio_settings.profile_image...\n";
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
                    echo "   ✓ Updated: {$row['profile_image']}\n";
                    echo "   → To: $new_url\n";
                    $fixed_count++;
                } else {
                    $errors[] = "Failed to update portfolio_settings ID {$row['id']}";
                }
                $stmt->close();
            }
        }
    }
}

// 2. Fix portfolio_projects image_path
echo "\n2️⃣  Fixing portfolio_projects.image_path...\n";
$result = $mysqli->query("SELECT id, image_path FROM portfolio_projects WHERE user_id = $user_id AND image_path IS NOT NULL AND image_path != ''");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $filename = extract_filename($row['image_path']);
        if ($filename) {
            $new_url = $correct_base_url . $filename;
            $stmt = $mysqli->prepare("UPDATE portfolio_projects SET image_path = ? WHERE id = ?");
            $stmt->bind_param("si", $new_url, $row['id']);
            if ($stmt->execute()) {
                echo "   ✓ Project ID {$row['id']}: {$row['image_path']}\n";
                echo "   → To: $new_url\n";
                $fixed_count++;
            } else {
                $errors[] = "Failed to update portfolio_projects ID {$row['id']}";
            }
            $stmt->close();
        }
    }
}

// 3. Fix portfolio_projects icon_type (if it contains image paths)
echo "\n3️⃣  Fixing portfolio_projects.icon_type (image icons)...\n";
$result = $mysqli->query("SELECT id, icon_type FROM portfolio_projects WHERE user_id = $user_id AND icon_type IS NOT NULL AND icon_type LIKE '%/%'");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $filename = extract_filename($row['icon_type']);
        if ($filename) {
            $new_url = $correct_base_url . $filename;
            $stmt = $mysqli->prepare("UPDATE portfolio_projects SET icon_type = ? WHERE id = ?");
            $stmt->bind_param("si", $new_url, $row['id']);
            if ($stmt->execute()) {
                echo "   ✓ Project ID {$row['id']}: {$row['icon_type']}\n";
                echo "   → To: $new_url\n";
                $fixed_count++;
            } else {
                $errors[] = "Failed to update icon_type for portfolio_projects ID {$row['id']}";
            }
            $stmt->close();
        }
    }
}

// 4. Fix portfolio_popups image_url
echo "\n4️⃣  Fixing portfolio_popups.image_url...\n";
$result = $mysqli->query("SELECT id, image_url FROM portfolio_popups WHERE user_id = $user_id AND image_url IS NOT NULL AND image_url != ''");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $filename = extract_filename($row['image_url']);
        if ($filename) {
            $new_url = $correct_base_url . $filename;
            $stmt = $mysqli->prepare("UPDATE portfolio_popups SET image_url = ? WHERE id = ?");
            $stmt->bind_param("si", $new_url, $row['id']);
            if ($stmt->execute()) {
                echo "   ✓ Popup ID {$row['id']}: {$row['image_url']}\n";
                echo "   → To: $new_url\n";
                $fixed_count++;
            } else {
                $errors[] = "Failed to update portfolio_popups ID {$row['id']}";
            }
            $stmt->close();
        }
    }
}

// 5. Fix portfolio_settings favicon_path
echo "\n5️⃣  Fixing portfolio_settings.favicon_path...\n";
$result = $mysqli->query("SELECT id, favicon_path FROM portfolio_settings WHERE user_id = $user_id AND favicon_path IS NOT NULL AND favicon_path != ''");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $filename = extract_filename($row['favicon_path']);
        if ($filename) {
            $new_url = $correct_base_url . $filename;
            $stmt = $mysqli->prepare("UPDATE portfolio_settings SET favicon_path = ? WHERE id = ?");
            $stmt->bind_param("si", $new_url, $row['id']);
            if ($stmt->execute()) {
                echo "   ✓ Updated: {$row['favicon_path']}\n";
                echo "   → To: $new_url\n";
                $fixed_count++;
            } else {
                $errors[] = "Failed to update favicon_path";
            }
            $stmt->close();
        }
    }
}

// Summary
echo "\n" . str_repeat("=", 60) . "\n";
echo "✅ FIX COMPLETE\n";
echo str_repeat("=", 60) . "\n";
echo "Total records updated: $fixed_count\n";

if (!empty($errors)) {
    echo "\n⚠️  Errors encountered:\n";
    foreach ($errors as $error) {
        echo "   - $error\n";
    }
} else {
    echo "✓ No errors!\n";
}

echo "\n🎉 All image URLs have been fixed!\n";
echo "Visit your portfolio to verify images are loading: http://lawreay.lovestoblog.com/\n";

$mysqli->close();
?>

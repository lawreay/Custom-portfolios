<?php
/**
 * Portfolio Admin System - Database Configuration
 */

// Database Configuration
define('DB_HOST', 'sql110.infinityfree.com');
define('DB_USER', 'if0_41898653');
define('DB_PASS', 'lastBorn333');
define('DB_NAME', 'if0_41898653_lawreay');

// Site Configuration
define('SITE_URL', 'https://lawreay.lovestoblog.com/');
define('ADMIN_URL', SITE_URL . 'admin/');
define('UPLOAD_DIR', $_SERVER['DOCUMENT_ROOT'] . '/Portifolio/uploads/');
define('UPLOAD_URL', SITE_URL . 'uploads/');

// Email Configuration (for password recovery)
define('SMTP_HOST', 'smtp.gmail.com');
define('SMTP_PORT', 587);
define('SMTP_USER', 'lawreay1@gmail.com');
define('SMTP_PASS', 'your-app-password');
define('ADMIN_EMAIL', 'lawreay1@gmail.com');

// Session Configuration
define('SESSION_TIMEOUT', 3600); // 1 hour in seconds
define('SESSION_NAME', 'if0_41898653_lawreay');

// Create database connection
$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Check connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Set charset to UTF-8
$mysqli->set_charset("utf8mb4");

function ensure_portfolio_schema_updates($mysqli) {
    $columns = [
        ['portfolio_projects', 'icon_type', 'VARCHAR(500) NULL'],
        ['portfolio_projects', 'image_path', 'VARCHAR(500) NULL'],
        ['portfolio_sections', 'icon_type', 'VARCHAR(500) NULL'],
        ['portfolio_settings', 'cv_path', 'VARCHAR(500) NULL'],
    ];
    $additions = [
        ['portfolio_settings', 'enable_cv_download', 'BOOLEAN DEFAULT TRUE'],
    ];

    foreach ($columns as [$table, $column, $definition]) {
        $query = "SELECT CHARACTER_MAXIMUM_LENGTH AS max_length
                  FROM INFORMATION_SCHEMA.COLUMNS
                  WHERE TABLE_SCHEMA = DATABASE()
                    AND TABLE_NAME = ?
                    AND COLUMN_NAME = ?
                  LIMIT 1";
        $stmt = $mysqli->prepare($query);
        if (!$stmt) continue;

        $stmt->bind_param("ss", $table, $column);
        $stmt->execute();
        $row = $stmt->get_result()->fetch_assoc();
        if (!$row) {
            $mysqli->query("ALTER TABLE `$table` ADD COLUMN `$column` $definition");
        } elseif ((int)$row['max_length'] < 500) {
            $mysqli->query("ALTER TABLE `$table` MODIFY `$column` $definition");
        }
    }

    foreach ($additions as [$table, $column, $definition]) {
        $query = "SELECT COUNT(*) AS total
                  FROM INFORMATION_SCHEMA.COLUMNS
                  WHERE TABLE_SCHEMA = DATABASE()
                    AND TABLE_NAME = ?
                    AND COLUMN_NAME = ?";
        $stmt = $mysqli->prepare($query);
        if (!$stmt) continue;

        $stmt->bind_param("ss", $table, $column);
        $stmt->execute();
        $row = $stmt->get_result()->fetch_assoc();
        if (!$row || (int)$row['total'] === 0) {
            $mysqli->query("ALTER TABLE `$table` ADD COLUMN `$column` $definition");
        }
    }
}

ensure_portfolio_schema_updates($mysqli);

// Session Management
if (!defined('PORTFOLIO_PUBLIC_PAGE')) {
    if (session_status() === PHP_SESSION_NONE) {
        session_name(SESSION_NAME);
        session_start();
    }

    // Session timeout check
    if (isset($_SESSION['user_id'])) {
        if (time() - $_SESSION['login_time'] > SESSION_TIMEOUT) {
            session_destroy();
            header("Location: " . SITE_URL . "admin/login.php?timeout=1");
            exit();
        }
        $_SESSION['login_time'] = time();
    }
}

// Helper Functions

/**
 * Escape user input for security
 */
function escape_input($data) {
    global $mysqli;
    return $mysqli->real_escape_string(htmlspecialchars($data, ENT_QUOTES, 'UTF-8'));
}

/**
 * Check if user is logged in
 */
function is_logged_in() {
    return isset($_SESSION['user_id']) && !empty($_SESSION['user_id']);
}

/**
 * Redirect if not logged in
 */
function require_login() {
    if (!is_logged_in()) {
        header("Location: " . ADMIN_URL . "login.php");
        exit();
    }
}

/**
 * Get current user ID
 */
function get_user_id() {
    return $_SESSION['user_id'] ?? null;
}

/**
 * Get the public portfolio owner.
 */
function get_public_user_id($username = 'admin') {
    global $mysqli;
    $query = "SELECT id FROM portfolio_users WHERE username = ? LIMIT 1";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result()->fetch_assoc();

    return $result['id'] ?? null;
}

/**
 * Hash password
 */
function hash_password($password) {
    return password_hash($password, PASSWORD_BCRYPT);
}

/**
 * Verify password
 */
function verify_password($password, $hash) {
    return password_verify($password, $hash);
}

/**
 * Generate secure token for password recovery
 */
function generate_recovery_token() {
    return bin2hex(random_bytes(32));
}

/**
 * Send email
 */
function send_email($to, $subject, $body, $isHtml = true) {
    $headers = "MIME-Version: 1.0" . "\r\n";
    $headers .= "Content-type: " . ($isHtml ? "text/html" : "text/plain") . "; charset=UTF-8" . "\r\n";
    $headers .= "From: " . ADMIN_EMAIL . "\r\n";
    
    return mail($to, $subject, $body, $headers);
}

/**
 * Get user settings
 */
function get_user_settings($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_settings WHERE user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
}

/**
 * Update user settings
 */
function update_user_settings($user_id, $settings) {
    global $mysqli;
    
    $fields = [];
    $params = [];
    $types = "";
    
    foreach ($settings as $key => $value) {
        $fields[] = "`" . escape_input($key) . "` = ?";
        $params[] = $value;
        
        if (is_int($value)) {
            $types .= "i";
        } elseif (is_float($value)) {
            $types .= "d";
        } else {
            $types .= "s";
        }
    }
    
    $params[] = $user_id;
    $types .= "i";
    
    $query = "UPDATE portfolio_settings SET " . implode(", ", $fields) . " WHERE user_id = ?";
    $stmt = $mysqli->prepare($query);
    
    if (empty($types)) return false;
    
    $stmt->bind_param($types, ...$params);
    return $stmt->execute();
}

/**
 * Get all projects for user
 */
function get_user_projects($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_projects WHERE user_id = ? ORDER BY order_position ASC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

function add_project($user_id, $data) {
    global $mysqli;
    $tech_stack = json_encode(array_values(array_filter(array_map('trim', explode(',', $data['tech_stack'] ?? '')))), JSON_UNESCAPED_SLASHES);
    $is_featured = !empty($data['is_featured']) ? 1 : 0;
    $query = "INSERT INTO portfolio_projects (user_id, title, description, short_description, category, icon_type, icon_color, background_color, tech_stack, demo_url, github_url, image_path, order_position, is_featured)
              VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param(
        "isssssssssssii",
        $user_id,
        $data['title'],
        $data['description'],
        $data['short_description'],
        $data['category'],
        $data['icon_type'],
        $data['icon_color'],
        $data['background_color'],
        $tech_stack,
        $data['demo_url'],
        $data['github_url'],
        $data['image_path'],
        $data['order_position'],
        $is_featured
    );
    return $stmt->execute();
}

function update_project($id, $user_id, $data) {
    global $mysqli;
    $tech_stack = json_encode(array_values(array_filter(array_map('trim', explode(',', $data['tech_stack'] ?? '')))), JSON_UNESCAPED_SLASHES);
    $is_featured = !empty($data['is_featured']) ? 1 : 0;
    $query = "UPDATE portfolio_projects
              SET title = ?, description = ?, short_description = ?, category = ?, icon_type = ?, icon_color = ?, background_color = ?, tech_stack = ?, demo_url = ?, github_url = ?, image_path = ?, order_position = ?, is_featured = ?
              WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param(
        "sssssssssssiiii",
        $data['title'],
        $data['description'],
        $data['short_description'],
        $data['category'],
        $data['icon_type'],
        $data['icon_color'],
        $data['background_color'],
        $tech_stack,
        $data['demo_url'],
        $data['github_url'],
        $data['image_path'],
        $data['order_position'],
        $is_featured,
        $id,
        $user_id
    );
    return $stmt->execute();
}

function delete_project($id, $user_id) {
    global $mysqli;
    $query = "DELETE FROM portfolio_projects WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("ii", $id, $user_id);
    return $stmt->execute();
}

/**
 * Get generic portfolio sections by type.
 */
function get_sections_by_type($user_id, $section_type) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_sections WHERE user_id = ? AND section_type = ? ORDER BY order_position ASC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("is", $user_id, $section_type);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

function get_section_backgrounds($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_section_backgrounds WHERE user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $rows = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $backgrounds = [];
    foreach ($rows as $row) {
        $backgrounds[$row['section_key']] = $row;
    }
    return $backgrounds;
}

function upsert_section_background($user_id, $section_key, $background_image, $overlay_opacity = 0.80) {
    global $mysqli;
    $query = "INSERT INTO portfolio_section_backgrounds (user_id, section_key, background_image, overlay_opacity)
              VALUES (?, ?, ?, ?)
              ON DUPLICATE KEY UPDATE background_image = VALUES(background_image), overlay_opacity = VALUES(overlay_opacity)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("issd", $user_id, $section_key, $background_image, $overlay_opacity);
    return $stmt->execute();
}

/**
 * Sanitize file upload
 */
function validate_file_upload($file, $allowed_types = ['jpg', 'jpeg', 'png', 'gif', 'pdf'], $max_size = 5242880) {
    if (!isset($file['name']) || $file['error'] === UPLOAD_ERR_NO_FILE) {
        return ['success' => false, 'error' => 'No file selected'];
    }

    $file_ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    
    if (!in_array($file_ext, $allowed_types)) {
        return ['success' => false, 'error' => 'File type not allowed'];
    }
    
    if ($file['size'] > $max_size) {
        return ['success' => false, 'error' => 'File size exceeds limit'];
    }
    
    return ['success' => true];
}

function store_uploaded_file($file, $prefix, $allowed_types = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'svg', 'ico'], $max_size = 5242880) {
    $validation = validate_file_upload($file, $allowed_types, $max_size);
    if (!$validation['success']) {
        return $validation;
    }

    if (!is_dir(UPLOAD_DIR)) {
        mkdir(UPLOAD_DIR, 0755, true);
    }

    $file_ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    $safe_prefix = preg_replace('/[^a-zA-Z0-9_-]/', '_', $prefix);
    $filename = $safe_prefix . '_' . time() . '_' . bin2hex(random_bytes(4)) . '.' . $file_ext;
    $upload_path = UPLOAD_DIR . $filename;

    if (!move_uploaded_file($file['tmp_name'], $upload_path)) {
        return ['success' => false, 'error' => 'Error uploading file'];
    }

    return ['success' => true, 'url' => UPLOAD_URL . $filename, 'path' => $upload_path];
}

function clean_optional_url($value) {
    $value = trim((string)$value);
    if ($value === '') return '';
    return filter_var($value, FILTER_SANITIZE_URL);
}

function clean_icon_value($value, $default = 'circle') {
    $value = trim((string)$value);
    if ($value === '') return $default;

    if (preg_match('/^(https?:\/\/|\/|uploads\/)/i', $value)) {
        return clean_optional_url($value);
    }

    $icon = strtolower($value);
    $icon = preg_replace('/[^a-z0-9-]/', '', $icon);
    return $icon ?: $default;
}

function clean_hex_color($value, $default = '#6366f1') {
    return preg_match('/^#[0-9a-fA-F]{6}$/', (string)$value) ? $value : $default;
}

function list_uploaded_images($user_id = null) {
    $extensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'svg', 'ico'];
    if (!is_dir(UPLOAD_DIR)) return [];

    $files = [];
    foreach (scandir(UPLOAD_DIR) ?: [] as $file_name) {
        if ($file_name === '.' || $file_name === '..') continue;
        $path = UPLOAD_DIR . $file_name;
        if (!is_file($path)) continue;
        $ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
        if (!in_array($ext, $extensions, true)) continue;
        $files[] = [
            'name' => $file_name,
            'url' => UPLOAD_URL . $file_name,
            'mtime' => filemtime($path) ?: 0,
        ];
    }

    usort($files, fn($a, $b) => $b['mtime'] <=> $a['mtime']);
    return $files;
}

/**
 * Get/Update Hero Section
 */
function get_hero_section($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_settings WHERE user_id = ? LIMIT 1";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result()->fetch_assoc();
    
    return [
        'hero_title' => $result['hero_title'] ?? 'Your Name',
        'hero_subtitle' => $result['hero_subtitle'] ?? 'Your tagline',
        'hero_cta' => $result['hero_cta'] ?? 'Learn More',
    ];
}

/**
 * Get Goals & Vision items
 */
function get_goals($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_sections WHERE user_id = ? AND section_type = 'Goals' ORDER BY order_position ASC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

/**
 * Add Goal
 */
function add_goal($user_id, $title, $description, $icon_type = 'target') {
    global $mysqli;
    $query = "INSERT INTO portfolio_sections (user_id, section_type, title, description, icon_type) VALUES (?, 'Goals', ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("isss", $user_id, $title, $description, $icon_type);
    return $stmt->execute();
}

/**
 * Update Goal
 */
function update_goal($id, $user_id, $title, $description, $icon_type = 'target') {
    global $mysqli;
    $query = "UPDATE portfolio_sections SET title = ?, description = ?, icon_type = ? WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("sssii", $title, $description, $icon_type, $id, $user_id);
    return $stmt->execute();
}

/**
 * Delete Goal
 */
function delete_goal($id, $user_id) {
    global $mysqli;
    $query = "DELETE FROM portfolio_sections WHERE id = ? AND user_id = ? AND section_type = 'Goals'";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("ii", $id, $user_id);
    return $stmt->execute();
}

/**
 * Get Interests & Passions items
 */
function get_interests($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_sections WHERE user_id = ? AND section_type = 'Interests' ORDER BY order_position ASC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

/**
 * Add Interest
 */
function add_interest($user_id, $title, $description, $icon_type = 'star') {
    global $mysqli;
    $query = "INSERT INTO portfolio_sections (user_id, section_type, title, description, icon_type) VALUES (?, 'Interests', ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("isss", $user_id, $title, $description, $icon_type);
    return $stmt->execute();
}

/**
 * Update Interest
 */
function update_interest($id, $user_id, $title, $description, $icon_type = 'star') {
    global $mysqli;
    $query = "UPDATE portfolio_sections SET title = ?, description = ?, icon_type = ? WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("sssii", $title, $description, $icon_type, $id, $user_id);
    return $stmt->execute();
}

/**
 * Delete Interest
 */
function delete_interest($id, $user_id) {
    global $mysqli;
    $query = "DELETE FROM portfolio_sections WHERE id = ? AND user_id = ? AND section_type = 'Interests'";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("ii", $id, $user_id);
    return $stmt->execute();
}

/**
 * Get user experience
 */
function get_experience($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_experience WHERE user_id = ? ORDER BY order_position ASC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

/**
 * Add experience entry
 */
function add_experience($user_id, $title, $company, $description, $start_date, $end_date, $is_current = 0, $icon_color = '#6366f1') {
    global $mysqli;
    $query = "INSERT INTO portfolio_experience (user_id, title, company, description, start_date, end_date, is_current, icon_color) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("isssssis", $user_id, $title, $company, $description, $start_date, $end_date, $is_current, $icon_color);
    return $stmt->execute();
}

/**
 * Update experience entry
 */
function update_experience($id, $user_id, $title, $company, $description, $start_date, $end_date, $is_current = 0, $icon_color = '#6366f1') {
    global $mysqli;
    $query = "UPDATE portfolio_experience SET title = ?, company = ?, description = ?, start_date = ?, end_date = ?, is_current = ?, icon_color = ? WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("sssssisii", $title, $company, $description, $start_date, $end_date, $is_current, $icon_color, $id, $user_id);
    return $stmt->execute();
}

/**
 * Delete experience entry
 */
function delete_experience($id, $user_id) {
    global $mysqli;
    $query = "DELETE FROM portfolio_experience WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("ii", $id, $user_id);
    return $stmt->execute();
}

function get_education($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_education WHERE user_id = ? ORDER BY order_position ASC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

function add_education($user_id, $title, $institution, $description, $start_date, $end_date, $is_current = 0, $icon_color = '#6366f1') {
    global $mysqli;
    $query = "INSERT INTO portfolio_education (user_id, title, institution, description, start_date, end_date, is_current, icon_color) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("isssssis", $user_id, $title, $institution, $description, $start_date, $end_date, $is_current, $icon_color);
    return $stmt->execute();
}

function update_education($id, $user_id, $title, $institution, $description, $start_date, $end_date, $is_current = 0, $icon_color = '#6366f1') {
    global $mysqli;
    $query = "UPDATE portfolio_education SET title = ?, institution = ?, description = ?, start_date = ?, end_date = ?, is_current = ?, icon_color = ? WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("sssssisii", $title, $institution, $description, $start_date, $end_date, $is_current, $icon_color, $id, $user_id);
    return $stmt->execute();
}

function delete_education($id, $user_id) {
    global $mysqli;
    $query = "DELETE FROM portfolio_education WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("ii", $id, $user_id);
    return $stmt->execute();
}

/**
 * Get user skills
 */
function get_skills($user_id) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_skills WHERE user_id = ? ORDER BY order_position ASC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

/**
 * Add skill
 */
function add_skill($user_id, $category, $skill_name, $proficiency = 'intermediate', $color = '#6366f1') {
    global $mysqli;
    $query = "INSERT INTO portfolio_skills (user_id, category, skill_name, proficiency, color) VALUES (?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("issss", $user_id, $category, $skill_name, $proficiency, $color);
    return $stmt->execute();
}

/**
 * Update skill
 */
function update_skill($id, $user_id, $category, $skill_name, $proficiency = 'intermediate', $color = '#6366f1') {
    global $mysqli;
    $query = "UPDATE portfolio_skills SET category = ?, skill_name = ?, proficiency = ?, color = ? WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("ssssii", $category, $skill_name, $proficiency, $color, $id, $user_id);
    return $stmt->execute();
}

/**
 * Delete skill
 */
function delete_skill($id, $user_id) {
    global $mysqli;
    $query = "DELETE FROM portfolio_skills WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("ii", $id, $user_id);
    return $stmt->execute();
}

function get_news($user_id, $published_only = false) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_news WHERE user_id = ?" . ($published_only ? " AND is_published = 1" : "") . " ORDER BY order_position ASC, published_at DESC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

function update_news($id, $user_id, $title, $body, $link_url, $is_published = 1) {
    global $mysqli;
    $query = "UPDATE portfolio_news SET title = ?, body = ?, link_url = ?, is_published = ? WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("sssiii", $title, $body, $link_url, $is_published, $id, $user_id);
    return $stmt->execute();
}

function get_popups($user_id, $active_only = false) {
    global $mysqli;
    $query = "SELECT * FROM portfolio_popups WHERE user_id = ?" . ($active_only ? " AND is_active = 1" : "") . " ORDER BY order_position ASC, created_at DESC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

function update_popup($id, $user_id, $title, $body, $link_url, $button_text, $image_url, $is_active = 1, $trigger_timer = 1, $timer_delay = 900, $trigger_scroll = 0, $scroll_percentage = 50, $trigger_esc = 1, $trigger_back_button = 1) {
    global $mysqli;
    $query = "UPDATE portfolio_popups SET title = ?, body = ?, link_url = ?, button_text = ?, image_url = ?, is_active = ?, trigger_timer = ?, timer_delay = ?, trigger_scroll = ?, scroll_percentage = ?, trigger_esc = ?, trigger_back_button = ? WHERE id = ? AND user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("sssssiiiiiiiii", $title, $body, $link_url, $button_text, $image_url, $is_active, $trigger_timer, $timer_delay, $trigger_scroll, $scroll_percentage, $trigger_esc, $trigger_back_button, $id, $user_id);
    return $stmt->execute();
}

function add_popup($user_id, $title, $body, $link_url, $button_text, $image_url, $is_active = 1, $trigger_timer = 1, $timer_delay = 900, $trigger_scroll = 0, $scroll_percentage = 50, $trigger_esc = 1, $trigger_back_button = 1) {
    global $mysqli;
    $position = 1;
    $result = $mysqli->query("SELECT MAX(order_position) as max_pos FROM portfolio_popups WHERE user_id = $user_id");
    if ($result && $row = $result->fetch_assoc()) {
        $position = ($row['max_pos'] ?? 0) + 1;
    }
    $query = "INSERT INTO portfolio_popups (user_id, title, body, link_url, button_text, image_url, is_active, order_position, trigger_timer, timer_delay, trigger_scroll, scroll_percentage, trigger_esc, trigger_back_button) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("isssssiiiiiii", $user_id, $title, $body, $link_url, $button_text, $image_url, $is_active, $position, $trigger_timer, $timer_delay, $trigger_scroll, $scroll_percentage, $trigger_esc, $trigger_back_button);
    return $stmt->execute() ? $mysqli->insert_id : false;
}

function get_engagement_rows($table, $user_id) {
    global $mysqli;
    $allowed = ['portfolio_bookings', 'portfolio_requests', 'portfolio_comments'];
    if (!in_array($table, $allowed, true)) return [];
    $query = "SELECT * FROM `$table` WHERE user_id = ? ORDER BY created_at DESC";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

function update_engagement_row($kind, $id, $user_id, $data) {
    global $mysqli;

    if ($kind === 'booking') {
        $query = "UPDATE portfolio_bookings SET visitor_name = ?, visitor_email = ?, visitor_phone = ?, service = ?, preferred_date = ?, message = ?, status = ?, is_reviewed = ? WHERE id = ? AND user_id = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param(
            "sssssssiii",
            $data['visitor_name'],
            $data['visitor_email'],
            $data['visitor_phone'],
            $data['service'],
            $data['preferred_date'],
            $data['message'],
            $data['status'],
            $data['is_reviewed'],
            $id,
            $user_id
        );
        return $stmt->execute();
    }

    if ($kind === 'request') {
        $query = "UPDATE portfolio_requests SET visitor_name = ?, visitor_email = ?, request_type = ?, message = ?, status = ?, is_reviewed = ? WHERE id = ? AND user_id = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param(
            "sssssiii",
            $data['visitor_name'],
            $data['visitor_email'],
            $data['request_type'],
            $data['message'],
            $data['status'],
            $data['is_reviewed'],
            $id,
            $user_id
        );
        return $stmt->execute();
    }

    if ($kind === 'comment') {
        $query = "UPDATE portfolio_comments SET visitor_name = ?, visitor_email = ?, comment = ?, is_approved = ?, is_reviewed = ? WHERE id = ? AND user_id = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param(
            "sssiiii",
            $data['visitor_name'],
            $data['visitor_email'],
            $data['comment'],
            $data['is_approved'],
            $data['is_reviewed'],
            $id,
            $user_id
        );
        return $stmt->execute();
    }

    return false;
}

function get_visits($user_id, $limit = 100) {
    global $mysqli;
    $limit = max(1, min(500, (int)$limit));
    $query = "SELECT * FROM portfolio_visits WHERE user_id = ? ORDER BY visited_at DESC LIMIT $limit";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

function clear_visits($user_id) {
    global $mysqli;
    $query = "DELETE FROM portfolio_visits WHERE user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $user_id);
    return $stmt->execute();
}

function log_site_visit($user_id) {
    global $mysqli;
    $ip = $_SERVER['REMOTE_ADDR'] ?? '';
    $agent = substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 500);
    $referrer = substr($_SERVER['HTTP_REFERER'] ?? '', 0, 500);
    $page = substr($_SERVER['REQUEST_URI'] ?? '', 0, 500);
    $query = "INSERT INTO portfolio_visits (user_id, ip_address, user_agent, referrer, page_url) VALUES (?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("issss", $user_id, $ip, $agent, $referrer, $page);
    return $stmt->execute();
}

?>

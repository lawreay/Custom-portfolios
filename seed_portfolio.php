<?php
/**
 * Clears the admin user's portfolio content and seeds the homepage data.
 * Run from browser or CLI after database_schema.sql has created the base tables.
 */

define('PORTFOLIO_PUBLIC_PAGE', true);
require_once __DIR__ . '/config.php';

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

function column_exists($table, $column) {
    global $mysqli;
    $query = "SELECT COUNT(*) AS total
              FROM INFORMATION_SCHEMA.COLUMNS
              WHERE TABLE_SCHEMA = DATABASE()
                AND TABLE_NAME = ?
                AND COLUMN_NAME = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param('ss', $table, $column);
    $stmt->execute();
    $row = $stmt->get_result()->fetch_assoc();
    return (int)$row['total'] > 0;
}

function add_column_if_missing($table, $column, $definition) {
    global $mysqli;
    if (!column_exists($table, $column)) {
        $mysqli->query("ALTER TABLE `$table` ADD COLUMN `$column` $definition");
        echo "Added column `$column` to `$table`.<br>";
    }
}

function ensure_feature_tables() {
    global $mysqli;

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_section_backgrounds` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `section_key` VARCHAR(50) NOT NULL,
        `background_image` VARCHAR(500),
        `overlay_opacity` DECIMAL(3,2) DEFAULT 0.80,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        UNIQUE KEY `unique_user_section_background` (`user_id`, `section_key`),
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_education` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `title` VARCHAR(255) NOT NULL,
        `institution` VARCHAR(255) NOT NULL,
        `description` LONGTEXT,
        `start_date` DATE,
        `end_date` DATE,
        `is_current` BOOLEAN DEFAULT FALSE,
        `icon_color` VARCHAR(7),
        `order_position` INT DEFAULT 0,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_bookings` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `visitor_name` VARCHAR(100),
        `visitor_email` VARCHAR(100),
        `visitor_phone` VARCHAR(30),
        `service` VARCHAR(150),
        `preferred_date` DATE,
        `message` LONGTEXT,
        `status` VARCHAR(30) DEFAULT 'new',
        `is_reviewed` BOOLEAN DEFAULT FALSE,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_requests` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `visitor_name` VARCHAR(100),
        `visitor_email` VARCHAR(100),
        `request_type` VARCHAR(150),
        `message` LONGTEXT,
        `status` VARCHAR(30) DEFAULT 'new',
        `is_reviewed` BOOLEAN DEFAULT FALSE,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_comments` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `visitor_name` VARCHAR(100),
        `visitor_email` VARCHAR(100),
        `comment` LONGTEXT,
        `is_approved` BOOLEAN DEFAULT TRUE,
        `is_reviewed` BOOLEAN DEFAULT FALSE,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_news` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `title` VARCHAR(255) NOT NULL,
        `body` LONGTEXT,
        `link_url` VARCHAR(500),
        `is_published` BOOLEAN DEFAULT TRUE,
        `published_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
        `order_position` INT DEFAULT 0,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_visits` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `ip_address` VARCHAR(45),
        `user_agent` VARCHAR(500),
        `referrer` VARCHAR(500),
        `page_url` VARCHAR(500),
        `visited_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");

    $mysqli->query("CREATE TABLE IF NOT EXISTS `portfolio_popups` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL,
        `title` VARCHAR(255),
        `body` LONGTEXT,
        `link_url` VARCHAR(500),
        `button_text` VARCHAR(100),
        `image_url` VARCHAR(500),
        `is_active` BOOLEAN DEFAULT TRUE,
        `start_at` DATETIME,
        `end_at` DATETIME,
        `order_position` INT DEFAULT 0,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (`user_id`) REFERENCES `portfolio_users`(`id`) ON DELETE CASCADE
    )");
}

function seed_setting_row($user_id) {
    global $mysqli;
    $stmt = $mysqli->prepare("SELECT id FROM portfolio_settings WHERE user_id = ? LIMIT 1");
    $stmt->bind_param('i', $user_id);
    $stmt->execute();

    if (!$stmt->get_result()->fetch_assoc()) {
        $insert = $mysqli->prepare("INSERT INTO portfolio_settings (user_id) VALUES (?)");
        $insert->bind_param('i', $user_id);
        $insert->execute();
    }
}

function update_settings($user_id, $settings) {
    global $mysqli;
    $assignments = [];
    $values = [];
    $types = '';

    foreach ($settings as $key => $value) {
        $assignments[] = "`$key` = ?";
        $values[] = $value;
        $types .= is_int($value) ? 'i' : 's';
    }

    $values[] = $user_id;
    $types .= 'i';

    $query = "UPDATE portfolio_settings SET " . implode(', ', $assignments) . " WHERE user_id = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param($types, ...$values);
    $stmt->execute();
}

function insert_section($user_id, $type, $title, $description, $icon, $position) {
    global $mysqli;
    $stmt = $mysqli->prepare("INSERT INTO portfolio_sections (user_id, section_type, title, description, icon_type, order_position) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('issssi', $user_id, $type, $title, $description, $icon, $position);
    $stmt->execute();
}

function insert_experience($user_id, $title, $company, $description, $start, $end, $current, $color, $position) {
    global $mysqli;
    $stmt = $mysqli->prepare("INSERT INTO portfolio_experience (user_id, title, company, description, start_date, end_date, is_current, icon_color, order_position) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('isssssisi', $user_id, $title, $company, $description, $start, $end, $current, $color, $position);
    $stmt->execute();
}

function insert_project($user_id, $project, $position) {
    global $mysqli;
    $tech_stack = json_encode($project['tech_stack'], JSON_UNESCAPED_SLASHES);
    $is_featured = 1;
    $stmt = $mysqli->prepare("INSERT INTO portfolio_projects (user_id, title, description, short_description, category, icon_type, icon_color, background_color, tech_stack, demo_url, github_url, order_position, is_featured) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param(
        'issssssssssii',
        $user_id,
        $project['title'],
        $project['description'],
        $project['short_description'],
        $project['category'],
        $project['icon_type'],
        $project['icon_color'],
        $project['background_color'],
        $tech_stack,
        $project['demo_url'],
        $project['github_url'],
        $position,
        $is_featured
    );
    $stmt->execute();
}

function insert_skill($user_id, $category, $name, $proficiency, $color, $position) {
    global $mysqli;
    $stmt = $mysqli->prepare("INSERT INTO portfolio_skills (user_id, category, skill_name, proficiency, color, order_position) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('issssi', $user_id, $category, $name, $proficiency, $color, $position);
    $stmt->execute();
}

function insert_education($user_id, $title, $institution, $description, $start, $end, $current, $color, $position) {
    global $mysqli;
    $stmt = $mysqli->prepare("INSERT INTO portfolio_education (user_id, title, institution, description, start_date, end_date, is_current, icon_color, order_position) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('isssssisi', $user_id, $title, $institution, $description, $start, $end, $current, $color, $position);
    $stmt->execute();
}

function insert_news($user_id, $title, $body, $link, $published, $position) {
    global $mysqli;
    $stmt = $mysqli->prepare("INSERT INTO portfolio_news (user_id, title, body, link_url, is_published, order_position) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('isssii', $user_id, $title, $body, $link, $published, $position);
    $stmt->execute();
}

function insert_popup($user_id, $title, $body, $link, $button, $active, $position, $trigger_timer = 1, $timer_delay = 900, $trigger_scroll = 0, $scroll_percentage = 50, $trigger_esc = 1, $trigger_back_button = 1) {
    global $mysqli;
    $stmt = $mysqli->prepare("INSERT INTO portfolio_popups (user_id, title, body, link_url, button_text, is_active, order_position, trigger_timer, timer_delay, trigger_scroll, scroll_percentage, trigger_esc, trigger_back_button) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('isssssiiiiiii', $user_id, $title, $body, $link, $button, $active, $position, $trigger_timer, $timer_delay, $trigger_scroll, $scroll_percentage, $trigger_esc, $trigger_back_button);
    $stmt->execute();
}

ensure_feature_tables();

$settings_columns = [
    'brand_name' => "VARCHAR(100) DEFAULT 'LAWREAY'",
    'hero_kicker' => "VARCHAR(255) DEFAULT 'Creative Technologist | Developer | Builder'",
    'hero_title' => "VARCHAR(255) DEFAULT 'Lawrence Phuka Chikapa'",
    'hero_subtitle' => "VARCHAR(255) DEFAULT 'Empowering Malawi Through Digital Innovation'",
    'hero_cta' => "VARCHAR(100) DEFAULT 'Learn More'",
    'about_title' => "VARCHAR(100) DEFAULT 'About Me'",
    'about_text' => 'LONGTEXT',
    'about_secondary' => 'LONGTEXT',
    'full_name' => 'VARCHAR(150)',
    'home_origin' => 'VARCHAR(100)',
    'nationality' => 'VARCHAR(100)',
    'religion' => 'VARCHAR(100)',
    'status' => 'VARCHAR(100)',
    'vision' => 'LONGTEXT',
    'github_url' => 'VARCHAR(500)',
    'contact_intro' => 'LONGTEXT',
    'profile_image' => 'VARCHAR(500)',
    'favicon_path' => 'VARCHAR(500)',
    'enable_news' => 'BOOLEAN DEFAULT TRUE',
];

foreach ($settings_columns as $column => $definition) {
    add_column_if_missing('portfolio_settings', $column, $definition);
}

// Add popup trigger columns if they don't exist
$popup_trigger_columns = [
    'trigger_timer' => 'BOOLEAN DEFAULT TRUE',
    'timer_delay' => 'INT DEFAULT 900',
    'trigger_scroll' => 'BOOLEAN DEFAULT FALSE',
    'scroll_percentage' => 'INT DEFAULT 50',
    'trigger_esc' => 'BOOLEAN DEFAULT TRUE',
    'trigger_back_button' => 'BOOLEAN DEFAULT TRUE',
];

foreach ($popup_trigger_columns as $column => $definition) {
    add_column_if_missing('portfolio_popups', $column, $definition);
}

$user = $mysqli->query("SELECT id FROM portfolio_users WHERE username = 'admin' LIMIT 1")->fetch_assoc();
if (!$user) {
    $password = password_hash('admin123', PASSWORD_BCRYPT);
    $stmt = $mysqli->prepare("INSERT INTO portfolio_users (username, email, password, full_name) VALUES ('admin', 'lawreay1@gmail.com', ?, 'Lawrence Phuka Chikapa')");
    $stmt->bind_param('s', $password);
    $stmt->execute();
    $user_id = $mysqli->insert_id;
} else {
    $user_id = (int)$user['id'];
}

seed_setting_row($user_id);

$mysqli->begin_transaction();

$clear_tables = [
    'portfolio_projects',
    'portfolio_experience',
    'portfolio_education',
    'portfolio_skills',
    'portfolio_sections',
    'portfolio_section_backgrounds',
    'portfolio_news',
    'portfolio_popups',
];

foreach ($clear_tables as $table) {
    $stmt = $mysqli->prepare("DELETE FROM `$table` WHERE user_id = ?");
    $stmt->bind_param('i', $user_id);
    $stmt->execute();
}

update_settings($user_id, [
    'brand_name' => 'LAWREAY',
    'hero_kicker' => 'ICT Educator & Creative Technologist',
    'hero_title' => 'Lawrence Phuka Chikapa',
    'hero_subtitle' => 'Empowering Malawi Through Digital Innovation',
    'hero_cta' => 'Learn More',
    'about_title' => 'About Me',
    'about_text' => "I'm Lawrence Phuka Chikapa, founder of Learn360 - a free digital education platform dedicated to empowering underserved communities across Malawi. With a deep passion for accessible education, creative design, and local empowerment, I combine technical expertise with a vision for social impact.",
    'about_secondary' => 'As an ICT educator, I bridge the gap between technology and education, creating innovative solutions that make quality learning accessible to all Malawians, regardless of their economic background.',
    'full_name' => 'Lawrence Phuka Chikapa',
    'home_origin' => 'Ntcheu',
    'nationality' => 'Malawian',
    'religion' => 'Christian',
    'status' => 'Single',
    'vision' => 'My vision is to scale Learn360 into a national hub for free digital learning, reaching every corner of Malawi. By leveraging technology, partnerships, and community engagement, I aim to democratize access to quality education and empower the next generation of Malawian innovators.',
    'bio' => 'Founder of Learn360 - empowering Malawi through digital innovation',
    'location' => 'Ntcheu, Malawi',
    'email' => 'lawreay1@gmail.com',
    'whatsapp' => '+265 993 147 700',
    'github_url' => 'https://github.com/lawreay',
    'contact_intro' => "Interested in collaboration, partnerships, or learning more about Learn360? I'd love to hear from you!",
    'profile_image' => '',
    'favicon_path' => '',
    'enable_news' => 1,
    'background_color' => '#0a0a0f',
    'surface_color' => '#18181b',
    'text_color' => '#e4e4e7',
    'primary_action_color' => '#6366f1',
    'secondary_action_color' => '#ec4899',
    'accent_color' => '#22c55e',
    'font_family' => 'Syne',
    'font_size' => 16,
    'enable_animations' => 1,
    'cursor_animation' => 'default',
]);

$goals = [
    ['Scale Learn360 Nationally', 'Build Learn360 into a comprehensive national hub for free digital learning, reaching every corner of Malawi with quality education content and interactive learning experiences.', 'target'],
    ['Feature-Rich Music Player', 'Deliver a visually refined, feature-complete music player for Smart Music Malawi with downloads, lyrics, EQ, visualizer, and pro subscription functionality.', 'music'],
    ['Master Backend Integration', 'Solve backend and database challenges with InfinityFree hosting, MySQL schema optimization, and seamless integration across platforms.', 'database'],
];

foreach ($goals as $index => $goal) {
    insert_section($user_id, 'Goals', $goal[0], $goal[1], $goal[2], $index + 1);
}

$interests = [
    ['Music Technology', 'Deep engagement with music player development, audio processing, and creating immersive listening experiences. Focused on streaming technologies and smart playback features.', 'music'],
    ['UI/UX Refinement', 'Passionate about visual consistency, accessibility, and iterative design. Creating intuitive interfaces that balance aesthetics with functionality.', 'layout-template'],
    ['Backend Solutions', 'Interested in database troubleshooting, backend integration, and solving complex technical challenges with practical, scalable solutions.', 'server'],
    ['Emerging Tech', 'Exploring AI tools, cloud computing, and streaming technologies to enhance educational platforms and user experiences.', 'sparkles'],
];

foreach ($interests as $index => $interest) {
    insert_section($user_id, 'Interests', $interest[0], $interest[1], $interest[2], $index + 1);
}

$challenges = [
    ['Database Access & Schema Issues', 'Resolved access denied errors caused by database prefix mismatches. Implemented iterative schema corrections and optimization strategies for InfinityFree hosting environments.', 'database'],
    ['Iterative UI Refinement', 'Successfully enhanced the music player app through multiple design iterations, improving visual consistency, user experience, and accessibility while maintaining performance.', 'palette'],
    ['Customizable Admin Panels', 'Designed and built flexible admin panels for course-selling platforms, enabling institutional partners to customize their learning environment with minimal technical expertise.', 'settings'],
];

foreach ($challenges as $index => $challenge) {
    insert_section($user_id, 'Challenges', $challenge[0], $challenge[1], $challenge[2], $index + 1);
}

$partnerships = [
    ['Sister: Accomplished Entrepreneur', 'My sister is an experienced businesswoman with expertise in retail management, salon operations, cosmetics business, inventory management, customer service excellence, and entrepreneurship. Her business acumen and customer-centric approach inspire my work, and together we explore opportunities in combining technology with practical business expertise.', 'users'],
];

foreach ($partnerships as $index => $partner) {
    insert_section($user_id, 'Partnerships', $partner[0], $partner[1], $partner[2], $index + 1);
}

$experience = [
    ['Founder & Lead Developer', 'Learn360 Platform', 'Built and maintain a comprehensive free digital education platform serving underserved Malawian communities. Developed curriculum, created multimedia content, and established partnerships for sustainable growth.', '2025-08-01', null, 1, '#6366f1'],
    ['Junior IT Assistant & Technical Support', 'Malawi Adventist University', 'Provide technical leadership, network security management, and educational technology support. Train faculty and students in digital tools while maintaining critical IT infrastructure.', '2025-01-01', null, 1, '#ec4899'],
    ['Creative Technologist', 'Freelance & Community Projects', 'Design and develop websites, create educational animations, and produce multimedia content for local organizations and educational initiatives across Malawi.', '2025-06-01', null, 1, '#fbbf24'],
];

foreach ($experience as $index => $item) {
    insert_experience($user_id, $item[0], $item[1], $item[2], $item[3], $item[4], $item[5], $item[6], $index + 1);
}

$education = [
    ['Bachelor of Science in ICT', 'Malawi Adventist University', 'Focused on information systems, networking, database-driven applications, web development, and educational technology practice.', '2022-01-01', null, 1, '#6366f1'],
    ['ICT Education & Technical Support Practice', 'Professional Development', 'Ongoing hands-on growth through support work, platform building, curriculum creation, and community technology projects.', '2025-01-01', null, 1, '#22c55e'],
];

foreach ($education as $index => $item) {
    insert_education($user_id, $item[0], $item[1], $item[2], $item[3], $item[4], $item[5], $item[6], $index + 1);
}

$projects = [
    [
        'title' => 'Learn360 Platform',
        'description' => 'Comprehensive digital education platform offering free courses, video lessons, and interactive content for Malawian students and lifelong learners. Built on WordPress with LMS integration.',
        'short_description' => 'Free digital education platform for Malawian learners.',
        'category' => 'Free E-Learning Hub',
        'icon_type' => 'book-open',
        'icon_color' => '#6366f1',
        'background_color' => '#18181b',
        'tech_stack' => ['WordPress', 'LMS', 'Divi'],
        'demo_url' => 'https://learn360.free.nf',
        'github_url' => '',
    ],
    [
        'title' => 'Ntonda Online Quiz System',
        'description' => 'Interactive assessment platform enabling students to test their knowledge with instant feedback and progress tracking across multiple subjects.',
        'short_description' => 'Interactive quiz and assessment platform.',
        'category' => 'Interactive Assessment',
        'icon_type' => 'check-circle-2',
        'icon_color' => '#ec4899',
        'background_color' => '#18181b',
        'tech_stack' => ['PHP', 'MySQL', 'JavaScript'],
        'demo_url' => 'https://ntonda.web.app',
        'github_url' => '',
    ],
    [
        'title' => 'Educational Animation Content',
        'description' => 'Engaging animated videos explaining complex concepts in science, mathematics, and technology, making learning accessible and fun for all ages.',
        'short_description' => 'Animated education videos for accessible learning.',
        'category' => 'Video Learning',
        'icon_type' => 'film',
        'icon_color' => '#fbbf24',
        'background_color' => '#18181b',
        'tech_stack' => ['Animation', 'Video Editing', 'Design'],
        'demo_url' => 'https://youtube.com/@learn360malawi',
        'github_url' => '',
    ],
    [
        'title' => 'Smart Music Malawi',
        'description' => 'Feature-rich music player concept with downloads, lyrics, equalizer, visualizer, and pro subscription functionality. Built for the Malawian music community.',
        'short_description' => 'Modern music player for the Malawian music community.',
        'category' => 'Music Streaming',
        'icon_type' => 'music',
        'icon_color' => '#22c55e',
        'background_color' => '#18181b',
        'tech_stack' => ['JavaScript', 'Web Audio API', 'Responsive'],
        'demo_url' => '',
        'github_url' => '',
    ],
    [
        'title' => 'Exam Generator',
        'description' => 'Automated exam paper creation app with randomized questions, multiple subject support, and large question banks. Designed for educators and institutions needing efficient test generation.',
        'short_description' => 'Automated exam paper creation app.',
        'category' => 'Test Creation Suite',
        'icon_type' => 'clipboard-list',
        'icon_color' => '#a78bfa',
        'background_color' => '#18181b',
        'tech_stack' => ['PHP', 'MySQL', 'Education'],
        'demo_url' => '',
        'github_url' => '',
    ],
    [
        'title' => 'Microcomputer Practicals',
        'description' => 'Interactive educational platform for hands-on computing exercises. Features lab simulations and demonstrations enabling students to practice microcomputer concepts in a safe, virtual environment.',
        'short_description' => 'Lab simulation platform for computing practicals.',
        'category' => 'Lab Simulation',
        'icon_type' => 'cpu',
        'icon_color' => '#d8b4fe',
        'background_color' => '#18181b',
        'tech_stack' => ['Web Technologies', 'Simulation', 'Interactive'],
        'demo_url' => '',
        'github_url' => '',
    ],
];

foreach ($projects as $index => $project) {
    insert_project($user_id, $project, $index + 1);
}

$news = [
    ['Learn360 Growth Roadmap', 'Learn360 is being shaped into a stronger free digital learning hub with more practical content for Malawian learners.', 'https://learn360.free.nf', 1],
    ['Portfolio Admin Upgrade', 'This portfolio now supports database-driven content, education history, project links, visitor logs, and engagement review.', '', 1],
];

foreach ($news as $index => $item) {
    insert_news($user_id, $item[0], $item[1], $item[2], $item[3], $index + 1);
}

$popup_items = [
    // [title, body, link, button_text, active, trigger_timer, timer_delay, trigger_scroll, scroll_percentage, trigger_esc, trigger_back_button]
    ['Available for Collaboration', 'Need a website, learning platform, quiz system, or digital education content? Send a request and let us build something useful.', '#engage', 'Send Request', 1, 1, 1500, 0, 50, 1, 1],
    ['Newsletter Signup', 'Subscribe to get updates on new projects and digital learning resources.', '#engage', 'Subscribe', 1, 1, 3000, 1, 40, 1, 0],
    ['Special Offer', 'Get 15% off web development services this month only!', '', 'Claim Offer', 0, 1, 900, 0, 50, 1, 1],
];

foreach ($popup_items as $index => $item) {
    insert_popup($user_id, $item[0], $item[1], $item[2], $item[3], $item[4], $index + 1, $item[5], $item[6], $item[7], $item[8], $item[9], $item[10]);
}

$section_keys = ['hero', 'about', 'goals', 'interests', 'challenges', 'experience', 'education', 'projects', 'skills', 'news', 'partnerships', 'contact', 'engage'];
foreach ($section_keys as $section_key) {
    upsert_section_background($user_id, $section_key, '', 0.80);
}

$skill_groups = [
    'Frontend Development' => ['#6366f1', ['HTML & CSS', 'JavaScript', 'Responsive Design', 'Adaptive Interfaces']],
    'UI/UX & Design' => ['#ec4899', ['Web App Design', 'Visual Consistency', 'Accessibility', 'Iterative Refinement']],
    'Backend & Database' => ['#22c55e', ['PHP', 'MySQL', 'InfinityFree Hosting', 'Schema Optimization']],
    'Platforms & Tools' => ['#fbbf24', ['WordPress', 'LMS Platforms', 'Divi Builder']],
    'Creative & Educational Tech' => ['#a78bfa', ['Video Editing', 'Animation', 'Educational Content', 'AI Tools']],
    'Professional Services' => ['#f97316', ['Technical Support', 'Network Security', 'IT Infrastructure', 'Freelance Services']],
];

$position = 1;
foreach ($skill_groups as $category => [$color, $items]) {
    foreach ($items as $skill) {
        insert_skill($user_id, $category, $skill, 'intermediate', $color, $position);
        $position++;
    }
}

$has_bookings = $mysqli->query("SELECT COUNT(*) AS total FROM portfolio_bookings WHERE user_id = " . (int)$user_id)->fetch_assoc();
if ((int)$has_bookings['total'] === 0) {
    $stmt = $mysqli->prepare("INSERT INTO portfolio_bookings (user_id, visitor_name, visitor_email, visitor_phone, service, preferred_date, message) VALUES (?, 'Sample Visitor', 'visitor@example.com', '+265 000 000 000', 'Website consultation', CURDATE(), 'Sample booking for admin review.')");
    $stmt->bind_param('i', $user_id);
    $stmt->execute();
}

$has_requests = $mysqli->query("SELECT COUNT(*) AS total FROM portfolio_requests WHERE user_id = " . (int)$user_id)->fetch_assoc();
if ((int)$has_requests['total'] === 0) {
    $stmt = $mysqli->prepare("INSERT INTO portfolio_requests (user_id, visitor_name, visitor_email, request_type, message) VALUES (?, 'Sample Partner', 'partner@example.com', 'Partnership', 'Sample request for admin review.')");
    $stmt->bind_param('i', $user_id);
    $stmt->execute();
}

$has_comments = $mysqli->query("SELECT COUNT(*) AS total FROM portfolio_comments WHERE user_id = " . (int)$user_id)->fetch_assoc();
if ((int)$has_comments['total'] === 0) {
    $stmt = $mysqli->prepare("INSERT INTO portfolio_comments (user_id, visitor_name, visitor_email, comment) VALUES (?, 'Sample Reader', 'reader@example.com', 'Sample comment for admin review.')");
    $stmt->bind_param('i', $user_id);
    $stmt->execute();
}

$mysqli->commit();

echo "<strong>Portfolio database seeded successfully.</strong><br>";
echo "Homepage now reads from database tables only: settings, section backgrounds, sections, projects, experience, education, skills, news, and popups.<br>";
echo "<a href='index.php'>Open homepage</a>";
?>

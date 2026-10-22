-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: sql110.infinityfree.com
-- Generation Time: Oct 22, 2026 at 02:00 PM
-- Server version: 11.4.13-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `if0_41898653_lawreay`
--

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_bookings`
--

CREATE TABLE `portfolio_bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `visitor_name` varchar(100) DEFAULT NULL,
  `visitor_email` varchar(100) DEFAULT NULL,
  `visitor_phone` varchar(30) DEFAULT NULL,
  `service` varchar(150) DEFAULT NULL,
  `preferred_date` date DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `status` varchar(30) DEFAULT 'new',
  `is_reviewed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_bookings`
--

INSERT INTO `portfolio_bookings` (`id`, `user_id`, `visitor_name`, `visitor_email`, `visitor_phone`, `service`, `preferred_date`, `message`, `status`, `is_reviewed`, `created_at`) VALUES
(1, 1, 'Sample Visitor', 'visitor@example.com', '+265 000 000 000', 'Website consultation', '2026-05-11', 'Sample booking for admin review.', 'new', 0, '2026-05-11 18:39:14'),
(3, 1, 'LAWRENCE PHUKA', 'lawreay2@gmail.com', '0993147700', 'Website', '2026-05-20', '', 'new', 1, '2026-05-11 18:47:39');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_comments`
--

CREATE TABLE `portfolio_comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `visitor_name` varchar(100) DEFAULT NULL,
  `visitor_email` varchar(100) DEFAULT NULL,
  `comment` longtext DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 1,
  `is_reviewed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_comments`
--

INSERT INTO `portfolio_comments` (`id`, `user_id`, `visitor_name`, `visitor_email`, `comment`, `is_approved`, `is_reviewed`, `created_at`) VALUES
(1, 1, 'Sample Reader', 'reader@example.com', 'Sample comment for admin review.', 1, 0, '2026-05-11 18:39:14');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_education`
--

CREATE TABLE `portfolio_education` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `institution` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 0,
  `icon_color` varchar(7) DEFAULT NULL,
  `order_position` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_education`
--

INSERT INTO `portfolio_education` (`id`, `user_id`, `title`, `institution`, `description`, `start_date`, `end_date`, `is_current`, `icon_color`, `order_position`, `created_at`, `updated_at`) VALUES
(1, 1, 'Bachelor of Science in Information Technology', 'Unicaf', 'Focused on information systems, networking, database-driven applications, web development, and educational technology practice.', '2023-08-07', NULL, 0, '#c2a800', 1, '2026-05-11 18:39:14', '2026-07-20 06:33:17'),
(2, 1, 'ICT Education & Technical Support Practice', 'Professional Development', 'Ongoing hands-on growth through support work, platform building, curriculum creation, and community technology projects.', '2025-01-01', NULL, 0, '#22c55e', 2, '2026-05-11 18:39:14', '2026-05-13 09:03:13');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_experience`
--

CREATE TABLE `portfolio_experience` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 0,
  `icon_color` varchar(7) DEFAULT NULL,
  `order_position` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_experience`
--

INSERT INTO `portfolio_experience` (`id`, `user_id`, `title`, `company`, `description`, `start_date`, `end_date`, `is_current`, `icon_color`, `order_position`, `created_at`, `updated_at`) VALUES
(9, 1, 'Founder & Lead Developer', 'Learn360 Platform', 'Built and maintain a comprehensive free digital education platform serving underserved Malawian communities. Developed curriculum, created multimedia content, and established partnerships for sustainable growth.', '2025-08-01', NULL, 1, '#6366f1', 1, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(10, 1, 'IT Manager & Technical Support', 'Malawi Adventist University', 'Provide technical leadership, network security management, and educational technology support. Train faculty and students in digital tools while maintaining critical IT infrastructure.', '2025-01-01', NULL, 1, '#ec4899', 2, '2026-05-11 18:39:14', '2026-07-02 21:32:01'),
(11, 1, 'Creative Technologist', 'Freelance & Community Projects', 'Design and develop websites, create educational animations, and produce multimedia content for local organizations and educational initiatives across Malawi.', '2025-06-01', NULL, 1, '#fbbf24', 3, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(13, 1, 'Founder & Lead Developer', 'HealthBuddy', 'HealthBuddy connects you with clinical experts for fast, private STI triage and guidance. Our AI-assisted platform ensures you get the right care without compromising privacy.', '2026-04-10', NULL, 0, '#9e2465', 0, '2026-05-12 06:48:47', '2026-05-12 06:49:32');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_files`
--

CREATE TABLE `portfolio_files` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_messages`
--

CREATE TABLE `portfolio_messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sender_name` varchar(100) DEFAULT NULL,
  `sender_email` varchar(100) DEFAULT NULL,
  `sender_whatsapp` varchar(20) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_news`
--

CREATE TABLE `portfolio_news` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` longtext DEFAULT NULL,
  `link_url` varchar(500) DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT 1,
  `published_at` datetime DEFAULT current_timestamp(),
  `order_position` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_news`
--

INSERT INTO `portfolio_news` (`id`, `user_id`, `title`, `body`, `link_url`, `is_published`, `published_at`, `order_position`, `created_at`, `updated_at`) VALUES
(1, 1, 'Learn360 Growth Roadmap', 'Learn360 is being shaped into a stronger free digital learning hub with more practical content for Malawian learners.', 'https://learn360.free.nf', 1, '2026-05-11 22:39:14', 1, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(2, 1, 'Portfolio Admin Upgrade', 'This portfolio now supports database-driven content, education history, project links, visitor logs, and engagement review.', '', 1, '2026-05-11 22:39:14', 2, '2026-05-11 18:39:14', '2026-05-11 18:39:14');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_popups`
--

CREATE TABLE `portfolio_popups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `link_url` varchar(500) DEFAULT NULL,
  `button_text` varchar(100) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `order_position` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `trigger_timer` tinyint(1) DEFAULT NULL,
  `timer_delay` int(11) DEFAULT NULL,
  `trigger_scroll` tinyint(1) DEFAULT NULL,
  `scroll_percentage` int(11) DEFAULT 50,
  `trigger_esc` tinyint(1) DEFAULT NULL,
  `trigger_back_button` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_popups`
--

INSERT INTO `portfolio_popups` (`id`, `user_id`, `title`, `body`, `link_url`, `button_text`, `image_url`, `is_active`, `start_at`, `end_at`, `order_position`, `created_at`, `updated_at`, `trigger_timer`, `timer_delay`, `trigger_scroll`, `scroll_percentage`, `trigger_esc`, `trigger_back_button`) VALUES
(1, 1, 'Available for Collaboration', 'Need a website, learning platform, quiz system, or digital education content? Send a request and let us build something useful.', 'https://wa.me/265993147700?text=Hi%20Lawrence%2C%20I%27m%20interested%20in%20getting%20a%20website%20built.', 'Send Request', 'https://lawreay.lovestoblog.com/uploads/popup_1_1778579102_d0dff09a.png', 0, NULL, NULL, 1, '2026-05-11 18:39:14', '2026-05-13 08:05:00', 0, 900, 0, 50, 1, 1),
(2, 1, 'Need a Professional Website?', 'Get a custom-built, responsive website at an affordable price. I specialize in modern, responsive designs and e-commerce.', 'https://wa.me/265993147700?text=Hi%20Lawrence%2C%20I%27m%20interested%20in%20getting%20a%20website%20built.', 'Learn More', 'https://lawreay.lovestoblog.com/uploads/popup_1_1778579102_d0dff09a.png', 1, NULL, NULL, 2, '2026-05-12 07:45:02', '2026-05-13 08:05:28', 0, 900, 1, 50, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_projects`
--

CREATE TABLE `portfolio_projects` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `icon_type` varchar(500) DEFAULT NULL,
  `icon_color` varchar(7) DEFAULT NULL,
  `background_color` varchar(7) DEFAULT NULL,
  `tech_stack` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ;

--
-- Dumping data for table `portfolio_projects`
--

INSERT INTO `portfolio_projects` (`id`, `user_id`, `title`, `description`, `short_description`, `category`, `icon_type`, `icon_color`, `background_color`, `tech_stack`, `demo_url`, `github_url`, `image_path`, `order_position`, `is_featured`, `created_at`, `updated_at`) VALUES
(13, 1, 'Learn360 Platform', 'Comprehensive digital education platform offering free courses, video lessons, and interactive content for Malawian students and lifelong learners. Built on WordPress with LMS integration.', 'Free digital education platform for Malawian learners.', 'Free E-Learning Hub', 'book-open', '#6366f1', '#18181b', '[\"WordPress\",\"LMS\",\"Divi\"]', 'https://learn360.free.nf', '', 'https://lawreay.github.io/portfolio/learn360.png', 1, 1, '2026-05-11 18:39:14', '2026-05-13 08:41:27'),
(16, 1, 'Smart Music Malawi', 'Features User Authentication: Secure login and registration with bcrypt password hashing Music Uploads: Artists can upload their music (MP3, M4A, WAV, FLAC, OGG) Discovery: Browse and search public music tracks User Profiles: Artist profiles with music management File Storage: Secure file storage with automatic directory management Session Management: Secure PHP sessions with proper cookie handling', 'Modern music player for the Malawian music community.', 'Music Streaming', 'music', '#22c55e', '#18181b', '[\"JavaScript\",\"Web Audio API\",\"Responsive\"]', '', 'https://lawreay.github.io/Smart-Music-MW/', 'https://lawreay.lovestoblog.com/uploads/project_1_16_1778576374_121b0777.png', 4, 1, '2026-05-11 18:39:14', '2026-06-06 17:28:46'),
(20, 1, 'HealthBuddy', 'Why use HealthBuddy? Designed for privacy and speed in low-resource settings, bridging the gap between patients and clinicians..100% Anonymous Access healthcare without revealing your identity. We use temporary IDs to keep your data safe. Instant AI Triage Our AI-powered analysis provides immediate triage levels to help clinicians prioritize urgent cases. Clinician Led Real doctors review every report and provide personalized recommendations and guidance.', 'HealthBuddy connects you with clinical experts for fast, private STI triage and guidance. Our AI-assisted platform ensures you get the right care without compromising privacy.', 'Web App', 'https://sql110.infinityfree.com/Portifolio/uploads/project_icon_1_1778576075_8db5fe38.png', '#6366f1', '#18181b', '[\"PHP\",\"SQL\",\"JavaScript\"]', 'https://healthbuddy.free.nf/', '', 'https://healthbuddy.free.nf/assets/healthbuddy%20logo.png', 7, 1, '2026-05-12 06:54:35', '2026-05-13 09:10:18'),
(21, 1, 'TurboHostMW', 'This is my full description ', 'Perfect for anyone who wants a website that looks professional and is easy to manage', 'Web App', 'https://lawreay.lovestoblog.com/uploads/project_icon_1_21_1783254495_d0e7ea8d.png', '#6366f1', '#18181b', '[]', 'https://instaweb.freedev.app/', '', 'https://instaweb.freedev.app/uploads/branding/Jun_29__2026__09_41_55_PM-2.png', 4, 1, '2026-07-02 21:35:36', '2026-07-20 06:30:21');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_requests`
--

CREATE TABLE `portfolio_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `visitor_name` varchar(100) DEFAULT NULL,
  `visitor_email` varchar(100) DEFAULT NULL,
  `request_type` varchar(150) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `status` varchar(30) DEFAULT 'new',
  `is_reviewed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_requests`
--

INSERT INTO `portfolio_requests` (`id`, `user_id`, `visitor_name`, `visitor_email`, `request_type`, `message`, `status`, `is_reviewed`, `created_at`) VALUES
(1, 1, 'Sample Partner', 'partner@example.com', 'Partnership', 'Sample request for admin review.', 'new', 0, '2026-05-11 18:39:14'),
(2, 1, 'LAWRENCE PHUKA', 'jknljkn@tydyt.iuy', '', ';klpoj', 'new', 0, '2026-05-11 18:48:11');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_sections`
--

CREATE TABLE `portfolio_sections` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `section_type` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `icon_type` varchar(500) DEFAULT NULL,
  `order_position` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_sections`
--

INSERT INTO `portfolio_sections` (`id`, `user_id`, `section_type`, `title`, `description`, `icon_type`, `order_position`, `created_at`, `updated_at`) VALUES
(23, 1, 'Goals', 'Scale Learn360 Nationally', 'Build Learn360 into a comprehensive national hub for free digital learning, reaching every corner of Malawi with quality education content and interactive learning experiences.', 'target', 1, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(24, 1, 'Goals', 'Feature-Rich Music Player', 'Deliver a visually refined, feature-complete music player for Smart Music Malawi with downloads, lyrics, EQ, visualizer, and pro subscription functionality.', 'music', 2, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(25, 1, 'Goals', 'Master Backend Integration', 'Solve backend and database challenges with free hosting, MySQL schema optimization, and seamless integration across platforms.', 'database', 3, '2026-05-11 18:39:14', '2026-06-07 05:20:27'),
(26, 1, 'Interests', 'Music Technology', 'Deep engagement with music player development, audio processing, and creating immersive listening experiences. Focused on streaming technologies and smart playback features.', 'music', 1, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(27, 1, 'Interests', 'UI/UX Refinement', 'Passionate about visual consistency, accessibility, and iterative design. Creating intuitive interfaces that balance aesthetics with functionality.', 'layout-template', 2, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(28, 1, 'Interests', 'Backend Solutions', 'Interested in database troubleshooting, backend integration, and solving complex technical challenges with practical, scalable solutions.', 'server', 3, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(29, 1, 'Interests', 'Emerging Tech', 'Exploring AI tools, cloud computing, and streaming technologies to enhance educational platforms and user experiences.', 'sparkles', 4, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(30, 1, 'Challenges', 'Database Access & Schema Issues', 'Resolved access denied errors caused by database prefix mismatches. Implemented iterative schema corrections and optimization strategies for InfinityFree hosting environments.', 'database', 1, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(31, 1, 'Challenges', 'Iterative UI Refinement', 'Successfully enhanced the music player app through multiple design iterations, improving visual consistency, user experience, and accessibility while maintaining performance.', 'palette', 2, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(32, 1, 'Challenges', 'Customizable Admin Panels', 'Designed and built flexible admin panels for course-selling platforms, enabling institutional partners to customize their learning environment with minimal technical expertise.', 'settings', 3, '2026-05-11 18:39:14', '2026-05-11 18:39:14'),
(33, 1, 'Partnerships', 'Strategic Collaborations', 'I actively engage with academic institutions, technology communities, and professional networks to foster innovation and knowledge sharing. These partnerships enable me to integrate practical insights with digital solutions, creating scalable projects that support education and community development.', 'users', 1, '2026-05-11 18:39:14', '2026-06-06 18:11:29'),
(34, 1, 'Goals', 'Reliable Local Hosting', '\r\n\"To establish a trusted hosting service that empowers Malawian businesses, creators, and learners with affordable, secure, and high‑performance infrastructure. My vision is to deliver end‑to‑end digital solutions—from building websites to keeping them online—so clients can focus on growth while I handle the technology.\"', 'server', 0, '2026-06-07 05:23:21', '2026-06-07 05:23:21');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_section_backgrounds`
--

CREATE TABLE `portfolio_section_backgrounds` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `section_key` varchar(50) NOT NULL,
  `background_image` varchar(500) DEFAULT NULL,
  `overlay_opacity` decimal(3,2) DEFAULT 0.82,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_section_backgrounds`
--

INSERT INTO `portfolio_section_backgrounds` (`id`, `user_id`, `section_key`, `background_image`, `overlay_opacity`, `created_at`, `updated_at`) VALUES
(1, 1, 'hero', 'https://lawreay.lovestoblog.com/uploads/popup_1_1778579102_d0dff09a.png', '0.90', '2026-05-11 18:39:14', '2026-05-13 07:46:54'),
(2, 1, 'about', 'https://media.istockphoto.com/id/806872994/photo/web-cube-with-letters-and-words-from-the-computer-software-internet-categories-wooden-cubes.jpg?s=1024x1024&w=is&k=20&c=2B1yD3dYHix7YBJvGOgEaRzACNA0O5NnUlQHhPpBchw=', '0.80', '2026-05-11 18:39:14', '2026-05-13 08:51:29'),
(3, 1, 'goals', 'https://pixabay.com/images/download/peggy_marco-labyrinth-1015643_1920.jpg', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(4, 1, 'interests', 'https://media.istockphoto.com/id/863128490/vector/education-seamless-vector-background.jpg?s=2048x2048&w=is&k=20&c=xSexXKs128oe-hk_etRBnXPC1Xw_goe7mZyoHwLP0mw=', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(5, 1, 'challenges', '', '0.80', '2026-05-11 18:39:14', '2026-05-11 19:08:54'),
(6, 1, 'experience', 'https://pixabay.com/images/download/mohamed_hassan-climber-9491285_1920.png', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(7, 1, 'education', 'https://pixabay.com/images/download/27707-laptop-593673_1920.jpg', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(8, 1, 'projects', 'https://pixabay.com/images/download/fancycrave1-code-820275_1920.jpg', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(9, 1, 'skills', 'https://pixabay.com/images/download/doki7-wordpress-581849_1920.jpg', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(10, 1, 'news', '', '0.80', '2026-05-11 18:39:14', '2026-05-11 19:08:54'),
(11, 1, 'partnerships', 'https://media.istockphoto.com/id/996184198/photo/team-of-united-coworkers-standing-with-hands-together.jpg?s=2048x2048&w=is&k=20&c=eTbW90oDSqvQKC9dNNwG8Dsat-sxM9OBpJyY3BQZcdM=', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(12, 1, 'contact', 'https://media.istockphoto.com/id/1405728317/vector/global-network-connection-world-map-point-and-line-composition-concept-of-global-business.jpg?s=2048x2048&w=is&k=20&c=quUOXzjwqXizlD9EuBfoxNc98WwqSWHn_48-Q_rF5y0=', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(13, 1, 'engage', 'https://media.istockphoto.com/id/955338002/vector/speech-and-thought-bubbles-with-quote-marks-suitable-as-a-background-illustration-for-client.jpg?s=2048x2048&w=is&k=20&c=AFYRzpsw5qpLR0r8WU4m6rONBYCOBvAZMt-oXbxNAe4=', '0.80', '2026-05-11 18:39:14', '2026-05-13 09:00:11'),
(116, 1, 'cv', '', '0.80', '2026-05-12 08:13:33', '2026-05-12 08:13:33');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_settings`
--

CREATE TABLE `portfolio_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `background_color` varchar(7) DEFAULT '#0a0a0f',
  `surface_color` varchar(7) DEFAULT '#18181b',
  `text_color` varchar(7) DEFAULT '#e4e4e7',
  `primary_action_color` varchar(7) DEFAULT '#6366f1',
  `secondary_action_color` varchar(7) DEFAULT '#ec4899',
  `accent_color` varchar(7) DEFAULT '#22c55e',
  `font_family` varchar(50) DEFAULT 'Syne',
  `font_size` int(11) DEFAULT 16,
  `enable_animations` tinyint(1) DEFAULT 1,
  `cursor_animation` varchar(50) DEFAULT 'default',
  `background_image` varchar(255) DEFAULT NULL,
  `bio` longtext DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `whatsapp` varchar(20) DEFAULT NULL,
  `cv_path` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `brand_name` varchar(100) DEFAULT 'LAWREAY',
  `hero_kicker` varchar(255) DEFAULT 'Creative Technologist | Developer | Builder',
  `hero_title` varchar(255) DEFAULT 'Lawrence Phuka Chikapa',
  `hero_subtitle` varchar(255) DEFAULT 'Empowering Malawi Through Digital Innovation',
  `hero_cta` varchar(100) DEFAULT 'Learn More',
  `about_title` varchar(100) DEFAULT 'About Me',
  `about_text` longtext DEFAULT NULL,
  `about_secondary` longtext DEFAULT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `home_origin` varchar(100) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `religion` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `vision` longtext DEFAULT NULL,
  `github_url` varchar(500) DEFAULT NULL,
  `contact_intro` longtext DEFAULT NULL,
  `profile_image` varchar(500) DEFAULT NULL,
  `favicon_path` varchar(500) DEFAULT NULL,
  `enable_news` tinyint(1) DEFAULT 1,
  `enable_cv_download` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_settings`
--

INSERT INTO `portfolio_settings` (`id`, `user_id`, `background_color`, `surface_color`, `text_color`, `primary_action_color`, `secondary_action_color`, `accent_color`, `font_family`, `font_size`, `enable_animations`, `cursor_animation`, `background_image`, `bio`, `location`, `email`, `whatsapp`, `cv_path`, `created_at`, `updated_at`, `brand_name`, `hero_kicker`, `hero_title`, `hero_subtitle`, `hero_cta`, `about_title`, `about_text`, `about_secondary`, `full_name`, `home_origin`, `nationality`, `religion`, `status`, `vision`, `github_url`, `contact_intro`, `profile_image`, `favicon_path`, `enable_news`, `enable_cv_download`) VALUES
(1, 1, '#080616', '#1a1953', '#cecee8', '#2f2fe4', '#ec4899', '#22c55e', 'Roboto', 20, 0, 'default', NULL, 'Founder of Learn360 - empowering Malawi through digital innovation', 'Ntcheu, Malawi', 'lawreay1@gmail.com', '+265 993 147 700', '', '2026-05-11 06:35:19', '2026-07-20 06:28:28', 'LAWREAY', 'ICT Educator & Creative Technologist', 'Lawrence phuka Chikapa', 'Empowering Malawi Through Digital Innovation', 'PROJECTS', 'About Me', 'Looking to bring your ideas to life online with a Malawian touch? I’m a local developer focused on blending global tech standards with community-driven solutions. If you need a website that’s both innovative and locally resonant, I can build it for you.', 'As an ICT educator, I bridge the gap between technology and education, creating innovative solutions that make quality learning accessible to all Malawians, regardless of their economic background.', 'Lawrence Phuka Chikapa', 'Ntcheu', 'Malawian', '', 'Single', 'Alongside crafting your website, I also offer hosting solutions that are reliable, affordable, and rooted right here in Malawi. My goal is to give you a seamless, all-in-one experience so you can focus on what you do best.', 'https://github.com/lawreay', 'Interested in collaboration, partnerships, or learning more about Learn360? I\'d love to hear from you!', 'https://lawreay.github.io/portfolio/MYphoto.png', 'https://lawreay.github.io/portfolio/MYphoto.png', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_skills`
--

CREATE TABLE `portfolio_skills` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `skill_name` varchar(100) NOT NULL,
  `proficiency` varchar(20) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `order_position` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_skills`
--

INSERT INTO `portfolio_skills` (`id`, `user_id`, `category`, `skill_name`, `proficiency`, `color`, `order_position`, `created_at`) VALUES
(47, 1, 'Frontend Development', 'HTML & CSS', 'intermediate', '#6366f1', 1, '2026-05-11 18:39:14'),
(48, 1, 'Frontend Development', 'JavaScript', 'intermediate', '#6366f1', 2, '2026-05-11 18:39:14'),
(49, 1, 'Frontend Development', 'Responsive Design', 'intermediate', '#6366f1', 3, '2026-05-11 18:39:14'),
(50, 1, 'Frontend Development', 'Adaptive Interfaces', 'intermediate', '#6366f1', 4, '2026-05-11 18:39:14'),
(51, 1, 'UI/UX & Design', 'Web App Design', 'intermediate', '#ec4899', 5, '2026-05-11 18:39:14'),
(52, 1, 'UI/UX & Design', 'Visual Consistency', 'intermediate', '#ec4899', 6, '2026-05-11 18:39:14'),
(53, 1, 'UI/UX & Design', 'Accessibility', 'intermediate', '#ec4899', 7, '2026-05-11 18:39:14'),
(54, 1, 'UI/UX & Design', 'Iterative Refinement', 'intermediate', '#ec4899', 8, '2026-05-11 18:39:14'),
(55, 1, 'Backend & Database', 'PHP', 'intermediate', '#22c55e', 9, '2026-05-11 18:39:14'),
(56, 1, 'Backend & Database', 'MySQL', 'intermediate', '#22c55e', 10, '2026-05-11 18:39:14'),
(57, 1, 'Backend & Database', 'InfinityFree Hosting', 'intermediate', '#22c55e', 11, '2026-05-11 18:39:14'),
(58, 1, 'Backend & Database', 'Schema Optimization', 'intermediate', '#22c55e', 12, '2026-05-11 18:39:14'),
(59, 1, 'Platforms & Tools', 'WordPress', 'intermediate', '#fbbf24', 13, '2026-05-11 18:39:14'),
(60, 1, 'Platforms & Tools', 'LMS Platforms', 'intermediate', '#fbbf24', 14, '2026-05-11 18:39:14'),
(61, 1, 'Platforms & Tools', 'Divi Builder', 'intermediate', '#fbbf24', 15, '2026-05-11 18:39:14'),
(62, 1, 'Creative & Educational Tech', 'Video Editing', 'intermediate', '#a78bfa', 16, '2026-05-11 18:39:14'),
(63, 1, 'Creative & Educational Tech', 'Animation', 'intermediate', '#a78bfa', 17, '2026-05-11 18:39:14'),
(64, 1, 'Creative & Educational Tech', 'Educational Content', 'intermediate', '#a78bfa', 18, '2026-05-11 18:39:14'),
(65, 1, 'Creative & Educational Tech', 'AI Tools', 'intermediate', '#a78bfa', 19, '2026-05-11 18:39:14'),
(66, 1, 'Professional Services', 'Technical Support', 'intermediate', '#f97316', 20, '2026-05-11 18:39:14'),
(67, 1, 'Professional Services', 'Network Security', 'intermediate', '#f97316', 21, '2026-05-11 18:39:14'),
(68, 1, 'Professional Services', 'IT Infrastructure', 'intermediate', '#f97316', 22, '2026-05-11 18:39:14'),
(69, 1, 'Professional Services', 'Freelance Services', 'intermediate', '#f97316', 23, '2026-05-11 18:39:14'),
(70, 1, 'hello this is another skill', 'skill name ', 'advanced', '#0004e0', 0, '2026-07-20 06:32:21');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_users`
--

CREATE TABLE `portfolio_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_users`
--

INSERT INTO `portfolio_users` (`id`, `username`, `email`, `password`, `full_name`, `reset_token`, `reset_token_expiry`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'lawreay1@gmail.com', '$2y$10$wM4A04uqGQRCkSEnTFsIReHoq38gHXZ30Xl7BUTKTyAHJ0G2mldym', 'Lawrence Phuka Chikapa', '1562fb38e6b6898daf66aa4d366de8f09c732451b1ab7a4213a95036517436dc', '2026-06-05 10:36:18', '2026-05-11 06:35:19', '2026-06-05 13:36:18');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_visits`
--

CREATE TABLE `portfolio_visits` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `referrer` varchar(500) DEFAULT NULL,
  `page_url` varchar(500) DEFAULT NULL,
  `visited_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_visits`
--

INSERT INTO `portfolio_visits` (`id`, `user_id`, `ip_address`, `user_agent`, `referrer`, `page_url`, `visited_at`) VALUES
(229, 1, '137.115.10.234', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-04 07:21:52'),
(230, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-05 11:08:39'),
(231, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-05 11:56:16'),
(232, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-05 12:28:17'),
(233, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-05 12:29:25'),
(234, 1, '105.234.179.79', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36 EdgA/149.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 03:12:34'),
(235, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 03:26:07'),
(236, 1, '105.234.179.79', 'Mozilla/5.0 (Linux; Android 13; 2201117TG Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.163 Mobile Safari/537.36', 'http://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 03:48:59'),
(237, 1, '105.234.179.79', 'Mozilla/5.0 (Linux; Android 13; 2201117TG Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.163 Mobile Safari/537.36', '', '/', '2026-07-06 03:49:57'),
(238, 1, '102.70.116.58', 'Mozilla/5.0 (Linux; Android 13; 2201117TG Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.163 Mobile Safari/537.36', '', '/', '2026-07-06 03:51:30'),
(239, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 04:56:07'),
(240, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 05:17:30'),
(241, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 13:18:31'),
(242, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', '', '/', '2026-07-06 13:22:49'),
(243, 1, '105.234.179.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 13:47:30'),
(244, 1, '102.70.90.250', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-06 18:14:28'),
(245, 1, '102.70.112.68', 'Mozilla/5.0 (Linux; Android 13; 2201117TG Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.163 Mobile Safari/537.36', 'http://lawreay.lovestoblog.com/', '/?i=1', '2026-07-07 12:03:21'),
(246, 1, '102.70.112.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-07 12:05:12'),
(247, 1, '66.249.93.32', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '', '/?i=1', '2026-07-07 12:05:13'),
(248, 1, '74.125.210.106', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '', '/?i=1', '2026-07-07 12:05:14'),
(249, 1, '74.125.210.105', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '', '/?i=1', '2026-07-07 12:05:14'),
(250, 1, '102.70.112.101', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36 EdgA/149.0.0.0', 'https://lawreay.lovestoblog.com/?i=1', '/?i=2', '2026-07-07 14:16:14'),
(251, 1, '216.234.217.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-08 10:04:34'),
(252, 1, '40.77.167.136', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-08 10:26:55'),
(253, 1, '216.234.217.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-08 11:22:30'),
(254, 1, '216.234.217.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-08 11:22:47'),
(255, 1, '102.70.90.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-08 17:54:33'),
(256, 1, '40.77.167.47', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-09 01:11:07'),
(257, 1, '66.249.65.42', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-09 02:34:59'),
(258, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-09 12:13:50'),
(259, 1, '69.63.184.14', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe8hv0ZApeknneRxxlO1BnIPCsTi8tZlgYndcxGXwqALKkctuIK7bvyGm7Mek_aem_DXhu02YbH4VrT6scMqFUcA', '2026-07-09 15:30:16'),
(260, 1, '66.249.65.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-10 01:08:19'),
(261, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-10 14:16:20'),
(262, 1, '137.115.2.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-10 17:50:47'),
(263, 1, '137.115.2.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-10 17:51:52'),
(264, 1, '137.115.2.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-10 17:57:17'),
(265, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-11 05:55:16'),
(266, 1, '137.115.2.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-11 18:36:34'),
(267, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-13 06:21:49'),
(268, 1, '102.70.90.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-15 08:19:55'),
(269, 1, '105.234.179.223', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/?i=1', '/?i=2', '2026-07-17 00:24:23'),
(270, 1, '52.167.144.237', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-17 09:39:43'),
(271, 1, '173.252.95.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 'https://www.facebook.com/', '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeTMCYfyjuFkYCPTPB8OVQ6lnUiuCjUQIUGWCl9e2Zel9o07j2jjPC-wS--jE_aem_bPOyPcv2yb8dt_tBRkyLxA', '2026-07-17 18:58:15'),
(272, 1, '173.252.107.4', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeTMCYfyjuFkYCPTPB8OVQ6lnUiuCjUQIUGWCl9e2Zel9o07j2jjPC-wS--jE_aem_bPOyPcv2yb8dt_tBRkyLxA', '2026-07-17 18:58:52'),
(273, 1, '52.167.144.179', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-18 03:04:29'),
(274, 1, '105.234.179.223', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-18 06:56:58'),
(275, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.124 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-18 10:54:41'),
(276, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.124 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-18 21:25:20'),
(277, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.124 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-18 22:48:58'),
(278, 1, '66.249.65.42', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-18 22:49:11'),
(279, 1, '66.249.65.43', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-18 22:49:12'),
(280, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.124 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-19 11:48:51'),
(281, 1, '66.249.65.42', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.124 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-19 20:55:21'),
(282, 1, '102.70.90.13', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-20 06:02:18'),
(283, 1, '66.249.93.40', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '', '/?i=1', '2026-07-20 06:02:20'),
(284, 1, '74.125.210.105', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '', '/?i=1', '2026-07-20 06:02:21'),
(285, 1, '74.125.210.105', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '', '/?i=1', '2026-07-20 06:02:21'),
(286, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-20 06:04:03'),
(287, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-20 06:07:55'),
(288, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:09:54'),
(289, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:10:16'),
(290, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:11:03'),
(291, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:11:45'),
(292, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:12:13'),
(293, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:12:17'),
(294, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:12:38'),
(295, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:13:15'),
(296, 1, '102.70.90.13', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '', '/', '2026-07-20 06:26:45'),
(297, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:28:40'),
(298, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:30:28'),
(299, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:32:27'),
(300, 1, '137.115.2.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', '', '/', '2026-07-20 06:33:28'),
(301, 1, '196.49.26.134', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-20 06:36:16'),
(302, 1, '105.113.65.211', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-20 06:47:40'),
(303, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.124 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-20 10:29:24'),
(304, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-20 10:29:57'),
(305, 1, '66.249.65.40', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-20 10:29:59'),
(306, 1, '66.249.65.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.128 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-21 00:50:15'),
(307, 1, '99.209.202.130', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-07-21 13:39:18'),
(308, 1, '66.249.65.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.128 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-23 08:11:43'),
(309, 1, '52.167.144.172', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-23 13:39:08'),
(310, 1, '66.249.65.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.128 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-26 08:11:15'),
(311, 1, '173.252.95.54', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5.2 Mobile/15E148 Safari/604.1', 'https://www.facebook.com/', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR6Hy_H00BpG9gKjEUNlyj3qEav6Q0gUymJSmJN5l8AB93POlnf6o8EwuCg5cQ_aem_559AK-xaO8zwGaTGKw9XQg', '2026-07-26 08:37:40'),
(312, 1, '69.171.236.4', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR6Hy_H00BpG9gKjEUNlyj3qEav6Q0gUymJSmJN5l8AB93POlnf6o8EwuCg5cQ_aem_559AK-xaO8zwGaTGKw9XQg', '2026-07-26 08:38:16'),
(313, 1, '52.167.144.23', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-26 15:43:57'),
(314, 1, '52.167.144.199', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-26 19:25:23'),
(315, 1, '40.77.167.2', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-28 19:26:09'),
(316, 1, '66.249.65.42', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.128 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-29 03:01:58');
INSERT INTO `portfolio_visits` (`id`, `user_id`, `ip_address`, `user_agent`, `referrer`, `page_url`, `visited_at`) VALUES
(317, 1, '66.249.65.42', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-29 03:02:10'),
(318, 1, '66.249.65.43', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-07-29 03:02:11'),
(319, 1, '52.167.144.23', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-30 20:07:40'),
(320, 1, '52.167.144.191', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-07-31 11:54:33'),
(321, 1, '40.77.167.48', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-08-02 20:09:16'),
(322, 1, '173.252.70.41', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148', 'https://www.facebook.com/', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5P6WgJEdM-WqEWV6o3Zciax757vTKVVUSvUcGbOwI2y-cvGRYKkvbU1wzBPg_aem_4jLfZH7Cab60vT2gwa-qGA', '2026-08-03 11:28:05'),
(323, 1, '173.252.95.16', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5P6WgJEdM-WqEWV6o3Zciax757vTKVVUSvUcGbOwI2y-cvGRYKkvbU1wzBPg_aem_4jLfZH7Cab60vT2gwa-qGA', '2026-08-03 11:28:40'),
(324, 1, '66.249.65.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.186 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-05 06:04:28'),
(325, 1, '66.249.65.42', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-05 06:05:02'),
(326, 1, '66.249.65.41', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-05 06:05:02'),
(327, 1, '40.77.167.1', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-08-05 20:13:32'),
(328, 1, '69.171.231.27', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5ofAuPaWej0myawlEdSn7RaAWvZ0Yk11cRlyJarWxWRGFgG7nGxRH_ANQjxQ_aem_1B4PIXAoyO4b7FMTBaY9WQ', '2026-08-12 05:15:44'),
(329, 1, '66.249.65.42', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.186 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-15 15:58:02'),
(330, 1, '66.249.65.41', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-17 05:58:10'),
(331, 1, '66.249.65.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-17 05:58:22'),
(332, 1, '66.249.65.42', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.186 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-17 09:16:20'),
(333, 1, '66.249.65.41', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-18 12:04:33'),
(334, 1, '160.177.58.165', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-08-18 23:36:41'),
(335, 1, '190.204.9.181', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-08-19 20:49:23'),
(336, 1, '216.234.217.153', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-08-20 07:00:21'),
(337, 1, '66.249.65.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-20 07:30:46'),
(338, 1, '66.249.76.233', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-21 06:05:57'),
(339, 1, '66.249.76.234', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-22 06:01:08'),
(340, 1, '173.252.70.39', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', 'https://www.facebook.com/', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR4EqeLuK6R6TFq-jlC8icCZxlyP8tjp4BTpYaXAuVcx2BW76UMSJGpBUxAEiA_aem_5PMQz--y6r0xNyS4kiuX6w', '2026-08-22 16:53:00'),
(341, 1, '69.63.189.17', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR4EqeLuK6R6TFq-jlC8icCZxlyP8tjp4BTpYaXAuVcx2BW76UMSJGpBUxAEiA_aem_5PMQz--y6r0xNyS4kiuX6w', '2026-08-22 16:53:36'),
(342, 1, '66.249.65.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-22 20:49:19'),
(343, 1, '66.249.76.234', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-27 13:39:42'),
(344, 1, '66.249.65.10', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-27 13:39:42'),
(345, 1, '66.249.74.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-08-31 16:25:53'),
(346, 1, '173.252.95.43', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6 Mobile/15E148 Safari/604.1', 'https://www.facebook.com/', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR6sDOp3IeRLUb78MrkMWC-MV8I8EwixL0dzwKW_IxQ8TyFvbJCUGlp9hUQNtg_aem_GZR0s7uTh_ZQpynWq6_p9A', '2026-08-31 17:37:47'),
(347, 1, '69.171.231.3', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR6sDOp3IeRLUb78MrkMWC-MV8I8EwixL0dzwKW_IxQ8TyFvbJCUGlp9hUQNtg_aem_GZR0s7uTh_ZQpynWq6_p9A', '2026-08-31 17:38:23'),
(348, 1, '66.249.74.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-04 05:46:03'),
(349, 1, '157.55.39.12', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-09-04 14:09:44'),
(350, 1, '157.55.39.12', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-09-04 14:11:03'),
(351, 1, '66.249.74.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-04 16:04:53'),
(352, 1, '66.249.76.234', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-07 13:08:24'),
(353, 1, '173.252.82.0', 'Mozilla/5.0 (Linux; Android 14; SM-A135M Build/UP1A.231005.007) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.104 Mobile Safari/537.36', 'https://www.facebook.com/', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5hN8zfVTZrCeLI90GQ-dBlXyK3JKrhYYYGfDTn8hh1A3D1AELR7MV22HdakA_aem_LBM5HaqGa2FaoHziSnDn1w', '2026-09-09 07:11:13'),
(354, 1, '34.218.252.128', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.82 Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-09-10 05:43:54'),
(355, 1, '34.218.252.128', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-09-10 05:44:10'),
(356, 1, '66.249.65.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.82 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-13 16:06:39'),
(357, 1, '66.249.65.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.82 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-14 01:12:48'),
(358, 1, '173.252.70.5', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.1 Mobile/15E148 Safari/604.1', 'https://www.facebook.com/', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5gzH-xxIV3IdA0_i9X-TPylldoPLzY8B-uHabdece0vD6uLi2FAeqJ9iVi0g_aem_oeSogfVOa3Cu2pbnJsMzuQ', '2026-09-17 12:10:46'),
(359, 1, '173.252.79.10', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwcGRvZgRleHRuA2FlbQIxMQBzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5gzH-xxIV3IdA0_i9X-TPylldoPLzY8B-uHabdece0vD6uLi2FAeqJ9iVi0g_aem_oeSogfVOa3Cu2pbnJsMzuQ', '2026-09-17 12:11:22'),
(360, 1, '35.245.227.115', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.197 Safari/537.36', '', '/', '2026-09-17 15:46:34'),
(361, 1, '35.245.188.175', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.197 Safari/537.36', '', '/', '2026-09-17 15:46:34'),
(362, 1, '66.249.65.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.47 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-18 22:27:36'),
(363, 1, '66.249.65.10', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-18 22:30:53'),
(364, 1, '66.249.65.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-18 22:30:55'),
(365, 1, '66.249.65.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.47 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-19 10:42:57'),
(366, 1, '66.249.65.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.47 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-19 22:18:44'),
(367, 1, '173.252.95.58', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/', '2026-09-20 07:50:14'),
(368, 1, '66.249.65.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.47 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-20 14:51:55'),
(369, 1, '66.249.65.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.47 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-21 00:45:16'),
(370, 1, '66.249.65.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.47 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-21 10:12:44'),
(371, 1, '52.167.144.170', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-09-22 02:47:08'),
(372, 1, '66.249.65.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-09-22 14:50:58'),
(373, 1, '57.141.20.55', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/?fbclid=IwZXh0bgNhZW0CMTEAcGRvZgRzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5g4R41VY6qkX7iQW8fvxfsYej3BkE-QV0z-VdwSGrrscRS22QkavsgjCtVGw_aem_UNrMCezegM6rYveii5Fi7Q', '/?fbclid=IwZXh0bgNhZW0CMTEAcGRvZgRzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5g4R41VY6qkX7iQW8fvxfsYej3BkE-QV0z-VdwSGrrscRS22QkavsgjCtVGw_aem_UNrMCezegM6rYveii5Fi7Q&i=1', '2026-09-27 05:18:55'),
(374, 1, '173.252.95.31', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwZXh0bgNhZW0CMTEAcGRvZgRzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5g4R41VY6qkX7iQW8fvxfsYej3BkE-QV0z-VdwSGrrscRS22QkavsgjCtVGw_aem_UNrMCezegM6rYveii5Fi7Q&i=1', '2026-09-27 05:19:33'),
(375, 1, '161.77.133.222', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'https://lawreay.lovestoblog.com/', '/?i=1', '2026-09-28 12:52:33'),
(376, 1, '66.249.74.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-01 04:16:16'),
(377, 1, '66.249.74.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-01 10:00:37'),
(378, 1, '66.249.74.12', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-01 10:00:37'),
(379, 1, '66.249.74.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-02 08:28:21'),
(380, 1, '66.249.74.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-06 05:09:43'),
(381, 1, '66.249.74.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-06 05:12:14'),
(382, 1, '66.249.74.11', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-06 05:12:14'),
(383, 1, '57.141.20.55', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', 'https://lawreay.lovestoblog.com/?fbclid=IwZXh0bgNhZW0CMTEAcGRvZgRzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5WLuWFfRrdmritLIfJQVIdaXxvSy0fh_9bFV0VuUAZAUonFJSuWbCAnj_cHQ_aem_b-arv63rCukhKpU1yjCPIg', '/?fbclid=IwZXh0bgNhZW0CMTEAcGRvZgRzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5WLuWFfRrdmritLIfJQVIdaXxvSy0fh_9bFV0VuUAZAUonFJSuWbCAnj_cHQ_aem_b-arv63rCukhKpU1yjCPIg&i=1', '2026-10-06 09:37:52'),
(384, 1, '69.171.236.12', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '', '/?fbclid=IwZXh0bgNhZW0CMTEAcGRvZgRzcnRjBmFwcF9pZAwyNTYyODEwNDA1NTgAAR5WLuWFfRrdmritLIfJQVIdaXxvSy0fh_9bFV0VuUAZAUonFJSuWbCAnj_cHQ_aem_b-arv63rCukhKpU1yjCPIg&i=1', '2026-10-06 09:38:26'),
(385, 1, '40.77.167.14', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-10-08 18:06:53'),
(386, 1, '116.179.33.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36', 'http://lawreay.lovestoblog.com/?i=1', '/?i=2', '2026-10-09 03:08:45'),
(387, 1, '66.249.74.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-10 01:07:45'),
(388, 1, '66.249.74.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-10 08:47:23'),
(389, 1, '52.167.144.204', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-10-10 13:04:28'),
(390, 1, '66.249.74.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-11 03:07:36'),
(391, 1, '66.249.74.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-11 20:41:51'),
(392, 1, '66.249.74.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-12 14:06:27'),
(393, 1, '66.249.74.10', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-16 18:50:44'),
(394, 1, '66.249.74.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-17 04:53:32'),
(395, 1, '66.249.74.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-17 14:36:26');
INSERT INTO `portfolio_visits` (`id`, `user_id`, `ip_address`, `user_agent`, `referrer`, `page_url`, `visited_at`) VALUES
(396, 1, '66.249.74.9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-18 02:36:26'),
(397, 1, '40.77.167.46', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-10-18 11:18:29'),
(398, 1, '66.249.74.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-19 16:03:30'),
(399, 1, '66.249.74.11', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.52 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '', '/', '2026-10-20 01:49:33'),
(400, 1, '40.77.167.12', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '', '/', '2026-10-21 12:48:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `portfolio_bookings`
--
ALTER TABLE `portfolio_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_comments`
--
ALTER TABLE `portfolio_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_education`
--
ALTER TABLE `portfolio_education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_experience`
--
ALTER TABLE `portfolio_experience`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_files`
--
ALTER TABLE `portfolio_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_messages`
--
ALTER TABLE `portfolio_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_news`
--
ALTER TABLE `portfolio_news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_popups`
--
ALTER TABLE `portfolio_popups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_requests`
--
ALTER TABLE `portfolio_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_sections`
--
ALTER TABLE `portfolio_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_section_backgrounds`
--
ALTER TABLE `portfolio_section_backgrounds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_section_background` (`user_id`,`section_key`);

--
-- Indexes for table `portfolio_settings`
--
ALTER TABLE `portfolio_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_skills`
--
ALTER TABLE `portfolio_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio_users`
--
ALTER TABLE `portfolio_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `portfolio_visits`
--
ALTER TABLE `portfolio_visits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `portfolio_bookings`
--
ALTER TABLE `portfolio_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `portfolio_comments`
--
ALTER TABLE `portfolio_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `portfolio_education`
--
ALTER TABLE `portfolio_education`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `portfolio_experience`
--
ALTER TABLE `portfolio_experience`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `portfolio_files`
--
ALTER TABLE `portfolio_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portfolio_messages`
--
ALTER TABLE `portfolio_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portfolio_news`
--
ALTER TABLE `portfolio_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `portfolio_popups`
--
ALTER TABLE `portfolio_popups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `portfolio_projects`
--
ALTER TABLE `portfolio_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portfolio_requests`
--
ALTER TABLE `portfolio_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `portfolio_sections`
--
ALTER TABLE `portfolio_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `portfolio_section_backgrounds`
--
ALTER TABLE `portfolio_section_backgrounds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `portfolio_settings`
--
ALTER TABLE `portfolio_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `portfolio_skills`
--
ALTER TABLE `portfolio_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `portfolio_users`
--
ALTER TABLE `portfolio_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `portfolio_visits`
--
ALTER TABLE `portfolio_visits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=401;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `portfolio_bookings`
--
ALTER TABLE `portfolio_bookings`
  ADD CONSTRAINT `portfolio_bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_comments`
--
ALTER TABLE `portfolio_comments`
  ADD CONSTRAINT `portfolio_comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_education`
--
ALTER TABLE `portfolio_education`
  ADD CONSTRAINT `portfolio_education_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_experience`
--
ALTER TABLE `portfolio_experience`
  ADD CONSTRAINT `portfolio_experience_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_files`
--
ALTER TABLE `portfolio_files`
  ADD CONSTRAINT `portfolio_files_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_messages`
--
ALTER TABLE `portfolio_messages`
  ADD CONSTRAINT `portfolio_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_news`
--
ALTER TABLE `portfolio_news`
  ADD CONSTRAINT `portfolio_news_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_popups`
--
ALTER TABLE `portfolio_popups`
  ADD CONSTRAINT `portfolio_popups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_requests`
--
ALTER TABLE `portfolio_requests`
  ADD CONSTRAINT `portfolio_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_sections`
--
ALTER TABLE `portfolio_sections`
  ADD CONSTRAINT `portfolio_sections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_section_backgrounds`
--
ALTER TABLE `portfolio_section_backgrounds`
  ADD CONSTRAINT `portfolio_section_backgrounds_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_settings`
--
ALTER TABLE `portfolio_settings`
  ADD CONSTRAINT `portfolio_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_skills`
--
ALTER TABLE `portfolio_skills`
  ADD CONSTRAINT `portfolio_skills_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolio_visits`
--
ALTER TABLE `portfolio_visits`
  ADD CONSTRAINT `portfolio_visits_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `portfolio_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

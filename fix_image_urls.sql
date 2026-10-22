-- Fix Broken Image URLs in Portfolio Database
-- Run this SQL in phpMyAdmin to fix all image URLs

-- Base URL to use for all images
-- https://sql110.infinityfree.com/Portifolio/uploads/

-- 1. Fix profile image in portfolio_settings
UPDATE portfolio_settings 
SET profile_image = 'https://sql110.infinityfree.com/Portifolio/uploads/profile_1_1778657398_f17648b9.png' 
WHERE id = 1 AND profile_image IS NOT NULL;

-- 2. Fix project images (project image_path field)
UPDATE portfolio_projects 
SET image_path = 'https://sql110.infinityfree.com/Portifolio/uploads/project_1_1778576075_e35c4c40.png' 
WHERE id = 20 AND image_path LIKE '%project_1_1778576075_e35c4c40%';

UPDATE portfolio_projects 
SET image_path = 'https://sql110.infinityfree.com/Portifolio/uploads/project_1_1778576374_121b0777.png' 
WHERE id = 16 AND image_path LIKE '%project_1_1778576374%';

-- 3. Fix project icons (icon_type field when it contains image paths)
UPDATE portfolio_projects 
SET icon_type = 'https://sql110.infinityfree.com/Portifolio/uploads/project_icon_1_1778576075_8db5fe38.png' 
WHERE id = 20 AND icon_type LIKE '%project_icon_1_1778576075%';

-- 4. Fix popup images
UPDATE portfolio_popups 
SET image_url = 'https://sql110.infinityfree.com/Portifolio/uploads/popup_1_1778579102_d0dff09a.png' 
WHERE id = 1 AND image_url LIKE '%popup_1_1778579102%';

-- 5. Fix any HTTP URLs to use HTTPS
UPDATE portfolio_projects 
SET image_path = REPLACE(image_path, 'http://sql110.infinityfree.com', 'https://sql110.infinityfree.com') 
WHERE image_path LIKE 'http://sql110.infinityfree.com%';

UPDATE portfolio_projects 
SET icon_type = REPLACE(icon_type, 'http://sql110.infinityfree.com', 'https://sql110.infinityfree.com') 
WHERE icon_type LIKE 'http://sql110.infinityfree.com%';

UPDATE portfolio_popups 
SET image_url = REPLACE(image_url, 'http://sql110.infinityfree.com', 'https://sql110.infinityfree.com') 
WHERE image_url LIKE 'http://sql110.infinityfree.com%';

UPDATE portfolio_settings 
SET profile_image = REPLACE(profile_image, 'http://sql110.infinityfree.com', 'https://sql110.infinityfree.com') 
WHERE profile_image LIKE 'http://sql110.infinityfree.com%';

-- Verify the fixes
SELECT 'Profile Image' as field, COUNT(*) as fixed_count FROM portfolio_settings WHERE profile_image LIKE 'https://sql110.infinityfree.com%'
UNION
SELECT 'Project Images', COUNT(*) FROM portfolio_projects WHERE image_path LIKE 'https://sql110.infinityfree.com%'
UNION
SELECT 'Popup Images', COUNT(*) FROM portfolio_popups WHERE image_url LIKE 'https://sql110.infinityfree.com%';

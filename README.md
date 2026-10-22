# Portfolio Admin System - README

## What This Is

A **complete PHP/MySQL admin system** for managing your professional portfolio with **real-time customization**, **project management**, **CV uploads**, and **email-based password recovery**.

**Status:** Fully Functional & Production Ready

---

## Quick Start (5 Minutes)

### 1 Create Database
```bash
Open http://sql110.infinityfree.com/phpmyadmin
→ Create database: if0_41898653_lawreay
→ Go to SQL tab
→ Paste database_schema.sql contents
→ Click Go
```

### 2 Login
```
URL: http://sql110.infinityfree.com/Portifolio/admin/login.php
Username: admin
Password: lastBorn33
Change password immediately!
```

### 3 Customize
- Profile: Add bio, location, upload CV
- Projects: Add your projects with tech stack
- Theme: Pick your colors
- Typography: Choose font & size
- Animations: Toggle effects & cursor style

### 4 View Portfolio
```
URL: http://sql110.infinityfree.com/Portifolio/index.php
All changes appear instantly!
```

### Reseed Homepage Data
If the homepage needs to be reset to the database-backed portfolio content:
```bash
C:\xamp\php\php.exe seed_portfolio.php
```
This clears the admin user's portfolio rows for projects, experience, skills, and sections, then inserts the seeded content used by `index.php`.

---

## File Structure

```
/Portifolio/
├── index.php                    ← Main portfolio (dynamic, loads from DB)
├── Index.html                   ← Redirects to database-powered index.php
├── config.php                   ← Database & email config
├── database_schema.sql          ← Database setup file
├── seed_portfolio.php           ← Clears and seeds homepage DB content
├── admin/
│   ├── login.php               ← Login & password recovery
│   ├── dashboard.php           ← Admin control panel
│   └── reset-password.php      ← Password reset form
├── uploads/                    ← CV & file storage
├── README.md                   ← This file
├── QUICKSTART.md               ← 30-second setup
├── SETUP.md                    ← Detailed setup guide
├── FEATURES.md                 ← Complete feature list
└── CHECKLIST.md                ← Setup checklist
```

---

## Key Features

### Authentication
- Secure login (username or email)
- Bcrypt password hashing
- Password recovery via email
- Session management (1-hour timeout)

### Profile Management
- Edit bio, location, contact info
- Upload/download CV (PDF, DOC, DOCX)
- Real-time portfolio updates

### Project Management
- Add/edit/delete projects
- Tech stack tags
- Demo & GitHub links
- Optional project link and image
- Categorization & ordering

### Content Sections
- Education timeline
- Enable/disable News
- Section background image URLs
- Profile photo above hero name
- Favicon control

### Engagement & Tracking
- Bookings, requests, and comments collected from homepage forms
- Admin review/delete workflow for submissions
- Visitor log for homepage visits
- Popup ad management with activate/deactivate controls

### Theme Customization
- 6 customizable colors
- Color picker interface
- Real-time portfolio preview
- Persistent storage

### Typography
- 5 font family options
- Adjustable font size (12-20px)
- Instant application
- Google Fonts integration

### Animations
- Global animation toggle
- 4 cursor animation styles
- Fade-up & slide-in effects
- Hover interactions

### Email Integration
- Password recovery emails
- SMTP configuration ready
- HTML email templates
- Token-based recovery links

---

## Core Strengths

### Clarity & Focus
- Clean, organized interface
- One-click customization
- Clear project descriptions
- Intuitive navigation

### Creativity & Skills
- Full-stack development showcase
- PHP/MySQL backend
- JavaScript frontend
- UI/UX design demonstrated

### Range & Depth
- Multiple project types
- Diverse tech stacks
- Advanced customization
- Database complexity

### Professional Presentation
- Modern dark theme
- Responsive design
- Consistent branding
- High visual quality

### Tailored Content
- Customizable per audience
- Adjustable messaging
- Flexible theme
- Adaptable layout

### Storytelling
- Project context provided
- Tech stack transparency
- Demo links included
- GitHub integration

### Easy Navigation
- Simple admin tabs
- Quick portfolio sections
- Mobile-responsive
- Obvious contact methods

---

## Security Features

**Password Security**
- Bcrypt hashing (cost 10)
- Secure token generation
- 1-hour recovery link expiry
- No plaintext passwords

**Input Protection**
- SQL injection prevention (prepared statements)
- XSS prevention (HTML entity encoding)
- CSRF protection (session-based)
- File upload validation

**Session Management**
- Auto-logout after 1 hour
- Session timeout enforcement
- Secure cookie handling
- Login time tracking

**File Security**
- Type validation (PDF, DOC, DOCX)
- Size limits (5MB max)
- Safe storage location
- Filename sanitization

---

## Database Schema

8 interconnected tables:

| Table | Purpose |
|-------|---------|
| `portfolio_users` | Admin authentication |
| `portfolio_settings` | Theme & profile settings |
| `portfolio_projects` | Project data |
| `portfolio_experience` | Work history |
| `portfolio_skills` | Skills by category |
| `portfolio_sections` | Custom sections |
| `portfolio_messages` | Contact submissions |
| `portfolio_files` | File upload tracking |

---

## How It Works

### Flow Diagram
```
Admin Login
    ↓
Dashboard (6 tabs)
    ↓
Modify: Profile | Projects | Theme | Typography | Animations
    ↓
Save to Database
    ↓
Portfolio Page Reloads
    ↓
Displays Updated Content with New Theme
```

### Customization Impact
- Theme colors: Applied via CSS variables (instant)
- Typography: Font family & size (immediate)
- Animations: Toggle enables/disables effects
- Profile: Bio, CV, contact info updated
- Projects: New projects appear in grid

---

## Test It Out

### Default Credentials
```
Username: admin
Password: admin123
```

### Test Scenarios
1. **Login Test:** Access dashboard with default credentials
2. **Profile Update:** Edit bio and watch portfolio update
3. **Add Project:** Create new project, verify on portfolio
4. **Theme Change:** Pick new colors, see instant portfolio changes
5. **Font Switch:** Select different font, watch text update
6. **Animation Toggle:** Enable/disable animations
7. **CV Upload:** Upload PDF/DOC/DOCX file

---

## Portfolio Display

### Portfolio Includes
Hero section with intro
About section with profile details
Projects grid (responsive)
Experience timeline
Skills showcase
Contact section (email, WhatsApp, location)
Admin link in footer

### Responsive Breakpoints
- Mobile: < 768px
- Tablet: 768px - 1024px
- Desktop: > 1024px

---

## Configuration

### Database (config.php)
```php
define('DB_HOST', 'sql110.infinityfree.com');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'if0_41898653_lawreay');
```

### Email (config.php) - Optional
```php
define('SMTP_HOST', 'smtp.gmail.com');
define('SMTP_PORT', 587);
define('SMTP_USER', 'your-email@gmail.com');
define('SMTP_PASS', 'your-app-password');
```

For Gmail, generate a 16-character app password instead of using actual password.

---

## Verification Checklist

Before going live, verify:

- [ ] Database created successfully
- [ ] Admin login works with default credentials
- [ ] Portfolio page loads at index.php
- [ ] Profile edits appear on portfolio
- [ ] Projects display in grid
- [ ] Theme colors apply in real-time
- [ ] Font changes work
- [ ] CV uploads without errors
- [ ] Password recovery email configured (optional)
- [ ] Responsive design works on mobile

---

## Troubleshooting

### "Connection failed"
→ Check MySQL is running, database exists, config.php is correct

### "Table doesn't exist"
→ Re-import database_schema.sql, verify completion

### Styles not updating
→ Hard refresh browser (Ctrl+F5), clear cache

### CV upload fails
→ Check /uploads/ permissions (755), file type, file size

### Email not sending
→ Verify SMTP settings, for Gmail enable App Passwords

### Sessions expire quickly
→ Check SESSION_TIMEOUT in config.php (default 3600 seconds)

---

## Documentation

| File | Purpose |
|------|---------|
| SETUP.md | Detailed setup instructions |
| QUICKSTART.md | 30-second quick start |
| FEATURES.md | Complete feature documentation |
| CHECKLIST.md | Setup verification checklist |
| README.md | This file |

---

## Deployment

### To Move to Live Server:
1. Upload all files to server via FTP/SFTP
2. Create database on server MySQL
3. Import database_schema.sql on server
4. Update config.php with server credentials
5. Set /uploads/ folder permissions to 755
6. Update SITE_URL in config.php
7. Test all features

### Domain Setup:
1. Point domain to server
2. Update SITE_URL in config.php
3. Update ADMIN_EMAIL for password recovery
4. Test password recovery email

---

## Learning From This System

This project demonstrates:

**Backend Skills**
- PHP 7+ best practices
- MySQL database design
- Session management
- Security (bcrypt, SQL injection prevention)
- File handling

**Frontend Skills**
- Responsive HTML/CSS
- Tailwind CSS framework
- JavaScript interactivity
- CSS variables for theming
- Modern UI/UX design

**DevOps Skills**
- Database schema design
- Configuration management
- File permissions
- Environment variables
- Error handling

---

## Next Steps

1. **Immediate:** Complete 5-step quick start above
2. **Today:** Fill in profile & add first 3 projects
3. **This Week:** Customize theme colors
4. **This Month:** Share portfolio with network
5. **Ongoing:** Keep projects updated

---

## Pro Tips

- Save your favorite color combinations
- Add project screenshots for visual appeal
- Always test demo links work
- Test password recovery after setup
- Backup database monthly
- Update portfolio quarterly
- Test mobile responsiveness regularly

---

## Support

### Issues?
1. Check browser console (F12) for errors
2. Review error logs in `/Portifolio/`
3. Check XAMPP error logs
4. Consult TROUBLESHOOTING section in SETUP.md

### Questions?
Contact: lawreay1@gmail.com

### Want to Extend?
The system is built to be modular. You can:
- Add more color themes
- Create section templates
- Integrate with APIs
- Add analytics
- Connect with CMS

---

## License

This system was created for Lawrence Phuka Chikapa - Portfolio Admin System

Feel free to customize and extend as needed for your use case.

---

## You're All Set!

Your professional portfolio admin system is ready to use. Start with the 5-minute quick start above, then explore all the amazing customization options.

**Current Version:** 1.0 (May 11, 2026)
**Status:** Production Ready
**Test Time:** ~30 minutes to full mastery

---

### Let's go! Your portfolio awaits customization.

For detailed guides, see: SETUP.md | QUICKSTART.md | FEATURES.md | CHECKLIST.md

**Made with by Lawrence Phuka Chikapa**

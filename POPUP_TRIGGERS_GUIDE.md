# Popup Trigger System - Setup & Usage Guide

## Overview
Your portfolio now supports multiple popup trigger actions:
- **Timer** - Show popup after a delay
- **Scroll** - Show popup when user scrolls to a certain percentage  
- **ESC Key** - Close popup with ESC key
- **Back Button** - Interact with popup on browser back navigation

## Step 1: Apply Database Migration

Run this migration to add trigger columns to your `portfolio_popups` table:

```sql
-- Run this in your database
ALTER TABLE portfolio_popups ADD COLUMN IF NOT EXISTS `trigger_timer` BOOLEAN DEFAULT TRUE;
ALTER TABLE portfolio_popups ADD COLUMN IF NOT EXISTS `timer_delay` INT DEFAULT 900;
ALTER TABLE portfolio_popups ADD COLUMN IF NOT EXISTS `trigger_scroll` BOOLEAN DEFAULT FALSE;
ALTER TABLE portfolio_popups ADD COLUMN IF NOT EXISTS `scroll_percentage` INT DEFAULT 50;
ALTER TABLE portfolio_popups ADD COLUMN IF NOT EXISTS `trigger_esc` BOOLEAN DEFAULT TRUE;
ALTER TABLE portfolio_popups ADD COLUMN IF NOT EXISTS `trigger_back_button` BOOLEAN DEFAULT TRUE;
```

Or import the migration file: `migrations_add_popup_triggers.sql`

## Step 2: Configure Popups in Admin Dashboard

1. Go to **Admin Dashboard → Popups Tab**
2. Create or edit a popup
3. In the **Popup Triggers** section, configure:

### Timer Trigger
- **Checkbox**: "Timer - Show after delay"
- **Input**: Delay in milliseconds (default: 900ms = 0.9 seconds)
- Example: 3000 = shows popup after 3 seconds

### Scroll Trigger  
- **Checkbox**: "Scroll - Show on scroll trigger"
- **Input**: Scroll percentage (1-100, default: 50%)
- Example: 25 = shows when user scrolls 25% down the page

### ESC Key Trigger
- **Checkbox**: "ESC key - Allow ESC to close"
- When enabled, users can press ESC to close the popup

### Back Button Trigger
- **Checkbox**: "Back button - Enable back button interaction"
- When enabled, browser back navigation can trigger/interact with popup

## Step 3: Test Your Popup

1. Save popup configuration
2. Visit your portfolio public page (index.php)
3. Watch for your popup based on enabled triggers

## Trigger Combinations

You can enable multiple triggers for one popup:

| Scenario | Timer | Scroll | ESC | Back |
|----------|-------|--------|-----|------|
| **Basic Popup** | ✓ | - | ✓ | ✓ |
| **Newsletter Signup** | ✓ | ✓ | ✓ | - |
| **Exit Intent** | - | ✓ | ✓ | ✓ |
| **Announcement** | ✓ | - | - | - |

## How It Works (Frontend)

The JavaScript automatically:
1. Reads trigger settings from popup data attributes
2. Sets up event listeners based on enabled triggers
3. Shows popup when ANY enabled trigger fires
4. Stores popup closure in sessionStorage (persists during session)
5. Prevents duplicate popups within same session

## Trigger Behavior Details

### Timer
- Fires once after specified milliseconds
- Skipped if popup already shown via other trigger
- Skipped if user closed popup

### Scroll  
- Fires when user scrolls past percentage of page
- Only triggers once per session
- Useful for "sticky" announcements

### ESC Key
- Allows closing popup with ESC key
- Does not prevent other closures
- Marks popup as "closed" for session

### Back Button
- Shows popup on browser back navigation
- Useful for exit-intent or re-engagement
- Complements other triggers

## Default Configuration

New popups use these defaults:
- **Timer**: Enabled (900ms delay)
- **Scroll**: Disabled
- **ESC Key**: Enabled
- **Back Button**: Enabled

## Advanced Examples

### Example 1: Urgent Newsletter Signup
```
- Timer: ON (2000ms - 2 seconds)
- Scroll: ON (30% - early scroll trigger)
- ESC: OFF (force interaction)
- Back Button: ON
```

### Example 2: Product Announcement
```
- Timer: ON (5000ms - 5 seconds)
- Scroll: OFF
- ESC: ON (optional)
- Back Button: OFF
```

### Example 3: Exit Intent
```
- Timer: OFF (not on page load)
- Scroll: ON (80% - near bottom)
- ESC: ON (user can escape)
- Back Button: ON (show on back)
```

## Troubleshooting

**Popup not showing?**
- Ensure popup is marked as "Active"
- Check that is_active = 1 in database
- Verify at least one trigger is enabled
- Check browser console for JavaScript errors

**Popup shows every time?**
- SessionStorage might be cleared
- Check if popups are set to display in incognito mode

**Multiple popups showing?**
- Only first popup (order_position = 1) displays
- Edit or disable other popups

**ESC not working?**
- Ensure trigger_esc = 1 in database
- Check browser focus (must be on page)

## Database Columns Reference

```
trigger_timer (BOOLEAN)           - Enable timer trigger
timer_delay (INT)                 - Milliseconds before showing
trigger_scroll (BOOLEAN)          - Enable scroll trigger  
scroll_percentage (INT)           - Scroll % threshold (1-100)
trigger_esc (BOOLEAN)             - Allow ESC key to close
trigger_back_button (BOOLEAN)     - Enable back button interaction
```

## Notes

- Popup state is stored in sessionStorage (per session)
- Only one active popup per user at a time
- Triggers are user-configurable per popup
- All settings save to database immediately
- Changes take effect on next page load

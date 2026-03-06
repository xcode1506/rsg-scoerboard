rsg-scoreboard - RedM Server Scoreboard
A comprehensive and customizable scoreboard system for RedM servers using RSG Core framework, featuring real-time player statistics, job tracking, and a western-themed UI.

📋 Overview
rsg-scoreboard is a modern scoreboard solution designed specifically for RedM servers running RSG Core. It provides real-time information about online players, active duty personnel across various job categories, and server status - all presented in an immersive western-themed interface.

✨ Features
Real-Time Player Statistics

Total online players count

Active duty personnel by job category

Individual player job and duty status

Server name display

Comprehensive Job Tracking

Medical personnel (medics)

Law enforcement officers

Wagon operators

Saloon tenders

Ranch workers

Easily extensible job categories

Smart Duty Status System

Only counts players who are actively on duty

Clear visual indication of ON DUTY / OFF DUTY status

Real-time updates as players change duty status

Immersive UI/UX

Western-themed design matching RedM aesthetic

Configurable position (default: bottom-right)

Adjustable scale and theme

Clean, organized layout

Smooth animations and transitions

Performance Optimized

Configurable refresh intervals (default: 1500ms)

Cooldown system to prevent spam

Efficient data fetching

Minimal performance impact

🎮 Controls
Key/Command	Action	Description
/scoreboard	Toggle	Opens/closes the scoreboard
ESC Key	Close	Closes the scoreboard
BACKSPACE Key	Close	Alternative close key
🔧 Configuration
Job Categories
Edit config.lua to customize job categories and assignments:

lua
Config.Jobs = {
    Medic = {'medic', 'doctor', 'ems'},           -- Medical personnel
    Lawman = {'sheriff', 'deputy', 'marshal'},     -- Law enforcement
    Wagon = {'wagon_driver', 'stagecoach'},        -- Wagon operators
    Saloon = {'bartender', 'saloon_owner'},        -- Saloon workers
    Ranch = {'rancher', 'farmhand'}                 -- Ranch workers
}
UI Settings
lua
Config.UI = {
    position = "bottom-right",  -- Options: top-left, top-right, bottom-left, bottom-right
    scale = 0.8,                 -- UI scale (0.5 to 1.5)
    theme = "western",           -- Theme style
    timeFormat = 12              -- 12 or 24 hour format
}
Performance Settings
lua
Config.RefreshInterval = 1500    -- Data refresh interval in milliseconds
Config.Debug = false             -- Enable/disable debug logging
📥 Installation
Download the resource to your server's resources folder

Ensure rsg-core is properly installed and running

Add to your server.cfg:

text
ensure rsg-scoreboard
Configure job lists in config.lua to match your server's jobs

Restart your server or start the resource

🔒 Dependencies
RSG Core - Required framework

🚀 Usage
Basic Usage
Press the configured key or type /scoreboard to open

View real-time statistics of all online players

See active duty personnel across all job categories

Check your own job status and grade

Press ESC or BACKSPACE to close

For Developers
lua
-- Check if scoreboard is open
local isOpen = exports['rsg-scoreboard']:IsScoreboardOpen()

-- Trigger scoreboard toggle
TriggerEvent('rsg-scoreboard:toggle')
📊 Data Displayed
Server Name: Customizable server identifier

Total Players: Current online player count

Medical Personnel: Active medics/EMS on duty

Law Enforcement: Active lawmen/sheriffs on duty

Wagon Operators: Active wagon drivers on duty

Saloon Workers: Active saloon tenders on duty

Ranch Workers: Active ranch hands on duty

Player Info: Your current job, grade, and duty status

🔄 Automatic Updates
Real-time refresh: Data updates at configured intervals

On-duty changes: Immediately reflects job status changes

Player joins/leaves: Automatically updates player counts

Resource start: Proper initialization and cleanup

🛠️ Advanced Features
Custom Job Categories
Easily add new job categories by extending the Config.Jobs table:

lua
Config.Jobs = {
    -- Existing categories...
    Mining = {'miner', 'prospector'},      -- New category
    Farming = {'farmer', 'harvester'}       -- New category
}
Export Functions
lua
-- Returns boolean indicating if scoreboard is currently open
exports['rsg-scoreboard']:IsScoreboardOpen()
Events
lua
-- Trigger to toggle scoreboard
TriggerEvent('rsg-scoreboard:toggle')

-- Trigger to manually refresh data
TriggerEvent('rsg-scoreboard:requestData')
🔐 Security Features
Server-side validation of all data

No client-side manipulation of counts

Proper permission checking

Secure callback system

📁 File Structure
text
rsg-scoreboard/
├── fxmanifest.lua
├── config.lua
├── server.lua
├── client.lua
└── html/
    ├── index.html
    ├── style.css
    └── script.js
⚙️ Technical Details
Framework: RSG Core

Language: Lua (Server/Client), JavaScript/HTML/CSS (UI)

Data Flow: Server callbacks → Client NUI messages

Refresh Rate: Configurable (default 1.5 seconds)

NUI Focus: Smart focus management to maintain gameplay

🎨 Customization
UI Positioning
The scoreboard can be positioned in any corner:

top-left

top-right

bottom-left

bottom-right

Scaling
Adjust the UI scale to match your preferences:

Range: 0.5 (smaller) to 1.5 (larger)

Default: 0.8

Themes
Currently supports:

western - Default western theme

More themes can be added via CSS

🔍 Troubleshooting
Q: Scoreboard not opening?

Check if command is bound correctly

Verify resource is started

Check client console for errors

Q: Wrong job counts?

Verify job names in config match exactly

Check if players are actually on duty

Ensure refresh interval is appropriate

Q: UI looks wrong?

Adjust scale in config

Check if all UI files are present

Clear cache and restart

Q: Performance issues?

Increase refresh interval

Disable debug mode

Check for conflicts with other resources

📝 Notes
Only counts players who are on duty in job categories

Off-duty players are not counted in job statistics

Your own job display shows grade and duty status

Server name can be customized in the data payload

Debug mode should be disabled in production

🚀 Performance Tips
Set Config.RefreshInterval to 2000-3000ms for larger servers

Keep Config.Debug = false in production

Monitor server FPS impact

Adjust scale based on screen resolution

📄 License
This resource is open-source and free to use for RedM servers. Feel free to modify and customize for your server's needs.

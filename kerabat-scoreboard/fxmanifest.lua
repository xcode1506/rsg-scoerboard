fx_version 'cerulean'
game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Kerabat RP'
description 'Kerabat Scoreboard System'
version '1.3.0'

lua54 'yes'

-- Dependencies
dependencies {
    'rsg-core'
}


shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/script.js',
    'ui/style.css'
}

-- Exports
exports {
    'IsScoreboardOpen'
}

client_exports {
    'IsScoreboardOpen'
}
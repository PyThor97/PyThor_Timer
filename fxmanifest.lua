fx_version 'cerulean'
game { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name 'PyThor_Timer'
author 'PyThor'
description 'RedM script to start timer in game using NUI'
lua54 'yes'

shared_scripts { 'config.lua' }

client_script { 'client/client.lua' }

ui_page 'nui/nui.html'

files {
    'nui/nui.html',
    'nui/style.css',
    'nui/script.js',
    'nui/images/*'
}

version '1.0'
vorp_checker 'yes'
vorp_name '^5PyThor_Timer ^4version Check^3'
vorp_github 'https://github.com/PyThor97/PyThor_Timer'

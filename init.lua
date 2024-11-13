logger = hs.logger.new('init.lua', 'debug')
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local SwitchHosts = require("SwitchHosts")
SwitchHosts.proxyGroup = {
    Default = {"GitHub520", "Onedrive"},
    Home = {"AX89X"},
    Office = {"Hetao101"},
    Feilian = {"Testing0"},
    WireGuard = {"WireGuard"},
}

function arriveHome()
    SwitchHosts.switchGroup("Home", true)
end

function leaveHome()
    SwitchHosts.switchGroup("Home", false)
end

function arriveOffice()
    SwitchHosts.switchGroup("Office", true)
end

function leaveOffice()
    SwitchHosts.switchGroup("Office", false)
end

function commonEvent(module, event,  message, data)
    logger.i(string.format("%s: %s: %s", module, event, message))
    hs.notify.new({title=module, informativeText=string.format("%s\n%s", event, message)}):send()
end

local watchers = {
    require('BatteryWatcher'),
    require('UsbWatcher'),
    require('WiFiWatcher'),
    require('ScreenWatcher'),
    --require('ApplicationWatcher'),
}

for _, watcher in ipairs(watchers) do
    watcher:start(commonEvent)
end


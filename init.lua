logger = hs.logger.new('init.lua', 'debug')

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool:start()
spoon.ClipboardTool:bindHotkeys({
  toggle_clipboard = {{'cmd', 'shift'}, 'X'},
})

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


local M = {}
M.watcher = nil
function usbChangedCallback(event)
    hs.notify.new({
        title="USB " .. event["eventType"], 
        informativeText=event["productName"]}):send()
end
M.watcher = hs.usb.watcher.new(usbChangedCallback)
M.watcher:start()
return M

-- internal State
local S = {
    watcher = nil,
    notify = nil,
}

function usbChangedCallback(event)
    message = event["productName"]
    if message == "" then
        message = event["vendorName"] .. " #" .. event["productID"]
    end
    if event["eventType"] == "added" then
        S.notify("USB", "Connected", message, event)
    else 
        S.notify("USB", "Disconnected", message, event)
    end
end

-- external Interface
local M = {
    module = "USB",
    start = function(self, notify)
        if notify then
            S.notify = notify
        end
        S.watcher = hs.usb.watcher.new(usbChangedCallback)
        S.watcher:start()
    end,
}

return M


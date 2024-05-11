-- internal State
local S = {
    watcher = nil,
    notify = nil,
}

function usbChangedCallback(event)
    if event["eventType"] == "added" then
        S.notify("USB", "Connected", event["productName"], event)
    else 
        S.notify("USB", "Disconnected", event["productName"], event)
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


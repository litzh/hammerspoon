-- internal State
local S = {
    previousSSID = hs.wifi.currentNetwork(),
    watcher = nil,
    notify = nil,
}

function ssidChangedCallback()
    currentSSID = hs.wifi.currentNetwork()
    if currentSSID ~= S.previousSSID then
        if S.previousSSID == nil then
            S.notify("WiFi", "Connected", currentSSID)
        elseif currentSSID == nil then
            S.notify("WiFi", "Disconnected", S.previousSSID)
        else
            S.notify("WiFi", "Disconnected", S.previousSSID)
            S.notify("WiFi", "Connected", currentSSID)
        end
        S.previousSSID = currentSSID
    end
end

-- external Interface
local M = {
    module = "WiFi",
    start = function(self, notify)
        if notify then
            S.notify = notify
        end
        S.watcher = hs.wifi.watcher.new(ssidChangedCallback)
        S.watcher:start()
    end,
}

return M

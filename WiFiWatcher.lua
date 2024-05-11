local M = {}
M.watcher = nil
M.previousSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    currentSSID = hs.wifi.currentNetwork()
    if currentSSID ~= M.previousSSID then
        if not currentSSID then
            currentSSID = "<disconnected>"
        end
        hs.notify.new({title="WiFi", informativeText=currentSSID}):send()
        M.previousSSID = currentSSID
    end
end

M.watcher = hs.wifi.watcher.new(ssidChangedCallback)
M.watcher:start()
return M

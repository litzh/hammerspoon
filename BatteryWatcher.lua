-- internal State
local S = {
    previousPowerSource = hs.battery.powerSource(),
    watcher = nil,
    notify = nil,
}

function batteryChangedCallback()
    local powerSource = hs.battery.powerSource()
    if powerSource == S.previousPowerSource then
        return
    end
    --S.notify("Battery", "Disconnected", S.previousPowerSource)
    S.notify("Battery", "Connected", powerSource)
    S.previousPowerSource = powerSource
end

-- external Interface
local M = {
    module = "Battery",
    start = function(self, notify)
        if notify then
            S.notify = notify
        end
        S.watcher = hs.battery.watcher.new(batteryChangedCallback)
        S.watcher:start()
    end,
}

return M

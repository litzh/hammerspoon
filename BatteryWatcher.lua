local M = {}
M.watcher = nil
M.previousPowerSource = hs.battery.powerSource()
function batteryChangedCallback()
    local powerSource = hs.battery.powerSource()
    if powerSource == M.previousPowerSource then
        return
    end
    M.previousPowerSource = powerSource
    hs.notify.new({
        title="Battery",
        informativeText="Power Source: " .. powerSource
    }):send()
end
M.watcher = hs.battery.watcher.new(batteryChangedCallback)
M.watcher:start()
return M

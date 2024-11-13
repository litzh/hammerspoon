-- internal State
local S = {
    watcher = nil,
    notify = nil,
}

function applicationChangedCallback(name, event, app)
    eventName = 'unknown'
    if event == hs.application.watcher.activated then
        eventName = 'activated'
    elseif event == hs.application.watcher.deactivated then
        eventName = 'deactivated'
    elseif event == hs.application.watcher.hidden then
        eventName = 'hidden'
    elseif event == hs.application.watcher.launched then
        eventName = 'launched'
    elseif event == hs.application.watcher.launching then
        eventName = 'launching'
    elseif event == hs.application.watcher.terminated then
        eventName = 'terminated'
    elseif event == hs.application.watcher.unhidden then
        eventName = 'unhidden'
    end

    S.notify("Application", eventName, name, app)
end

-- external Interface
local M = {
    module = "Application",
    start = function(self, notify)
        if notify then
            S.notify = notify
        end
        S.watcher = hs.application.watcher.new(applicationChangedCallback)
        S.watcher:start()
    end,
}

return M

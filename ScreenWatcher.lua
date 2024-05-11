-- internal State
local S = {
    screens = hs.screen.allScreens(),
    watcher = nil,
    notify = nil,
    builtinId = 1, -- This is the id of the built-in display
}

function screenWatcherCallback()
    local newScreens = hs.screen.allScreens()
    for i, screen in ipairs(S.screens) do
        if not hs.fnutils.contains(newScreens, screen) then
            S.notify("Screen", "Disconnected", screen:name())
        end
    end
    for i, screen in ipairs(newScreens) do
        if not hs.fnutils.contains(S.screens, screen) then
            S.notify("Screen", "Connected", screen:name())
        end
    end
    S.screens = newScreens
end


-- external Interface
local M = {
    module = "Screen",
    start = function(self, notify)
        if notify then
            S.notify = notify
        end
        S.watcher = hs.screen.watcher.new(screenWatcherCallback)
        S.watcher:start()
    end,
}

return M

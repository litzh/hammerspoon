local M = {}
M.watcher = nil
M.screens = hs.screen.allScreens()
M.builtinId = 1 -- This is the id of the built-in display
function screenWatcherCallback()
    local newScreens = hs.screen.allScreens()
    for i, screen in ipairs(newScreens) do
        if not hs.fnutils.contains(M.screens, screen) then
            hs.notify.new({
                title="Screen connected",
                informativeText=screen:name() .. " #" .. screen:id()
            }):send()
        end
    end
    for i, screen in ipairs(M.screens) do
        if not hs.fnutils.contains(newScreens, screen) then
            hs.notify.new({
                title="Screen disconnected",
                informativeText=screen:name() .. " #" .. screen:id()
            }):send()
        end
    end
    M.screens = newScreens
end

M.watcher = hs.screen.watcher.new(screenWatcherCallback)
M.watcher:start()
return M

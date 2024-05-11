local M = {}
M.watcher = nil
function audioChangedCallback(event)
    hs.notify.new({title="Audio", informativeText=event}):send()
end
if hs.audiodevice.watcher.isRunning()
then
    hs.audiodevice.watcher.stop()
end
hs.audiodevice.watcher.setCallback(audioChangedCallback)
hs.audiodevice.watcher.start()
return M

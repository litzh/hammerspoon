hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.notify.new({title="Hammerspoon", informativeText="配置已加载"}):send()

logger = hs.logger.new('SwitchHosts', 'debug')
proxyGroup = {
    Default = {"GitHub520", "Onedrive"},
    Home = {"AX89X"},
    Office = {"Hetao101"},
    Feilian = {"Testing0"},
    WireGuard = {"WireGuard"},
}

function loadCurrentProxy()
    local status, body, headers = hs.http.get("http://127.0.0.1:50761/api/list")
    if status ~= 200 then
        logger.e("Failed to get current proxy")
        return nil
    end
    resp = hs.json.decode(body)
    if resp == nil then
        logger.e("Failed to decode json")
        return nil
    end
    data = resp["data"]
    if data == nil then
        logger.e("Failed to get data")
        return nil
    end
    -- build title map
    local titleMap = {}
    for i, v in ipairs(data) do
        titleMap[v["title"]] = v
    end
    return titleMap
end

function switchProxy(proxy, on)
    local status, body, headers = hs.http.get("http://127.0.0.1:50761/api/toggle?id=" .. proxy["id"])
    if status ~= 200 then
        logger.e("Failed to switch proxy: " .. proxy["title"])
        return
    end
    logger.i(string.format("Switched %s to %s: %s", proxy["title"], on and "on" or "off", body))
end

function switchGroup(group, on)
    local proxies = proxyGroup[group]
    if proxies == nil then
        logger.e("Failed to get proxies for group: " .. group)
        return
    end
    local titleMap = loadCurrentProxy()
    if titleMap == nil then
        logger.e("Failed to get current proxy")
        return
    end
    local delay = 1
    for i, v in ipairs(proxies) do
        local proxy = titleMap[v]
        if proxy == nil then
            logger.e("Failed to get proxy: " .. v)
            return
        end
        if proxy["on"] ~= on then
            hs.timer.doAfter(delay, function()
                switchProxy(proxy, on)
            end)
            delay = delay + 1
        end
    end 
end

local M = {
    switchGroup = switchGroup,
    proxyGroup = proxyGroup,
}
return M

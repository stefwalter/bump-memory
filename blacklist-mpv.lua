local blacklist = { "nude", "naked", "attack", "/dup/", "/trash/", ".opus" }
local msg = require 'mp.msg'
local utils = require 'mp.utils'

function should_remove(path)

    -- don't remove playlist entry if it's a stream or directory
    local file = utils.file_info(path)
    if not file or file.is_dir then
        return false
    end

    for i = #blacklist, 1, -1 do
    	if string.match(string.lower(path), blacklist[i]) then
        	return true
    	end
end
    return false
end

function process(playlist_count)
    if playlist_count < 2 then return end
    local playlist = mp.get_property_native("playlist")
    local removed = 0
    for i = #playlist, 1, -1 do
        if should_remove(playlist[i].filename) then
            msg.warn("BLACKLIST: " .. playlist[i].filename)
            mp.commandv("playlist-remove", i-1)
            removed = removed + 1
        end
    end
    if removed == #playlist then
        msg.warn("Removed everything from the playlist")
    end
end

function observe(k,v) process(v) end

mp.observe_property("playlist-count", "number", observe)

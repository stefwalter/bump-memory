local msg = require 'mp.msg'
local utils = require 'mp.utils'

function trash()
    local path = mp.get_property("path")
    local parent, filename = utils.split_path(path)

    local trashpath = utils.join_path(parent, "../trash")
    local trashdir = utils.file_info(trashpath)
    if not trashdir or not trashdir.is_dir then
        msg.warn("no trash: " .. trashpath)
        return
    end

    local target = utils.join_path(trashpath, filename)
    os.rename(path, target)
    msg.warn("TRASH: " .. filename)
    mp.command("playlist-next")
end

mp.add_key_binding("SHIFT+DEL", trash)

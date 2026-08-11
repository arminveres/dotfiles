local scroll = require("maki.scroll")

maki.keymap.set("n", "<C-e>", function()
    scroll(1)
end, { desc = "Scroll down one line" })

maki.keymap.set("n", "<C-y>", function()
    scroll(-1)
end, { desc = "Scroll up one line" })

-- TODO: add a new picker, the default one is overridden by tmux
--
-- maki.keymap.del("n", "<C-s>")
maki.keymap.set("n", "<C-q>", function()
    local id = maki.fn.jobstart("git ls-files --cached --others --exclude-standard")
    local result = maki.fn.jobwait(id, 5000)
    if not result or result.exit_code ~= 0 then
        maki.ui.flash("file picker error: " .. tostring(result and result.stderr))
        return
    end

    local files = maki.split(result.stdout, "\n", { trimempty = true })
    if #files == 0 then
        maki.ui.flash("no files found")
        return
    end

    local picked = require("maki.list_picker").open(files, { title = "Files" })
    if picked.type ~= "choice" then
        return
    end

    maki.session.prompt("@" .. files[picked.index])
end, { desc = "File picker" })

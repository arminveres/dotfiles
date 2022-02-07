local tabby_status_ok, tabby = pcall(require, "tabby")
if not tabby_status_ok then
  return
end

tabby.setup()

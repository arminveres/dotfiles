local status_ok, terminal = pcall(require, 'terminal')
if not status_ok then
  return
end

terminal.setup()

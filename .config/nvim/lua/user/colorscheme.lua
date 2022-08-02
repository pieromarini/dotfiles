local everblush_status_ok, everblush = pcall(require, "everblush")
if not everblush_status_ok then
	return
end

everblush.setup({ nvim_tree = { contrast = true } })

local M = {}

---@class TatrCommand
---@field impl fun(args: string[], opts: table) The command implementation
---@field complete? fun(subcmd_arg_lead: string): string[] (optional) command completion callbacke


local function handle_on_exit(out)
	vim.schedule(function ( )
		if out.code == 0 then
			print(out.stdout)
		else
			vim.notify(out.stderr, vim.log.levels.ERROR)
		end
	end)
end

local function handle_subcmd_completion_args(subcmd_args,  lead)
	return vim.iter(subcmd_args)
			:filter(function(install_arg)
					return install_arg:find(lead) ~= nil
			end)
			:totable()
end

---@type table<string, TatrCommand>
local subcmd_table = {
	ls = {
		impl = function (args, _)
			local cmd = vim.list_extend({"tatr", "ls"}, args)
			vim.system(cmd, handle_on_exit)
		end,
		complete = function (subcmd_arg_lead)
			local subcmd_args_list = {
				"-c",
				"-a",
				"-id",
			}
			return handle_subcmd_completion_args(subcmd_args_list, subcmd_arg_lead)
		end
	},
	init = {
		impl = function (_, _)
			vim.system({'tatr', 'init'}, handle_on_exit) 
		end,
		complete = function (subcmd_arg_lead)
			local subcmd_args_list = {
				"-no-readme"
			}
			return handle_subcmd_completion_args(subcmd_args_list, subcmd_arg_lead)
		end
	},
	new = {
		impl = function (args, _)
			local cmd = vim.list_extend({'tatr', 'new'}, args)
			vim.system(cmd, handle_on_exit)
		end,
		complete = function (subcmd_arg_lead)
			local subcmd_args_list = {
				'-t',
				'-p',
				'-s',
			}
			return handle_subcmd_completion_args(subcmd_args_list, subcmd_arg_lead)
		end
	},
	summary = {
		impl = function (args, _)
			local cmd = vim.list_extend({'tatr', 'summary'}, args)
			vim.system(cmd, handle_on_exit)
		end,
		complete = function (subcmd_arg_lead)
			local subcmd_args_list = {
				'-c',
			}
			return handle_subcmd_completion_args(subcmd_args_list, subcmd_arg_lead)
		end
	},
	find = {
		impl = function (args, _)
			local cmd = vim.list_extend({'tatr', 'find'}, args)
			vim.system(cmd, handle_on_exit)
		end,
		complete = function (subcmd_arg_lead)
			local subcmd_args_list = {
				'-path-only',
			}
			return handle_subcmd_completion_args(subcmd_args_list, subcmd_arg_lead)
		end
	},
	ref = {
		impl = function (args, _)
			local cmd = vim.list_extend({'tatr', 'ref'}, args)
			vim.system(cmd, handle_on_exit)
		end
	},
	untag = {
		impl = function (args, _)
			local cmd = vim.list_extend({'tatr', 'untag'}, args)
			vim.system(cmd, handle_on_exit)
		end,
		complete = function (subcmd_arg_lead)
			local subcmd_args_list = {
				'-t',
				'-c',
			}
			return handle_subcmd_completion_args(subcmd_args_list, subcmd_arg_lead)
		end
	},
}

local function tatr_commands_impl(opts)
		local fargs = opts.fargs
    local subcommand_key = fargs[1]
    local args = #fargs > 1 and vim.list_slice(fargs, 2, #fargs) or {}
    local subcommand = subcmd_table[subcommand_key]
    if not subcommand then
        vim.notify("Tatr: Unknown command: " .. subcommand_key, vim.log.levels.ERROR)
        return
    end
    subcommand.impl(args, opts)
end

function M.setup(opts)
	opts = opts or {}

	vim.api.nvim_create_user_command("Tatr", tatr_commands_impl, {
		nargs = "+",
		desc = "Tatr commands and subcommands",
		complete = function (arg_lead, cmdline, _)
			local subcmd_key, subcmd_arg_lead = cmdline:match("^['<,'>]*Tatr[!]*%s(%S+)%s(.*)$")

			if subcmd_key and subcmd_arg_lead and subcmd_table[subcmd_key] and subcmd_table[subcmd_key].complete then
				return subcmd_table[subcmd_key].complete(subcmd_arg_lead)
			end

			if cmdline:match("^['<,'>]*Tatr[!]*%s+%w*$") then
				local subcommand_key = vim.tbl_keys(subcmd_table)
				return vim.iter(subcommand_key):filter(function (key)
					return key:find(arg_lead) ~= nil
				end):totable()
			end
		end
	})
end

return M

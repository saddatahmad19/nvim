return {
	"nosduco/remote-sshfs.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	opts = {
		connections = {
			ssh_configs = { -- which ssh configs to parse for hosts list
				vim.fn.expand("$HOME") .. "/.ssh/config",
				"/etc/ssh/ssh_config",
				-- "/path/to/custom/ssh_config"
			},
			sshfs_args = { -- arguments to pass to the sshfs command
				"-o reconnect",
				"-o ConnectTimeout=5",
			},
		},
		mounts = {
			base_dir = vim.fn.expand("$HOME") .. "/.sshfs/", -- base directory for mount points
			unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
		},
	},
}

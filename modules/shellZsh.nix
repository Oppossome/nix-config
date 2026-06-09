{ self, inputs, ... }: {
	flake.nixosModules.shellZsh = { pkgs, ... }: {
		programs.zoxide = {
			enable = true;
			enableZshIntegration = true;
			flags = [ "--cmd cd" ];
		};

		programs.zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestions.enable = true;
			syntaxHighlighting.enable = true;

			histSize = 10000;
			histFile = "$HOME/.zsh_history";
			setOptions = [ "HIST_IGNORE_ALL_DUPS" ];

			ohMyZsh = {
                enable = true;
                plugins = [ "git" ];
                theme = "essembeh";
			};
		};

		environment.systemPackages = with pkgs; [ fastfetch git tree ];
		users.defaultUserShell = pkgs.zsh;
		environment.shells = [ pkgs.zsh ];
	};
}
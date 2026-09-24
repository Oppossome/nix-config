{ self, inputs, ... }: {
	flake.nixosModules.desktopHyprshell = { pkgs, helpers, lib, ... }: {
		programs.hyprland = {
			enable = true;
			withUWSM = true; # recommended for most users
			xwayland.enable = true; # Xwayland can be disabled.
		};

		environment.systemPackages = with pkgs; [
			ghostty
			hyprlauncher
			hyprpicker
			hyprshot
			quickshell
		];
	};
}

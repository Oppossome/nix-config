{ self, inputs, ... }: {
	flake.nixosModules.desktopPlasma = { pkgs, ... }: {
		services.displayManager.sddm.enable = true;
		services.desktopManager.plasma6.enable = true;
		environment.plasma6.excludePackages = with pkgs.kdePackages; [
			elisa
			kate
			konsole
			plasma-browser-integration
			qrca
		];

		# Audio stack.
		services.pulseaudio.enable = false;
		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			# If you want to use JACK applications, uncomment this
			#jack.enable = true;
		};

		environment.systemPackages = with pkgs; [
			ghostty
			kdePackages.sddm-kcm # KDE SDDM Manager
		];
	};
}
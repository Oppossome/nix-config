{ self, inputs, ... }: {
	flake.nixosModules.desktopPlasma = { pkgs, helpers, ... }: {
		services.displayManager.sddm.enable = true;
		services.desktopManager.plasma6.enable = true;
		environment.plasma6.excludePackages = with pkgs.kdePackages; [
			elisa
			kate
			konsole
			plasma-browser-integration
			qrca
		];

		# Screenshot config applied to all managed users via home-manager.
		home-manager.users = helpers.mapUsers (_: {
			programs.plasma.enable = true;
			
			programs.plasma.configFile.spectaclerc = {
				General.clipboardGroup = "PostScreenshotCopyImage";
				ImageSave.translatedScreenshotsFolder = "Screenshots";
				VideoSave.translatedScreencastsFolder = "Screencasts";
			};

			programs.plasma.spectacle.shortcuts = {
				captureRectangularRegion = "Meta+Shift+S";
			};
		}) [];

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
			nur.repos.ccicnce113424.waywallen-bin # Waywallen
		];
	};
}
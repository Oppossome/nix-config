{ self, inputs, ... }: {
	flake.nixosModules.desktopPlasma = { pkgs, helpers, lib, ... }: {
		services.displayManager.sddm.enable = true;
		services.desktopManager.plasma6.enable = true;
		environment.plasma6.excludePackages = with pkgs.kdePackages; [
			elisa
			kate
			konsole
			plasma-browser-integration
			qrca
		];

		# Enable KDE Connect
		programs.kdeconnect.enable = true;
		networking.firewall = rec {
			allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
			allowedUDPPortRanges = allowedTCPPortRanges;
		};

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

		programs.partition-manager.enable = true;
		environment.systemPackages = with pkgs; [
			ghostty
			kdePackages.kamoso
			kdePackages.sddm-kcm # KDE SDDM Manager
			kdePackages.filelight
			kdePackages.isoimagewriter
			kdePackages.fcitx5-configtool
		 	nur.repos.ccicnce113424.waywallen-bin
			nur.repos.ccicnce113424.waywallen-display-bin
		];

		i18n.inputMethod = {
			enable = true;
			type = "fcitx5";
			fcitx5 = {
				waylandFrontend = true;
				addons = with pkgs; [
					kdePackages.fcitx5-qt
					qt6Packages.fcitx5-chinese-addons
					fcitx5-nord
				];
			};
		};

		# Screenshot config applied to all managed users via home-manager.
		home-manager.users = helpers.mapUsers (user: {
			programs.plasma.enable = true;
			
			programs.plasma.configFile.spectaclerc = {
				General.clipboardGroup = "PostScreenshotCopyImage";
				ImageSave.translatedScreenshotsFolder = "Screenshots";
				VideoSave.translatedScreencastsFolder = "Screencasts";
				VideoSave.videoSaveLocation="file:///home/${user}/Videos/Replays/";
			};

			programs.plasma.spectacle.shortcuts = {
				captureRectangularRegion = "Meta+Shift+S";
			};

			programs.plasma.configFile.kwinrc = {
				Windows.PerOutputVirtualDesktops = true;
				EdgeBarrier.CornerBarrier = false;
				EdgeBarrier.EdgeBarrier = 0;
			};

			xdg.configFile."autostart/waywallen.desktop" = {
				force = true;
				text = lib.generators.toINI {} {
					"Desktop Entry" = {
						Type = "Application";
						Name = "Waywallen";
						Exec = "waywallen --no-ui";
						Terminal = false;
						StartupNotify = false;
					};
				};
			};
		}) [];
	};
}
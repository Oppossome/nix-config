{ ... }: {
	flake.nixosModules.hostsLaptopHardware = { config, lib, modulesPath, ... }: {
		imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

		boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
		boot.initrd.kernelModules = [ ];
		boot.kernelModules = [ "kvm-amd" ];
		boot.extraModulePackages = [ ];

		# Fixes audio issues on this model
		# See: https://github.com/NixOS/nixos-hardware/blob/0471accf8d0a8210b31d947497d179ecc99e0021/framework/13-inch/amd-ai-300-series/default.nix#L31-L34
		boot.blacklistedKernelModules = [ "snd_acp70" "snd_acp_pci" ];
		boot.kernelParams = [ "amd_pstate=active" ];

		fileSystems."/" = { 
			device = "/dev/mapper/luks-d1682b77-7dde-4ab4-bcd4-131fbfe17547";
			fsType = "ext4";
		};

		boot.initrd.luks.devices."luks-d1682b77-7dde-4ab4-bcd4-131fbfe17547".device = "/dev/disk/by-uuid/d1682b77-7dde-4ab4-bcd4-131fbfe17547";

		fileSystems."/boot" = { 
			device = "/dev/disk/by-uuid/7A61-B2BE";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};

		swapDevices = [ ];

		# Onboard ambient light sensor
		hardware.sensor.iio.enable = true;
		hardware.enableRedistributableFirmware = true;
		hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

		nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	};
}

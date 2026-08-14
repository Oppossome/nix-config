{ ... }: {
	flake.nixosModules.hostsLaptopHardware = { config, lib, modulesPath, ... }: {
		imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

		boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
		boot.initrd.kernelModules = [ ];
		boot.kernelModules = [ "kvm-amd" ];
		boot.extraModulePackages = [ ];

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

		nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
		hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}

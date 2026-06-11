{ ... }: {
	flake.nixosModules.hostDesktopHardware = { config, lib, modulesPath, ... }: {
		imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

		boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
		boot.initrd.kernelModules = [ ];
		boot.kernelModules = [ ];
		boot.extraModulePackages = [ ];

		fileSystems."/" = {
			device = "/dev/disk/by-uuid/5872d3eb-6b14-4a75-9f8d-6c03d535aa42";
			fsType = "ext4";
		};

		swapDevices = [ ];

		nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
		hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}

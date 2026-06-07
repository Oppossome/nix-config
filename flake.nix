{
	description = "Oppossome's binraider config";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};
	outputs = inputs: {
		nixosConfigurations = {
			binraider = inputs.nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [ ./hardware-configuration.nix ./configuration.nix ];
				specialArgs = { inherit inputs; };
			};
		};
	};
}
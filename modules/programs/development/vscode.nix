{ self, inputs, ... }: {
	flake.nixosModules.programsDevelopmentVSCode = { pkgs, ... }: {
		environment.systemPackages = [
			(pkgs.vscode.overrideAttrs (old: {
				postFixup = (old.postFixup or "") + ''
					chmod +x $out/lib/vscode/resources/app/node_modules.asar.unpacked/@github/copilot-sdk-linux-x64/prebuilds/linux-x64/copilot-runtime
				'';
			}))
		];
	};
}

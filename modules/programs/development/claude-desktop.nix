{ self, inputs, ... }: {
	flake.nixosModules.programsDevelopmentClaudeDesktop = { pkgs, ... }: {
		environment.systemPackages = [
			inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
		];
	};
}

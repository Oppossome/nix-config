{ self, inputs, ... }: {
    flake.nixosModules.programsGamingMinecraft = { pkgs, ... }: {
        imports = [ self.nixosModules.programsFlatpak ];
        services.flatpak.packages = [
            "org.prismlauncher.PrismLauncher"
        ];
    };
}
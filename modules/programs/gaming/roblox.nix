{ self, inputs, ... }: {
    flake.nixosModules.programsGamingRoblox = { pkgs, ... }: {
        imports = [ self.nixosModules.programsFlatpak ];
        services.flatpak.packages = [
            "org.vinegarhq.Sober"
            "org.vinegarhq.Vinegar"
        ];
    };
}
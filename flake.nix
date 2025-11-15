{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs-24.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # winapps = {
    #   url = "github:winapps-org/winapps";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvf = {
    # url = "github:notashelf/nvf";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };
    # firefox-addons = {
    # url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };

    # COMING SOON...
    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-24,
    nixpkgs-unstable,
    home-manager,
    # winapps,
    # nvf,
    # firefox-addons,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    homeStateVersion = "25.05";
    user = "fotom";
    hosts = [
      {
        hostname = "nixos";
        stateVersion = "25.05";
      }
    ];

    overlays = [
      (final: prev: {
        prismlauncher-unwrapped-custom = prev.callPackage ./pkgs/prism {};
        prismlauncher-custom = prev.callPackage ./pkgs/prism/wrapper.nix {};
      })
    ];

    makeSystem = {
      hostname,
      stateVersion,
    }:
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          unstablePkgs = nixpkgs-unstable.legacyPackages.${system};
          nixpkgs24 = nixpkgs-24.legacyPackages.${system};
          inherit inputs stateVersion hostname user;
        };
        # pkgs = nixpkgs.legacyPackages.${system};
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = overlays;
        };

        modules = [
          ./hosts/${hostname}/configuration.nix
          # ({pkgs, ...}: {
          #   environment.systemPackages = [
          #     inputs.winapps.packages.${pkgs.system}.winapps
          #     inputs.winapps.packages.${pkgs.system}.winapps-launcher
          #   ];
          # })
        ];
      };
  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs
      // {
        "${host.hostname}" =
          makeSystem {inherit (host) hostname stateVersion;};
      }) {}
    hosts;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };

      extraSpecialArgs = {
        inherit inputs homeStateVersion user;
        unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
        nixpkgs24 = import inputs.nixpkgs-24 {
          inherit system overlays;
          config.allowUnfree = true;
        };
      };

      modules = [
        ./home-manager/home.nix
        # nvf.homeManagerModules.default
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];
    };
  };
}

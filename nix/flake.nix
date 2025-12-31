{
  description = "Darwin system and Home Manager configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };
  
  outputs = { self, nixpkgs, darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask }: 
  let
    username = "kanorix";
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    darwinConfigurations.${username} = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        {
          # Determinate Nix用の設定
          nix.enable = false;

          # システム設定
          users.users.${username} = {
            name = "${username}";
            home = "/Users/${username}";
            isHidden = false;
            shell = pkgs.zsh;
          };

          # nix-homebrewの設定
          nix-homebrew = {
             # Install Homebrew under the default prefix
            enable = true;

            # User owning the Homebrew prefix
            user = username;

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
          };

          homebrew = {
            # This is a module from nix-darwin
            # Homebrew is *installed* via the flake input nix-homebrew
            enable = true;
            casks = pkgs.callPackage ./casks.nix {};

            # These app IDs are from using the mas CLI app
            # mas = mac app store
            # https://github.com/mas-cli/mas
            #
            # $ nix shell nixpkgs#mas
            # $ mas search <app name>
            #
            masApps = {
              "Dropover" = 1355679052;
            };
          };

          # macOSのシステム設定例
          system = {
            # 必須設定
            stateVersion = 6;
            primaryUser = username;

            # 設定
            defaults = {
              NSGlobalDomain.AppleShowAllExtensions = true;
              dock = {
                autohide = true;
                show-recents = false;
              };
              trackpad.Clicking = false;
              finder = {
                AppleShowAllExtensions = true;
                _FXShowPosixPathInTitle = false;
              };
              controlcenter = {
                BatteryShowPercentage = true;
              };
              CustomUserPreferences = {
                "com.apple.symbolichotkeys" = {
                  AppleSymbolicHotKeys = {
                    # Spotlight Search('Cmd + Space')を無効化する
                    "64" = {
                      enabled = false;
                    };
                    # Finder search window('Cmd + Alt + Space')を無効化する
                    "65" = {
                      enabled = false;
                    };
                  };
                };
              };
            };
            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToControl = true;
            };
          };

          # フォントの設定
          fonts = {
            packages = with pkgs; [
              hackgen-nf-font
            ];
          };

          # Home Manager統合
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = {
              home.stateVersion = "24.11";
              programs.home-manager.enable = true;

              # パッケージ
              home.packages = with nixpkgs.legacyPackages.${system}; [
                git
                gh
                zsh
                sheldon
                starship
                fzf
              ];

              programs.git = {
                enable = true;
                settings = {
                  user = {
                    name  = "kanorix";
                    email = "kanorix320@gmail.com";
                  };
                  core.editor = "vi";
                  init.defaultBranch = "main";
                };
              };
            };
          };
        }
      ];
    };
  };
}
{
  description = "btstrm - stream torrents without soy webtorrent";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        btstrm = pkgs.callPackage ./default.nix { };
      in
      {
        packages = {
          default = btstrm;
          btstrm = btstrm;
        };

        apps = {
          default = {
            type = "app";
            program = "${btstrm}/bin/btstrm";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python3
            python3.pkgs.pip
            python3.pkgs.setuptools
            ffmpeg
            fzf
            mpv
            btfs
            jackett
            chafa
          ];
        };
      });
}

{
  description = "oklch-color-picker Nix package";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          ldLibPath = pkgs.lib.makeLibraryPath (
            with pkgs;
            [
              wayland
              libxkbcommon
              libGL
            ]
          );
        in
        {
          default = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
            pname = "oklch-color-picker";
            version = "2.2.1";

            src = pkgs.fetchCrate {
              inherit (finalAttrs) pname version;
              hash = "sha256-KDDk0Hwq1eGJq4ON9KDrTSf/IS27+Cf4/LOEVMNmlKI=";
            };

            cargoHash = "sha256-tdIkvBYKfcbCYXhDbIwXNNbNb4X32uBwDh3mAyqt/IM=";

            nativeBuildInputs = with pkgs; [ makeWrapper ];

            postInstall = ''
              wrapProgram $out/bin/oklch-color-picker \
                --set LD_LIBRARY_PATH ${ldLibPath}:$LD_LIBRARY_PATH
            '';
          });
        }
      );
    };
}

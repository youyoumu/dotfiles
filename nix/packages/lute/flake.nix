{
  description = "Lute - a standalone runtime for Luau";
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
          version = "1.0.0";
        in
        {
          default = pkgs.stdenv.mkDerivation {
            pname = "lute";
            inherit version;
            src = pkgs.fetchzip {
              url = "https://github.com/luau-lang/lute/releases/download/v${version}/lute-linux-x86_64.zip";
              hash = "sha256-ddB7FwoSt2hwGdgNOvvaB17I4gWYHIa6MgcTmpDPR2M=";
              stripRoot = false;
            };
            dontBuild = true;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/bin
              install -m 755 lute $out/bin/lute
            '';
          };
        }
      );
    };
}

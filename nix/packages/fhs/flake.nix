{
  description = "Enter FHS env";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    inputs@{ ... }:
    let
      forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
          base = pkgs.appimageTools.defaultFhsEnvArgs;
          fhs = pkgs.buildFHSEnv (
            base
            // {
              name = "fhs";
              targetPkgs =
                pkgs:
                (base.targetPkgs pkgs)
                ++ (with pkgs; [
                  pkg-config
                  ncurses
                ]);
              profile = "export FHS=1";
              runScript = "bash";
            }
          );
        in
        {
          default = fhs;
        }
      );
    };
}

{ ... }:
{
  services = {
    kmonad = {
      enable = true;
      keyboards = {
        laptop = {
          device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
          defcfg = {
            enable = true;
            fallthrough = true;
            allowCommands = false;
          };
          config = builtins.readFile ./kmonad.config.lisp;
        };
      };
    };
  };
}

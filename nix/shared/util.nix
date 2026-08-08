{
  grubWindowsEntry = uuid: ''
    menuentry "Windows 11" {
      savedefault
      search --no-floppy --fs-uuid --set=root ${uuid}
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';
}

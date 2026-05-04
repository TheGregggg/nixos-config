{
  pkgs,
  config,
  ...
}: {
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "71-nxdumptool.rules";
      destination = "/etc/udev/rules.d/71-nxdumptool.rules";
      text = ''
            # Nintendo SDK debugger, which nxdumptool presents itself as
        SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", TAG+="uaccess"
      '';
      checkPhase = ''
        ${config.systemd.package}/bin/udevadm verify --resolve-names=late $out/etc/udev/rules.d/71-nxdumptool.rules
      '';
    })
  ];
}

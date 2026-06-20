# import all real NixOs modules automaticly.
# The other files in this modules folder are activaterd on import
# They should be imported on the desired host
{...}: {
  imports = [
    ./system.nix # not a module, but is the base config for ALL devices.

    ./gnome.nix
  ];
}

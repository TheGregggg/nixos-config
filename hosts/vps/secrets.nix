let
  gregpc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBwjSqSHUlTcMh/CCDcmM4bkAL6ktBS7lxQ6M3wSgLcU";
  gregtop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSrvedYY5OobcIQbWvsPR+Nxkasj2ggkcTYK64h924/";
  users = [gregpc gregtop];

  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbGDaQ2wIB+/tNioGzbSaa1mQLpiiLQ/FqPfMV+ue1K";
in {
  "./secrets/vaultwarden.age".publicKeys = users ++ [server];
}

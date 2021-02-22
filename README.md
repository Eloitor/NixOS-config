# NixOS configuration


This is the configuration for my NixOS system.

```bash
git clone https://github.com/eloitor/NixOS-config /etc/nixos
```



## Fresh installation:

 1. Download and install the ISO that you prefer from https://nixos.org/download.html#nixos-iso.
 2. Follow installation instructions until `nixos-generate-config --root /mnt` 
 3. Get the configuration
 ```bash
 git clone https://github.com/eloitor/NixOS-config /mnt/etc/nixos
 ```
 4. Change the configuration to your needs.
   - UEFI / Legacy
   - networkmanager
   - user
 5. Do the instalation
 ```bash
 nixos-install 
 ```
 6. reboot

## Maintainance

 1. Edit yout configuration:
 ```bash
 sudo nixos-rebuild edit
 ```
 2. Update
 ```bash
 sudo nixos-rebuild switch
 ```

## Installation process
To install this configuration, you will need a minimal arch linux installation with sudo, systemd, a sudo user, base, base-devel, networking, bash and up-to-date mirrors. It would be preferred to have been done with archinstall, as that is what the configuration was tested on.
First, it's recommended to do a system update.
```bash
sudo pacman -Syyu
```
Now you can run the script from the root of this repository.
```bash
./install.sh
```
Then you can just do a reboot and you should get booted into the login interface of Getty on TTY1.
```bash
reboot
```
If you encounter any issues, report them via the repository on GitHub.

## Copyright
2026 Minetomba minetomba@proton.me
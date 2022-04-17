# Install Scripts

These are scripts that install something on your PC, please read what they do before running them.

### [install-microsoft-windows-fonts.sh](install-microsoft-windows-fonts.sh)

> This script will download the fonts from Discord CDN, check it's hash and install it to the `~/.fonts` folder.

To run this script enter the `install-scripts` folder and run:

```bash
./install-microsoft-windows-fonts.sh
```

---

### [install-proton-ge-lutris.sh](install-proton-ge-lutris.sh)

> This script will check the hash of the given file with the `sha512sum` from [GloriousEggroll GitHub](https://github.com/GloriousEggroll/wine-ge-custom/releases) and install it to the `~/.local/share/lutris/runners/wine/` folder.

To run this script you will need to have the `wine-lutris-GE-ProtonX-X-x86_64.tar.xz` in the same folder as the script, **it will not work if they are not in the same folder** and pass the file name as the argument. Ex:

```bash
./install-proton-ge-lutris.sh wine-lutris-GE-ProtonX-X-x86_64.tar.xz
```
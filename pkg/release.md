Any2ascii converts any format image file to an Ascii Art text file.

This release of any2ascii adds support for:

* Installation as a separate standalone package on multiple platforms
* Create packaging for Arch Linux, Fedora, Ubuntu, and Raspberry Pi OS
* Integrated features and customizations from Asciiville
* Ported to Arch Linux

## Installation

Download the [latest Debian, Arch, or RPM package format release](https://github.com/doctorfree/any2ascii/releases) for your platform.

Install the package on Debian based systems by executing the command:

```bash
sudo apt install ./any2ascii_1.0.0-1.amd64.deb
```

or, on a Raspberry Pi:

```bash
sudo apt install ./any2ascii_1.0.0-1.armhf.deb
```

Install the package on Arch Linux based systems by executing the command:

```bash
sudo pacman -U ./any2ascii-v1.0.0r1-1-x86_64.pkg.tar.zst
```

Install the package on RPM based systems by executing the following command:

On Fedora Linux:

```bash
sudo yum localinstall ./any2ascii_1.0.0-1.fc36.x86_64.rpm
```

### PKGBUILD Installation

To rebuild this package from sources on Arch Linux, extract `any2ascii-pkgbuild-1.0.0-1.tar.gz` and use the `makepkg` command to download the sources, build the binaries, and create the installation package:

```
tar xzf any2ascii-pkgbuild-1.0.0-1.tar.gz
cd any2ascii
makepkg --force --log --cleanbuild --noconfirm --syncdeps
```

## Removal

Removal of the package on Debian based systems can be accomplished by issuing the command:

```bash
sudo apt remove any2ascii
```

Removal of the package on RPM based systems can be accomplished by issuing the command:

```bash
sudo yum remove any2ascii
```

Removal of the package on Arch Linux based systems can be accomplished by issuing the command:

```bash
sudo pacman -Rs any2ascii
```

## Building any2ascii from source

any2ascii can be compiled, packaged, and installed from the source code repository. This should be done as a normal user with `sudo` privileges:

```
# Retrieve the source code from the repository
git clone https://github.com/doctorfree/any2ascii.git
# Enter the any2ascii source directory
cd any2ascii
# Compile any2ascii and create an installation package
./mkpkg
# Install any2ascii and its dependencies
./Install
```

The `mkpkg` script detects the platform and creates an installable package in the package format native to that platform. After successfully building any2ascii, the resulting installable package will be found in the `./releases/<version>/` directory.

## Changelog

Changes in version 1.0.0 release 1 include:

* Installation as a separate standalone package on multiple platforms
* Integrated features and customizations from Asciiville
* Create packaging for Arch Linux, Fedora, Ubuntu, and Raspberry Pi OS
* Ported to Arch Linux

See [CHANGELOG](https://github.com/doctorfree/any2ascii/blob/master/CHANGELOG) for a full list of changes in every any2ascii release

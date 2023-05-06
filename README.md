# <p align="center">in1t</p>
<p align="center"><b>A fast and simple APT Package Manager</b></p>
<b>in1t</b> is a fast and simple APT Package Manager made in shell. It is for jailbroken iOS devices, macOS and Linux. It doesn't use any commands that needs to be installed on the system like python, brew, etc.
> <b>Warning</b> if you're on Windows trying out in1t, it might be unstable.
<br><br>
If you don't wanna use **setup.sh**, you can go to the [legacy version](https://github.com/NotHansCYDIa/in1t/tree/legacy) of in1t.


## Installation
Open Terminal or Command Prompt then Clone this repo and go to the directory.
```zsh
git clone --recursive https://github.com/NotHansCYDIa/in1t && cd in1t
```
then run `chmod +x setup.sh`.
After you do that install an in1t installation file from the releases in this repository. Put the installation file into the in1t folder then do `./setup.sh in1t_installation_1.0.0`.
Make sure to replace `in1t_installation_1.0.0` into what version/installation file you've downloaded. Afer you enter the command you should now be able to run `in1t`.

## Commands
You can run `in1t.sh -h` to show all of the commands. or you read the commands below.

**-h, --help** - Shows help menu<br>
**-i [Package]** - Installs a package<br>
**-r, --uninstall [Package]** - Uninstalls installed package<br>
**-c [Package]** - Checks if package is available<br>
**-C [Package]** - Checks if package is installed<br>
**-I, --info [Package]** - Checks info on package if available<br>
**You can do `in1t.sh -h` to see all commands**

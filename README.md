## Table of contents

- [What you need](#what-you-need)
- [Quick start](#quick-start)
- [What's included](#whats-included)
- [Documentation](#documentation)
- [Authors](#Authors)
- [Thanks](#thanks)
- [Used software](#used-software)
- [Copyright and license](#copyright-and-license)

## What you need:

A vServer with at least:
```
Minimum Required HardwareSpecs

1 CPU Core [~2GHz]
512MB RAM
2GB Storage
Ubuntu 20.04.x (with all updates!)
root User Access
- The will to learn something about Linux ;)
```

## Quick start

Several quick start options are available:

Important!:
Login with:
- `su -i`
otherwise the script will throw multiple errors!

Install with [git]:
- `cd /root/; apt update; apt install git -y; git clone https://github.com/axiades/SecureMyServer.git; cd SecureMyServer; bash start.sh`

## What's included

Within the cloned repository you'll find the following directories and files, grouping the different installation files and configs in a logic structure. You'll see something like this:

```
SecureMyServer/
  ├── checks/
  │   ├── [Various check .sh files]
  │
  ├── configs/
  │   ├── fail2ban/
  │   ├── sshd_config  
  │   ├── userconfig.cfg
  │   ├── versions.cfg
  │
  ├── logs/
  │   ├── error.log
  │   ├── failed_checks.log
  │   ├── main.log
  │   ├── make.log
  │   ├── make_error.log   
  │
  ├── menus/
  │   ├── [Various menu .sh files]
  │
  ├── script/
  │   ├── [Various script .sh files (main part of the script)]
  │
  ├── LICENSE
  ├── README.md
  ├── install.sh
  ├── login_information.txt
  ├── start.sh
  ├── update_script.sh
  ├── LICENSE
  ├── README.md
```

## Documentation

Wiki is Cooming..

## Authors

**Marcel Eichlohn**

- <https://github.com/shoujii>

**René Wurch**

- <https://github.com/BoBBer446>

** Flo**

- <https://github.com/flo-ku>

** Phill**

- <https://github.com/axiades>

## Thanks

A big thanks to [George Liu], for some great lines of code!.
(https://github.com/centminmod)

## Used software
- Openssh                    <https://github.com/openssh/openssh-portable>
- Openssl                    <https://github.com/openssl/openssl>
- fail2ban                   <https://github.com/fail2ban/fail2ban>
- acme.sh                    <https://github.com/Neilpang/acme.sh>
- unbound                    <https://github.com/NLnetLabs/unbound>

## Copyright and license

Code and documentation copyright 2017-2020 the [Authors]
Code released under the [GNU General Public License v3.0](https://github.com/Axiades/SecureMyServer/blob/master/LICENSE).

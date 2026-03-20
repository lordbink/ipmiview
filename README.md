# Docker container for Supermicro® IPMIView, Raritan MPC, and ATEN iClientJ

Inspired from [solarkennedy/ipmi-kvm-docker](https://github.com/solarkennedy/ipmi-kvm-docker)

This container runs:

* Xvfb - X11 in a virtual framebuffer
* x11vnc - A VNC server that scrapes the above X11 server
* noVNC - A HTML5 canvas VNC viewer
* Fluxbox - a small window manager
* IPMIView - Supermicro IPMI KVM client
* Raritan MPC - Raritan KVM client
* ATEN iClientJ - ATEN KVM client

## Prerequisites

Before building, you need to download three proprietary software packages and place them in the correct directories. These files are excluded from git (`.gitignore`) as they are not redistributable.

### 1. Supermicro IPMIView

Download from Supermicro and place in the `ipmiview/` directory:

```bash
wget -P ipmiview/ https://www.supermicro.com/wdl/utility/IPMIView/Linux/IPMIView_2.21.0_build.221118_bundleJRE_Linux_x64.tar.gz
```

```text
ipmiview/
└── IPMIView_2.21.0_build.221118_bundleJRE_Linux_x64.tar.gz
```

### 2. Raritan MPC

Download `Raritan-mpc-installer.MPC_7.0.3.5.60.zip` from Raritan's support site and place it in the `kxclient/` directory:

```text
kxclient/
└── Raritan-mpc-installer.MPC_7.0.3.5.60.zip
```

### 3. ATEN iClientJ

Download `cn8000_iClientJ_v2.3.227.zip` from ATEN's support site and place it in the `ATENJavaClient/` directory:

```text
ATENJavaClient/
└── cn8000_iClientJ_v2.3.227.zip
```

## Build and run

```bash
git clone https://github.com/lordbink/ipmiview
cd ipmiview
# Place the three software packages as described in Prerequisites above
make
make run
```

Then open your browser at `http://localhost:8080/vnc.html`.

Right-click the desktop to launch IPMIView, Raritan MPC, or ATEN iClientJ from the menu.

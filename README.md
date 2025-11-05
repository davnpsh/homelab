# Homelab

This is collection of configuration files and ansible playbooks that will serve both as setup and documentation of my Homelab infrastructure.

This is a *work in progress* and I'd like to continue adding a lot of features and/or services in the future.

## Hardware

| Instance | Purpose | Size |  |
|----------|----------|----------|----------|
| Home server | Serve media content (such as shows and movies) | Mini-PC Intel 12th Gen N100 Processor with 16GB RAM, 512GB M.2 SSD and 2TB SATA SSD | <img src="./_static/kamrui.jpg" width="140" /> |
| Personal VPS | Be a 24/7 instance with always-available services | Oracle `VM.Standard.E2.1.Micro` instance with 1 OCPU and 1GB RAM | <img src="./_static/oracle.webp" width="140" /> |

My personal VPS hardware is subject to change due to [Oracle's business practices](https://news.ycombinator.com/item?id=29514359). I am considering Linode or Netcup as an alternative in case something goes wrong.

## Design

Currently and in the near future I won't be self-hosting any personal or sensitive content (such as password managers or files/photos) because I already use services that have way better security and also, I don't generate that much personal data.

A core concept I was focusing on while designing this was **volatility**, which basically means that I don't care if there is data loss at some point because I don't and won't be hosting personal, critical or sensitive content to begin with.

![Design](./_static/design.png)

## Setup

The ansible playbooks assume the machine they are being run on can connect via ssh just with their hostname. For instance, `ssh odin` should work. The user to login as **SHOULD NOT** be root.

1. Clone this repo and navigate to the root directory.

**NOTE:** Make sure to fill the env vars wherever they are need. Inside some dirs they is a `.env.example` file. Copy it to an `.env` file in the same dir and fill it.

2. With Python installed, create a virtual environment with:

```bash
python -m venv .venv
```

3. Activate the virtual environment. Example:

```bash
source .venv/bin/activate.fish
```

4. Install ansible:

```bash
pip install ansible
```

Check if everything is okay with:

```bash
which ansible
```

5. (OPTIONAL) Navigate to `[machine]/ansible` and do this to check syntax:

```bash
ansible-playbook --syntax-check setup.yml
```

6. To run a playbook just do:

```bash
ansible-playbook --ask-become-pass setup.yml
```

#

<div>
    <img src="./_static/linux-p.gif" alt="GIF 1" style="display: inline-block; margin: 10px;" />
    <img src="./_static/debian-powered.gif" alt="GIF 2" style="display: inline-block; margin: 10px;" />
    <img src="./_static/ubuntu-88x31.gif" alt="GIF 3" style="display: inline-block; margin: 10px;" />
    <img src="./_static/blink-0.gif" alt="GIF 3" style="display: inline-block; margin: 10px;" />
</div>

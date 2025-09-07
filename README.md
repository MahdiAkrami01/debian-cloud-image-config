# 🚀 Customized Debian Cloud Image for Proxmox

- 🛑 This repository is currently in **development mode** and is **not for production use**.
- 🚧 It is intended for **testing and development purposes only**. Use it at your own risk.

---

## 🧪 Features
- 🌐 **Timezone Configured:** Sets system timezone to Asia/Tehran
- 🛠️ **APT Proxy Setup:** Configures apt proxy for faster package management
- 📦 **Essential Packages Installed:** Includes `curl`, `wget`, `nano`, `htop`, `rsync`, `net-tools`, `dnsutils`, `tcpdump`, `mc`, `git`, `unzip`, `unar`, `bash-completion`, and more
- 🤖 **QEMU Guest Agent:** Installed for Proxmox VM integration
- ⚡ **Performance Tuning:** Installs and enables `tuned` with custom profiles
- 💽 **ZRAM Swap:** Configures ZRAM swap for optimized memory usage
- 📂 **lsd File Manager:** Installs and configures `lsd` for enhanced directory listing
- 🔒 **sing-box Proxy Server:** Adds repository, installs, and configures `sing-box`
- 🕸️ **Proxychains4:** Configured for flexible network routing
- 📝 **Systemd Configuration:** Custom settings for journald, system, and user services
- 🖥️ **Command Aliases:** Adds convenient shell aliases
- ♻️ **System Update & Cleanup:** Updates all packages, removes unnecessary files, and cleans caches
- 🔑 **Machine Initialization:** Empties machine-id and prepares SSH keys regeneration on first boot

## 🛠️ Getting Started

### 1. Clone the repository
```
git clone https://github.com/MahdiAkrami01/debian-cloud-image-config.git && \
cd debian-cloud-image-config
```

### 2. Install `libguestfs-tools`
[libguestfs](https://libguestfs.org/) is a set of tools, such as `virt-customize` and `qemu-img`, for accessing and modifying virtual machine (VM) disk images.

> ⚠️ Warning: Do not install `libguestfs-tools` on the PVE host!
> it has conflicts with PVE packages.

```shell
sudo apt update && \
sudo apt install libguestfs-tools -y
```

### 3. Download the Debian cloud image
```shell
wget -4 \
  https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2
```
If you encounter a 403 error or a timeout, you can use a proxy:
```shell
wget -4 \
  -e use_proxy=yes \
  -e https_proxy=127.0.0.1:1080 \
  https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2
```

### 4. Apply Customizations to the image
```shell
virt-customize \
  -x \
  --verbose \
  --no-selinux-relabel \
  --commands-from-file debian-configs.conf \
  --add debian-13-genericcloud-amd64.qcow2
```

### 5. Build the final `qcow2` image
```shell
qemu-img \
  convert \
  -p \
  -c \
  -f qcow2 \
  -O qcow2 \
  -o preallocation=off \
  debian-13-genericcloud-amd64.qcow2 \
  debian-13-genericcloud-amd64-final.qcow2
```

### 6. Move the image to the Proxmox host
> First install `rsync` using `sudo apt install rsync -y`.
```shell
rsync \
  --progress \
  --compress \
  --partial \
  --verbose \
  -e "ssh -p 22" \
  debian-13-genericcloud-amd64-final.qcow2 \
  root@192.168.x.x:/path/to/destination/
```

## 📥 import `qcow2` image into Proxmox

```shell
qm importdisk [vm-id] debian-13-genericcloud-amd64-final.qcow2 [storage-name]
```

Example:

```shell
qm importdisk 200 debian-13-genericcloud-amd64-final.qcow2 local-lvm
```

## 🎯 Next Steps: Start Automating and Scaling

This repository provides a **simple and easy way to create a customized Debian cloud image** using `virt-customize`. Once you have your VM image ready, you can explore tools to automate, manage, and scale your infrastructure:

### 🔧 Configuration Management
- **Ansible** – Automate configuration, software installation, and system updates across multiple VMs.
- **SaltStack** – Alternative for infrastructure automation and configuration management.
- **Puppet / Chef** – Enterprise-grade configuration management tools for larger environments.

### 🏗️ Infrastructure as Code (IaC)
- **Terraform** – Provision and manage VMs, storage, and network resources declaratively.
- **Pulumi** – Use programming languages like Python or TypeScript to define infrastructure.

### 📦 Image & VM Tools
- **Packer** – Automate building VM images for multiple platforms.
- **Vagrant** – Quickly spin up reproducible development VMs for testing your images.
- **cloud-init** – Automate VM initialization tasks such as creating users, configuring networking, and running scripts on first boot.

### 🐳 Containers & Orchestration
- **Docker / Podman** – Containerize applications for lightweight deployment.
- **Kubernetes / K3s** – Orchestrate multiple containers or VMs for scalable environments.
- **Helm** – Manage Kubernetes applications via charts and packages.

### 🔁 CI/CD & Automation
- **GitHub Actions** – Automate build, test, and deployment pipelines.
- **GitLab CI/CD** – Integrated CI/CD for your infrastructure and apps.
- **Jenkins** – Flexible automation server for pipelines and deployment workflows.

### 📊 Monitoring & Logging
- **Prometheus / Grafana** – Monitor VMs and container metrics.
- **ELK Stack (Elasticsearch, Logstash, Kibana)** – Centralized logging and analysis.

---

✨ Good luck on your automation journey!

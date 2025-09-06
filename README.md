# 🚀 Customized Debian Cloud Image for Proxmox

- 🛑 This repository is currently in **development mode** and is **not for production use**.
- 🚧 It is intended for **testing and development purposes only**. Use it at your own risk.

---

## How to build

### 1. Download configs
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

### 3. Download debian cloud image
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

### 4. Apply configs to image
```shell
virt-customize \
  -x \
  --verbose \
  --commands-from-file debian-configs.conf \
  --add debian-13-genericcloud-amd64.qcow2
```

### 5. Build final image
```shell
qemu-img \
  convert \
  --progress \
  --compress \
  --source-format qcow2 \
  --target-format qcow2 \
  --target-options preallocation=off \
  debian-13-genericcloud-amd64.qcow2 \
  debian-13-genericcloud-amd64-final.qcow2
```

### 6. move image to PVE host
> first install `rsync` using `sudo apt install rsync -y`.
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

## How to import `qcow2` image into Proxmox

```shell
qm importdisk 200 debian-13-genericcloud-amd64-final.qcow2 local-lvm
```
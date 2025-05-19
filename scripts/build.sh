#!/usr/bin/env bash

set -euxo pipefail

export PACKAGES_DIR=${GITHUB_WORKSPACE}/packages
export OUTPUT_DIR=${GITHUB_WORKSPACE}/output
export CURRENT_USER=$(whoami)
export HOME=/home/${CURRENT_USER}

sudo mkdir -p ${OUTPUT_DIR}
sudo pacman-key --init
sudo pacman --sync --refresh --sysupgrade --noconfirm git
sudo chown -R ${CURRENT_USER} ${PACKAGES_DIR} ${OUTPUT_DIR}

echo "PACKAGER='Angga Permana <anggape.dev@gmail.com>'" | 
  sudo tee --append /etc/makepkg.conf
echo "PKGDEST=${OUTPUT_DIR}" |
  sudo tee --append /etc/makepkg.conf

for package in ${PACKAGES_DIR}/*/; do
  cd ${package}
  makepkg --syncdeps --install --rmdeps --noconfirm
done

repo-add ${OUTPUT_DIR}/ape.db.tar.gz ${OUTPUT_DIR}/*

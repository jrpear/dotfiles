#!/bin/env bash

ACTION=$1
shift

#SCRIPT_DIR="$(dirname ${BASH_SOURCE[0]})"
#STATE_DIR="${SCRIPT_DIR}/var"
STATE_DIR=${HOME}/windows-vms

#TPM_STATE_DIR="${STATE_DIR}/tpm"
#TPM_CTRL_SOCK="${TPM_STATE_DIR}/control-sock"
TPM_STATE_DIR=/tmp/mytpm1
TPM_CTRL_SOCK=/tmp/mytpm1/swtpm-sock


BIOS_SRC_DIR="/usr/share/OVMF"
BIOS_CODE_NAME="OVMF_CODE.fd"
BIOS_VARS_NAME="OVMF_VARS.fd"
BIOS_CODE_SRC="${BIOS_SRC_DIR}/${BIOS_CODE_NAME}"
BIOS_VARS_SRC="${BIOS_SRC_DIR}/${BIOS_VARS_NAME}"
BIOS_CODE_BASE="${STATE_DIR}/${BIOS_CODE_NAME}"
BIOS_VARS_BASE="${STATE_DIR}/${BIOS_VARS_NAME}"
BIOS_CODES=([10]="${BIOS_CODE_BASE}.10" [11]="${BIOS_CODE_BASE}.11")
BIOS_VARSS=([10]="${BIOS_VARS_BASE}.10" [11]="${BIOS_VARS_BASE}.11")

USER_DOWNLOADS="${HOME}/Downloads"

WINDOWS_DISK_NAMES=([10]="${STATE_DIR}/windows10.qcow2" [11]="${STATE_DIR}/windows11.qcow2")
WINDOWS_INSTALL_MEDIA=([10]="${USER_DOWNLOADS}/Win10_21H2_English_x64.iso" [11]="${USER_DOWNLOADS}/Win11_English_x64v1.iso")

SHARED_DISK_NAME=shared_disk.raw
SHARED_DISK="${STATE_DIR}/${SHARED_DISK_NAME}"
SHARED_DISK_SIZE="20G"

DISK_SIZE="100G"

QEMU_BASE_ARGS="\
        -m 4G \
        -machine accel=kvm \
        -cpu max \
        -smp 2,cores=2 \
        -chardev socket,id=chrtpm,path=${TPM_CTRL_SOCK} \
        -tpmdev emulator,id=tpm0,chardev=chrtpm \
        -device tpm-tis,tpmdev=tpm0 \
        -drive file=${SHARED_DISK},format=raw,if=ide,index=1 \
"

QEMU_ARGS=(
        [10]="\
                ${QEMU_BASE_ARGS} \
                -drive file=${WINDOWS_DISK_NAMES[10]},format=qcow2,if=ide,index=0 \
                -drive file=${BIOS_CODES[10]},format=raw,if=pflash \
                -drive file=${BIOS_VARSS[10]},format=raw,if=pflash \
        "
        [11]="\
                ${QEMU_BASE_ARGS} \
                -drive file=${WINDOWS_DISK_NAMES[11]},format=qcow2,if=ide,index=0 \
                -drive file=${BIOS_CODES[11]},format=raw,if=pflash \
                -drive file=${BIOS_VARSS[11]},format=raw,if=pflash \
        "
)

function usage () {
        echo USAGE
        exit 1
}

function launch_tpm () {
        trap "kill %?swtpm" SIGINT SIGTERM EXIT

        mkdir -p ${TPM_STATE_DIR}

        swtpm socket \
                --tpmstate dir=${TPM_STATE_DIR} \
                --ctrl type=unixio,path=${TPM_CTRL_SOCK} \
                --log level=0 \
                --tpm2 \
                &
}

function setup_shared_disk () {
        qemu-img create -f raw "${SHARED_DISK}" ${SHARED_DISK_SIZE}
        echo "USE WINDOWS DISK MANAGEMENT TO FORMAT DRIVE"
}

function install () {
        local windows_version=$1
        local windows_disk_name=${WINDOWS_DISK_NAMES[${windows_version}]}
        local bios_code=${BIOS_CODES[${windows_version}]}
        local bios_vars=${BIOS_VARSS[${windows_version}]}
        if [ -z "${windows_disk_name}" ]; then
                usage
        fi

        if [ ${windows_version} -eq 11 ]; then
                echo 'NO NET WORKAROUND: open cmd with Shift + F10 and type OOBE\BYPASSNRO'
        fi

        mkdir -p "${STATE_DIR}"
        qemu-img create -f qcow2 "${windows_disk_name}" ${DISK_SIZE}
        if [ ! -e "${SHARED_DISK}" ]; then
                setup_shared_disk
        fi

        cp "${BIOS_CODE_SRC}" "${bios_code}"
        cp "${BIOS_VARS_SRC}" "${bios_vars}"

        launch_tpm
        local qemu_args="\
                ${QEMU_ARGS[${windows_version}]} \
                -cdrom ${WINDOWS_INSTALL_MEDIA[${windows_version}]} \
                -nic none \
        "
        echo "REMEMBER TO PRESS ANY BUTTON IN QEMU TO TRIGGER BOOT"
        qemu-system-x86_64 ${qemu_args}
}

function launch () {
        local windows_version=$1
        local qemu_args="${QEMU_ARGS[${windows_version}]}"
        if [ -z "${qemu_args}" ]; then
                usage
        fi

        launch_tpm
        qemu-system-x86_64 ${qemu_args}
}

if [ "${ACTION}" = 'launch' ] ; then
        launch $*
elif [ "${ACTION}" = 'install' ] ; then
        install $*
elif [ "${ACTION}" = 'setup-shared' ] ; then
        setup_shared_disk
else
        usage
fi


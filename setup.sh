#!/bin/bash
set -e

# -----------------------------
# Default values
# -----------------------------
MACHINE="${PELE_PLATFORM:-}"
DEVICE="cpu"

# -----------------------------
# Help message
# -----------------------------
show_help() {
    cat << EOF
Usage:
    ./setup.sh [MACHINE=<machine>] [DEVICE=<cpu|gpu>]
Examples:
    ./setup.sh
    ./setup.sh DEVICE=gpu
    ./setup.sh MACHINE=setonix DEVICE=cpu
    ./setup.sh MACHINE=trillium DEVICE=gpu
Rules:
    MACHINE:
        If provided, use the command-line value.
        If not provided, use PELE_PLATFORM.
        If neither is available, exit with an error.
    DEVICE:
        If provided, must be cpu or gpu.
        If not provided, default to cpu.
Current environment:
    PELE_PLATFORM=${PELE_PLATFORM:-<not set>}
EOF
}

# -----------------------------
# Parse arguments
# -----------------------------
for arg in "$@"; do
    case "${arg}" in
        -h|--help)
            show_help
            exit 0
            ;;
        MACHINE=*)
            MACHINE="${arg#MACHINE=}"
            ;;
        DEVICE=*)
            DEVICE="${arg#DEVICE=}"
            ;;
        *)
            echo "Error: unknown option '${arg}'"
            echo "Run './setup.sh --help' for usage."
            exit 1
            ;;
    esac
done

# -----------------------------
# Validate MACHINE
# -----------------------------
if [ -z "${MACHINE}" ]; then
    echo "Error: MACHINE is not provided and PELE_PLATFORM is not set."
    echo "Either run:"
    echo "    ./setup.sh MACHINE=setonix DEVICE=cpu"
    echo "or define in ~/.bashrc:"
    echo "    export PELE_PLATFORM=setonix"
    exit 1
fi


# -----------------------------
# Validate DEVICE
# -----------------------------
case "${DEVICE}" in
    cpu|gpu)
        ;;
    *)
        echo "Error: DEVICE must be either 'cpu' or 'gpu'."
        echo "Current DEVICE='${DEVICE}'"
        exit 1
        ;;
esac

CONFIG="${MACHINE}_${DEVICE}"

# -----------------------------
# Validate config directory
# -----------------------------
if [ ! -d "archive/machine/${CONFIG}" ]; then
    echo "Error: config directory does not exist:"
    echo "    archive/${CONFIG}"
    exit 1
fi

# -----------------------------
# Apply setup
# -----------------------------

echo "Setting up configuration: ${CONFIG}"
cp archive/machine/${CONFIG}/* .
cp archive/src/* .
cp archive/input.3d .
chmod +x make*.sh
chmod +x run*.sh

echo "Done."

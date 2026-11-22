#!/usr/bin/env bash
#
# Install agent-proxy (and its bundled tftpserver.py) to /usr/local and install
# a scoped sudoers rule for the given user. Run as root:
#
#   sudo ./install.sh                 # grant to the user that invoked sudo
#   sudo ./install.sh --user agent    # grant to another (non-sudo) user
#
set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage: sudo ./install.sh [--user <username>]

Options:
  -u, --user <username>   Grant the agent-proxy sudoers rule to <username>
                          (default: the user that invoked sudo, i.e. SUDO_USER).
  -h, --help              Show this help.

Use --user when the automation agent cannot run sudo itself; an admin runs
this installer once on its behalf.
EOF
}

TARGET_USER=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -u|--user)
      if [[ $# -lt 2 || -z "${2:-}" ]]; then
        echo "ERROR: --user requires a username argument." >&2
        usage
        exit 1
      fi
      TARGET_USER="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ ${EUID} -ne 0 ]]; then
  echo "ERROR: run this installer as root:  sudo ./install.sh" >&2
  exit 1
fi

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="/usr/local/bin/agent-proxy"
LIB_DIR="/usr/local/lib/agent-proxy"
SUDOERS_FILE="/etc/sudoers.d/agent-proxy"

for f in agent-proxy tftpserver.py; do
  if [[ ! -f "${SRC_DIR}/${f}" ]]; then
    echo "ERROR: cannot find ${SRC_DIR}/${f}" >&2
    exit 1
  fi
done

if [[ -n "${TARGET_USER}" ]]; then
  INVOKER="${TARGET_USER}"
else
  INVOKER="${SUDO_USER:-}"
  if [[ -z "${INVOKER}" ]]; then
    echo "ERROR: SUDO_USER is not set; run via 'sudo ./install.sh' or pass --user <username>." >&2
    exit 1
  fi
fi

if ! id -u "${INVOKER}" >/dev/null 2>&1; then
  echo "ERROR: user '${INVOKER}' does not exist on this system." >&2
  exit 1
fi

if [[ "${INVOKER}" == "root" ]]; then
  echo "WARNING: granting the sudoers rule to root is redundant (root needs no sudo rule)." >&2
fi

install -o root -g root -m 0755 "${SRC_DIR}/agent-proxy" "${DEST}"
echo "installed ${DEST}"

install -d -o root -g root -m 0755 "${LIB_DIR}"
install -o root -g root -m 0644 "${SRC_DIR}/tftpserver.py" "${LIB_DIR}/tftpserver.py"
echo "installed ${LIB_DIR}/tftpserver.py"

tmp="$(mktemp)"
trap 'rm -f "${tmp}"' EXIT
"${DEST}" sudoers --user "${INVOKER}" > "${tmp}"

if visudo -c -f "${tmp}"; then
  install -o root -g root -m 0440 "${tmp}" "${SUDOERS_FILE}"
  echo "installed ${SUDOERS_FILE}"
else
  echo "ERROR: generated sudoers rules failed validation; nothing was installed." >&2
  cat "${tmp}" >&2
  exit 1
fi

echo
echo "Done. Verify with:  ${DEST} doctor"

#!/usr/bin/env bash
#
# Install nmcli-proxy to /usr/local/bin and install a scoped sudoers rule for
# the user that invoked sudo. Run as root:
#
#   sudo ./install.sh
#
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "ERROR: run this installer as root:  sudo ./install.sh" >&2
  exit 1
fi

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="/usr/local/bin/nmcli-proxy"
SUDOERS_FILE="/etc/sudoers.d/nmcli-proxy"

if [[ ! -f "${SRC_DIR}/nmcli-proxy" ]]; then
  echo "ERROR: cannot find ${SRC_DIR}/nmcli-proxy" >&2
  exit 1
fi

INVOKER="${SUDO_USER:-}"
if [[ -z "${INVOKER}" ]]; then
  echo "ERROR: SUDO_USER is not set; run via 'sudo ./install.sh' so we know which user to grant privileges to." >&2
  exit 1
fi

install -o root -g root -m 0755 "${SRC_DIR}/nmcli-proxy" "${DEST}"
echo "installed ${DEST}"

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

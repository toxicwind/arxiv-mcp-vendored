#!/usr/bin/env bash
# Isolated launcher for the vendored arxiv-mcp server.
#
# The upstream `uvx --from git+https://github.com/Ray0907/arXiv-mcp.git`
# command inherits a global PYTHONPATH pointing at mise Python 3.14 site-packages
# (/home/toxic/.local/share/mise/installs/python/3.14.7/...). That bleeds the
# 3.14-ABI pydantic into the server's (3.12) process, so pydantic_core._pydantic_core
# fails with `cannot import name 'ArgsKwargs'`. This wrapper launches the
# self-contained venv with PYTHONPATH cleared so every dependency resolves from
# one Python ABI. Portable: the venv lives beside this script.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec env -u PYTHONPATH -u PYTHONHOME "$DIR/.venv/bin/arxiv-mcp" "$@"
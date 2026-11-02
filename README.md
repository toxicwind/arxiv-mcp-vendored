# arxiv-mcp vendored — isolated, portable arXiv MCP server
#
# WHY THIS EXISTS
# ---------------
# The upstream `uvx --from git+https://github.com/Ray0907/arXiv-mcp.git arxiv-mcp`
# command inherits a global PYTHONPATH that points at the mise Python 3.14
# site-packages. That bleeding 3.14-ABI `pydantic` into the server's (3.12)
# process makes `pydantic_core._pydantic_core` fail with:
#
#   ImportError: cannot import name 'ArgsKwargs' from 'pydantic_core._pydantic_core'
#
# This product is the fix: a self-contained Python 3.12 venv with one ABI for
# pydantic + pydantic_core, launched with `env -u PYTHONPATH` so no cross-ABI
# site-packages bleed can occur. Portable and persistent — the venv lives here.
#
# BUILD (idempotent)
# ------------------
#   python3 -m venv .venv
#   ./venv/bin/uv pip install -r requirements.txt
#
# LAUNCH
# ------
#   ./launch.sh          # clears PYTHONPATH then execs .venv/bin/arxiv-mcp
#
# REGISTRATION (thresher mcp_config.json)
# ---------------------------------------
#   { "name": "arxiv-advanced",
#     "command": "/home/toxic/pens/ranch/products/arxiv-mcp-vendored/launch.sh" }
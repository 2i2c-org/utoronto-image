#!/bin/bash
set -euo pipefail

python3 -m pip install -r image-tests/requirements.txt
py.test image-tests/
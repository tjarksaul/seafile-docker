#!/bin/bssh

set -e
set -o pipefail 

/scripts/create_data_links.sh

/scripts/start.py
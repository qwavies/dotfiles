#!/bin/bash
cat extensions.txt | xargs -L1 codium --install-extension

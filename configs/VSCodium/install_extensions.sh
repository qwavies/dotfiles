#!/bin/bash
cat extensions.txt | xarg -L1 codium --install extension

#!/bin/bash

set -euo pipefail

echo "Check set -o pipefail"
cat count.txt | grep "total"
echo "After failing script running without set -o"

echo -u "\n"
echo "Undefined variable -u"
echo $a
echo "After using undefined variable script running without set -u"

echo -e "\n"
echo "Failed command -e"
mkdir ../scripts
echo "After failing command script running without using -e"


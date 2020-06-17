#!/bin/bash
# Modified by Arman Kabiri
# EMail: Arman.Kabiri94@gmail.com

gawk '{print tolower($0);}' < $1 | tr '\000' ' ' | tr '\012' ' ' | tr '[:punct:]' ' ' | tr '[:space:]' ' ' | tr -s ' ' > $2

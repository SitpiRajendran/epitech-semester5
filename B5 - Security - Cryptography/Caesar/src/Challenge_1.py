#!/usr/bin/python3

import sys
import codecs

# ----------------- Modules ------------------

from Exception import _Exception
from SystemFolder import SystemFolder

# ----------------- Program ------------------

def Exo(string : str):
    if len(string) % 2 == 1:
        string += "0"
    string = string.replace("0x", "")
    b64 = codecs.encode(codecs.decode(string, 'hex'), 'base64').decode()
    return str(b64).upper()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        _Exception.WhatError("You should pass your pathfile as argument.")
    print(Exo(SystemFolder.loadFile(sys.argv[1])))
4
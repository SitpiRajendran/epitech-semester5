#!/usr/bin/python3

import sys
import codecs

# ----------------- Modules ------------------

from Exception import _Exception
from SystemFolder import SystemFolder

# ----------------- Program ------------------

def Exo(string1 : str, string2 : str):
    if len(string1) != len(string2):
        _Exception.WhatError("Wrong Arguments: string1 length must be equal to string2 length.")
    string1 = string1.replace("0x", "")
    string2 = string2.replace("0x", "")
    res = str(hex(int(string1, base=16) ^ int(string2, base=16))).upper()
    return res


if __name__ == "__main__":
    if len(sys.argv) != 2:
        _Exception.WhatError("You should pass your pathfile as argument.")
    print(Exo(SystemFolder.loadFile(sys.argv[1]).split("\n")[0], SystemFolder.loadFile(sys.argv[1]).split("\n")[1]))

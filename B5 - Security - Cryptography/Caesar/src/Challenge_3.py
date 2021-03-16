#!/usr/bin/python3

import os
import sys
import codecs

from Exception import _Exception
from SystemFolder import SystemFolder

def StringPart(string : str, char):
    count = 0
    for c in string:
        if c == char:
            count += 1

    percent : float = count / len(string) * 100
    if percent > 10 and percent < 15:
        return percent
    else:
        return percent
    return percent
def NumberPart(string : str):
    count = 0
    for c in string:
        if c == '0' or c == '1' or c == '2' or c == '3' or c == '4' or c == '5' or c == '6' or c == '7' or c == '8' or c == '9':
            count += 1

    percent : float = count / len(string) * 100
    if percent > 10 and percent < 15:
        return percent
    else:
        return percent
    return percent

def isEnglish(string : str):
    part_e = StringPart(string, 'e')
    part_nbr = NumberPart(string)
    part_space = StringPart(string, ' ')

    if part_space > 0 and part_nbr < 20 and part_e > 10:
        return True
    return False

def Exo(string1 : str, key : int):
    if key > 150:
        return 0
    if key < 0:
        _Exception.WhatError("Wrong Arguments: key must be higher than 0.")
    coded = bytes.fromhex(string1)
    res = b''
    for byte in coded:
        res += bytes([byte ^ key])
    if isEnglish(str(res).replace("b\'", "").replace("\'", "")):
        print(str(hex(key)).replace("0x", ""))
        return res
    
    Exo(string1, key + 1)
    return res


if __name__ == "__main__":
    if len(sys.argv) != 2:
        _Exception.WhatError("You should pass your pathfile as argument.")

    _res = Exo(SystemFolder.loadFile(sys.argv[1]).split("\n")[0], 0)
    _res = SystemFolder.loadFile(sys.argv[1]).split("\n")[0]

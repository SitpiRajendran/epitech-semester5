#!/usr/bin/python3

##
## EPITECH PROJECT, 2021
## B-SEC-500-PAR-5-1-caesar-romeo.talovici
## File description:
## Challenge_5
##

import os
import sys
import codecs

# ----------------- Modules ------------------

class _Exception(Exception):
    def __init__(self, m):
        self.message = m
    def __str__(self):
        return self.message

class SystemFolder:
    def loadFile(path : str):
        if os.path.exists(path) == False:
            raise _Exception("Wrong Argument: (" + path + ") do not exist.")
        data = ""
        try:
            f = open(path, "r")
            data = f.read()
            f.close()
        except Exception as e:
            raise _Exception("Error: " + str(e))
        return data
    def isPath(path : str):
        return os.path.exists(path)

# ----------------- Program ------------------

def Exo(key: str, string: str):
    encodedKey = bytes.fromhex(key)
    encodedString = bytes.fromhex(string)

    res = b''
    i = 0
    for byte in encodedString:
        res += bytes([byte ^ encodedKey[i]])
        if (i + 1) == len(encodedKey):
            i = 0
        else:
            i+=1
    return res.hex()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise _Exception("You should pass your pathfile as argument.")
    print(Exo(SystemFolder.loadFile(sys.argv[1]).split("\n")[0], SystemFolder.loadFile(sys.argv[1]).split("\n")[1]))
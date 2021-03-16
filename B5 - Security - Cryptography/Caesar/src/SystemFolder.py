import os

from Exception import _Exception

class SystemFolder:
    def loadFile(path : str):
        if os.path.exists(path) == False:
            _Exception.WhatError("Wrong Argument: (" + path + ") do not exist.")
        data = ""
        try:
            f = open(path, "r")
            data = f.read()
            f.close()
        except Exception as e:
            _Exception.WhatError(str(e))
        if data == "":
            _Exception.WhatError("No data in file")
        return data 
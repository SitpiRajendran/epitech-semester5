#!/usr/bin/python3

import sys
import info_functions

command = ["START", "TURN", "BEGIN", "ABOUT", "INFO"]
functions = ["start", "turn", "begin", "about", "info"]
info_command = ['info_functions.timeout_turn', 'info_functions.timeout_match', 'info_functions.max_memory', 'info_functions.time_left', 'info_functions.game_left', 'info_functions.rule', 'info_functions.evaluate', 'info_functions.folder']

# ----------------   COMMANDS  ----------------


def about(params, game):
    if len(params) == 0:
        print("name=\"GomokuIA\", version=\"1.0\", author=\"Thomas DALEM, Sitpi RAJENDRAN, Alain NGUYEN\", country\"FR\", www=\"https://www.sitpi.pro/\", email=\"mail@sitpi.pro\"")
    else:
        print("ERROR " + "- about don\'t take parameters")


def begin(params, game):
    if len(params) == 0:
        print("🧠 is playing")
    else:
        print("ERROR " + "- Begin don\'t take parameters")


def start(params, game):
    if len(params) == 1 and params[0] == "20":
        print("OK")
    else:
        print("ERROR " + "Unvalid size")


def turn(params, game):
    params = params[0].strip().split(",")
    if len(params) == 2:
        try:
            x = int(params[0])
            y = int(params[1])
            if (x >= 0 and x <= 20 and y >= 0 and y <= 20):
                print("🧠 is playing")
            else:
                print("ERROR " + "Unvalid size")
        except ValueError:
            print("ERROR " + "Parameters aren\'t numbers")
    else:
        print("ERROR " + "Not enought parameters (TURN need 2 parameters)")


def info(params, game):
    info_key = ['timeout_turn', 'timeout_match', 'max_memory', 'time_left', 'game_left', 'rule', 'evaluate', 'folder']
    if len(params) == 2:
        if params[0] in info_key:
            try:
                value = int(params[1])
                print("> " + str(value))
                info_functions.whichinfo(params, game)
            except ValueError:
                print("ERROR " + "Value isn\'t a number")
        else:
            print("ERROR " + "Key isn\'t a valid key")
    else:
        print("ERROR " + "Not enought parameters (TURN need 2 parameters)")

# ----------------   MAIN  ----------------


def main():
    play = True
    game = []
    while (play):
        buffer = sys.stdin.readline()
        temp = buffer.strip().split(" ")
        if temp[0] in command:
            params = temp[1:] if len(temp) >= 1 else 0
            globals()[functions[command.index(temp[0])]](params, game)
        else:
            print("UNKNOWN - Unknow command")


if __name__ == "__main__":
    main()

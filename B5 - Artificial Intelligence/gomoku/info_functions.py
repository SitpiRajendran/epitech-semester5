def whichinfo(params, game):
    if (params[0] == 'timeout_turn'):
        timeout_turn(params[1:], game)
    if (params[0] == 'timeout_match'):
        timeout_match(params[1:], game)
    if (params[0] == 'max_memory'):
        max_memory(params[1:], game)
    if (params[0] == 'time_left'):
        time_left(params[1:], game)
    if (params[0] == 'game_type'):
        game_type(params[1:], game)
    if (params[0] == 'rule'):
        rule(params[1:], game)
    if (params[0] == 'evaluate'):
        evaluate(params[1:], game)
    if (params[0] == 'folder'):
        folder(params[1:], game)

def timeout_turn(params, game):
    print('uuhoo')
"""     if (isinstance(params[0],int) and params[0] >= 0):
        game.timeout_turn = params[0] """

def timeout_match(params, game):
    if (isinstance(params[0],int) and params[0] >= 0):
        game.timeout_match = params[0]

def max_memory(params, game):
    if (isinstance(params[0],int) and params[0] >= 0):
        game.max_memory = params[0]

def time_left(params, game):
    if (isinstance(params[0],int) and params[0] >= 0):
        game.time_left = params[0]

def game_type(params, game):
    if (isinstance(params[0],int) and params[0] >=0 and params[0] <= 4):
        game.game_type = params[0]

def rule(params, game):
    if (isinstance(params[0],int) and params[0] >= 1 and params[0] <= 5):
        game.rule = params[0]

def evaluate(params, game):
    if (len(params) == 2 and params[0] >= 0 and params[1] >= 0):
        game.evaluate = params

def folder(params, game):
    if (params[0]):
        game.folder = params[0]
        
#timeout_turn  - time limit for each move (milliseconds, 0=play as fast as possible)
#timeout_match - time limit of a whole match (milliseconds, 0=no limit)
#max_memory    - memory limit (bytes, 0=no limit)
#time_left     - remaining time limit of a whole match (milliseconds)
#game_type     - 0=opponent is human, 1=opponent is brain, 2=tournament, 3=network tournament
#rule          - bitmask or sum of 1=exactly five in a row win, 2=continuous game, 4=renju
#evaluate      - coordinates X,Y representing current position of the mouse cursor
#folder        - folder for persistent files

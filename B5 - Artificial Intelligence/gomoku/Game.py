STATUS = [
    "EMPTY",
    "OWN",
    "OPPONENT"
]

class Game:
    board_size = 0
    board = []
    game_status = ""

    def __init__(self, size=20):
        self.board_size = size
        for i in range(20):
            self.board.append([])


    
#timeout_turn  - time limit for each move (milliseconds, 0=play as fast as possible)
#timeout_match - time limit of a whole match (milliseconds, 0=no limit)
#max_memory    - memory limit (bytes, 0=no limit)
#time_left     - remaining time limit of a whole match (milliseconds)
#game_type     - 0=opponent is human, 1=opponent is brain, 2=tournament, 3=network tournament
#rule          - bitmask or sum of 1=exactly five in a row win, 2=continuous game, 4=renju
#evaluate      - coordinates X,Y representing current position of the mouse cursor
#folder        - folder for persistent files

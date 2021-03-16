##
## EPITECH PROJECT, 2020
## FUN_evalExpr_2020
## File description:
## Makefile
##

NAME = funEvalExpr

LOCALPATH = `stack path --local-install-root`

all:
	stack build
	cp $(LOCALPATH)/bin/evalExpr-exe ./funEvalExpr
	echo -e "\033[1;32mCompilation completed sucessfully\033[0m"

clean:
	stack clean
	rm -f $(NAME).cabal

fclean:	clean
	rm -f $(NAME)
	echo -e "\033[1;32mCleaning finished !\033[0m"

re: 	fclean all

.PHONY: $(NAME) $(LOCALPATH) all clean fclean re

.SILENT: all clean fclean re
##
## EPITECH PROJECT, 2020
## Makefile
## File description:
## makefile compiles your programs
##

all:
	@cp src/Exception.py ./Exception.py
	@cp src/SystemFolder.py ./SystemFolder.py
	@cp src/Challenge_1.py challenge01
	@cp src/Challenge_1.py challenge01
	@cp src/Challenge_2.py challenge02
	@cp src/Challenge_3.py challenge03
	@cp src/Challenge_4.py challenge04
	@cp src/Challenge_5.py challenge05
#	@cp src/Challenge_6.py challenge06
#	@cp src/Challenge_7.py challenge07
#	@cp src/Challenge_8.py challenge08
#	@cp src/Challenge_9.py challenge09
	chmod +x challenge*
	@echo -e "\033[1;32mCompilation completed sucessfully\033[0m"

clean:
	@rm -f Exception.py
	@rm -f SystemFolder.py
	@rm -f challenge01
	@rm -f challenge02
	@rm -f challenge03
	@rm -f challenge04
	@rm -f challenge05
	@rm -f challenge06
	@rm -f challenge07
	@rm -f challenge08
	@rm -f challenge09
	@echo -e "\033[1;32mCleaning finished !\033[0m"

fclean: clean

re: fclean all

.PHONY: all clean fclean re
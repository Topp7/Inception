# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: stopp <stopp@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/13 17:55:12 by stopp             #+#    #+#              #
#    Updated: 2025/03/06 18:00:39 by stopp            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Project name
NAME := PmergeMe

# Define ANSI color codes
GREEN := \033[0;32m
RED := \033[0;31m
BLUE := \033[0;34m
NC := \033[0m

# Compiler + Flags
CC := c++
CFLAGS := -Wall -Wextra -Werror -std=c++17

# Directories and Files
OBJDIR := obj
SRC :=	src/main.cpp \
		src/PmergeMe.cpp \
		src/Jacobsthal.cpp \

OBJ := $(SRC:%.cpp=$(OBJDIR)/%.o)


MESSAGE := "\n$(GREEN)$(NAME) built successfully!$(NC)\n"

# Project build rule
all: $(OBJDIR) $(NAME)
	@echo $(MESSAGE)

$(NAME): $(OBJ)
	@$(CC) $(CFLAGS) $(OBJ) -o $@

# Rule to compile source files into object files in a separate obj folder
$(OBJDIR)/%.o: %.cpp | $(OBJDIR)
	@mkdir -p $(dir $@)
	@echo Compiling: $<
	@$(CC) $(CFLAGS) -c $< -o $@

# Create the objects directory
$(OBJDIR):
	@mkdir -p $(OBJDIR)

# Rule to clean object files
clean:
	@rm -rf $(OBJDIR)

# Rule to clean project and object files
fclean: clean
	@rm -f $(NAME)

# Rule to clean and rebuild the project
re: fclean all

# Phony targets
.PHONY: all clean fclean re Makefile

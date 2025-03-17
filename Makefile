# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: stopp <stopp@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/17 17:28:32 by stopp             #+#    #+#              #
#    Updated: 2025/03/17 17:57:06 by stopp            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = Inception
COMPOSE_FILE = src/docker-compose.yml
ENV_FILE = src/.env
VOLUME = /Users/stopp/Desktop/Inception
COMPOSE = docker compose -p $(NAME) -f $(COMPOSE_FILE)

GREEN := \033[0;32m
RED := \033[0;31m
BLUE := \033[0;34m
NC := \033[0m

all: up

up: build
		@echo "$(GREEN)Building and starting Container.$(NC)"
		@$(COMPOSE) --env-file $(ENV_FILE) up -d

build:
		@mkdir -p /home/stopp/data/mariadb
		@mkdir -p /home/stopp/data/wordpress
		@$(COMPOSE) --env-file $(ENV_FILE) build -no-cache

stop:
		@@echo "$(RED)Stopping Container!$(NC)"
		@$(COMPOSE) stop

down:
		@echo "$(RED)Stopping and removing Containers!$(NC)"
		@$(COMPOSE) down

clean:	down
		@echo "$(RED)"

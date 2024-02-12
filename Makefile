DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml
ENV_FILE := srcs/.env
WORDPRESS_DATA_DIR := ~/data/wordpress
MARIADB_DATA_DIR := ~/data/mariadb

name = inception

all: | make_dir_up

build: | make_dir_up_build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f $(DOCKER_COMPOSE_FILE) --env-file $(ENV_FILE) down

re: down | make_dir_up_build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf $(WORDPRESS_DATA_DIR)/*
	@sudo rm -rf $(MARIADB_DATA_DIR)/*

fclean: down
	@printf "Total clean of all configurations docker\n"
#	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf $(WORDPRESS_DATA_DIR)/*
	@sudo rm -rf $(MARIADB_DATA_DIR)/*

.PHONY: all build down re clean fclean make_dir_up make_dir_up_build

make_dir_up:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f $(DOCKER_COMPOSE_FILE) --env-file $(ENV_FILE) up -d

make_dir_up_build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f $(DOCKER_COMPOSE_FILE) --env-file $(ENV_FILE) up -d --build


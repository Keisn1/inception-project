##
# Nginx - inception
#
# @file
# @version 0.1

name = simple_nginx_html

all:
	@echo "Starting the setup for ${name}..."
	@docker-compose -f ./docker-compose.yml up -d

build:
	@echo "Building the setup for ${name}..."
	@docker-compose -f ./docker-compose.yml up -d --build

down:
	@echo "Stopping the setup for ${name}..."
	@docker-compose -f ./docker-compose.yml down

rebuild: down
	@echo "Rebuilding the setup for ${name}..."
	@docker-compose -f ./docker-compose.yml up -d --build

clean: down
	@echo "Cleaning the setup for ${name}..."
	@docker system prune -a

full_clean:
	@echo "Performing a complete cleanup of all Docker setups"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

.PHONY: all build down rebuild clean full_clean

# end

up: memory
	sudo docker-compose up -d
down:
	sudo docker-compose down
o:
	composer dump-autoload -o

docker-build: memory
	sudo docker-compose up --build -d

test:
	sudo docker exec app_php-cli_1 vendor/bin/phpunit --colors=always

assets-install:
	sudo docker exec app_node_1 yarn install

assets-rebuild:
	docker-compose exec app_node_1 npm rebuild node-sass --force

dev:
	sudo docker exec app_node_1 yarn run dev

watch:
	sudo docker exec app_node_1 yarn run watch

queue:
	docker-compose exec app_php-cli_1 php artisan queue:work

horizon:
	docker-compose exec app_php-cli_1 php artisan horizon

horizon-pause:
	docker-compose exec app_php-cli_1 php artisan horizon:pause

horizon-continue:
	docker-compose exec app_php-cli_1 php artisan horizon:continue

horizon-terminate:
	docker-compose exec app_php-cli_1 php artisan horizon:terminate

memory:
	sudo sysctl -w vm.max_map_count=262144

perm:
	sudo chown ${USER}:${USER} bootstrap/cache -R
	sudo chown ${USER}:${USER} storage -R
	if [ -d "node_modules" ]; then sudo chown ${USER}:${USER} node_modules -R; fi
	if [ -d "public/build" ]; then sudo chown ${USER}:${USER} public/build -R; fi

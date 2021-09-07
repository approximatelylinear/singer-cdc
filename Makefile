.PHONY: docker/build
docker/build:
	docker-compose -f stack.yml build

.PHONY: docker/up
docker/up:
	docker-compose -f stack.yml up

.PHONY: docker/down
docker/down:
	docker-compose -f stack.yml down
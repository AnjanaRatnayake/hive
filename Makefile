.PHONY: all
all: build-all run

.PHONY: run
run: 
	docker-compose up -d

.PHONY: down
down: 
	docker-compose down

build-all: build-hive build-hive-proxy build-go-ethereum build-config build-hive-simulators-engine

push-all: push-hive push-config

build-hive:
	podman build \
		-f ./hive.dockerfile \
		-t us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-anjana:latest \
		-t hive-anjana:latest \

build-hive-proxy:
	podman build \
		-f ./hiveproxy/Dockerfile \
		-t us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-hiveproxy:latest \
		-t hive-hiveproxy:latest \

build-go-ethereum:
	podman build \
		-f ./clients/go-ethereum/Dockerfile \
		-t us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/go-ethereum:latest \
		-t go-ethereum:latest \

build-hive-simulators-engine:
	podman build \
		-f ./hive-simulator-engine.dockerfile \
		-t us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-simulators-ethereum-engine-anjana:latest \
		-t hive-simulators-ethereum-engine-anjana \

build-config:
	podman build \
		-f ./config.dockerfile \
		-t us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-config:latest \
		-t config:latest \

push-hive:
	customer credentials_shell -c "podman push us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-anjana:latest"

push-config:
	customer credentials_shell -c "podman push us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-config:latest"

push-hive-simulators-engine:
	customer credentials_shell -c "podman push us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-simulators-ethereum-engine-anjana:latest"

push-hive-proxy:
	customer credentials_shell -c "podman push us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/hive-hiveproxy:latest"

push-geth:
	customer credentials_shell -c "podman push us-central1-docker.pkg.dev/molten-verve-216720/demo-repository/go-ethereum:latest"
RUNNER = docker-compose run --rm
RUNNER-HADOLINT = $(RUNNER) hadolint
PWD = $(shell pwd)

# check_defined determines if an environment variable is defined
check_defined = \
	$(strip $(foreach 1,$1, \
	$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
	$(if $(value $1),, \
	$(error Undefined $1$(if $2, ($2))))

# lint performs syntax rule checking against the Dockerfile
lint:
	$(RUNNER-HADOLINT) hadolint Dockerfile

# build builds the Dockerfile
build:
	$(call check_defined, IMAGE_NAME)
	$(call check_defined, GOSS_VERSION)
	$(call check_defined, TF_VERSION)
	$(call check_defined, TFLINT_VERSION)
	$(call check_defined, TFSEC_VERSION)
	docker build . \
		--file Dockerfile \
		--tag localbuild/$(IMAGE_NAME):latest \
		--build-arg GOSS_VERSION=$(GOSS_VERSION) \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TFLINT_VERSION=$(TFLINT_VERSION) \
		--build-arg TFSEC_VERSION=$(TFSEC_VERSION)

# test runs Goss tests against the localbuild docker container
# tests are defined in 'tests/goss.d/*.yaml' files
# produces a jUnit report with success and failure
test:
	$(call check_defined, IMAGE_NAME)
	$(RUNNER) localbuild sh -c 'goss -g ./tests/goss.yaml validate -f junit > ./goss-junit.xml'
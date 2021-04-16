
# Title         :   Execution modules for k3s Ansible playbook
# Version       :   v0.2
# Last Updated  :   04/15/2021


# Variables
GITHUB_FORK_REPO_URL := https://github.com/k3s-io/k3s-ansible.git
GITHUB_FORK_BRANCH := master
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

## Validate Commands and Utilities
# make
ifeq (, $(shell which make))
    $(error Make Installation Not Found!)
else
    export MAKE := $(shell which make)
endif

# Ansible
ifeq (, $(shell which ansible))
    $(error Ansible Installation Not Found!)
else
    export ANSIBLE := $(shell which ansible)
endif

# GIT
ifeq (, $(shell which git))
    $(error Git Installation Not Found!)
else
    export GIT := $(shell which git)
endif


# Execution modules
all: # Handle no target specified.
	$(info make ENVIRONMENT)
	$(info Options: env-validate, pre-deploy, deploy, terminate, beta-deploy, clean, submodules)
	$(info Example: make submodules)
	$(error No environment specified)

cmd-validate:
	$(info $(MAKE))
	@$(ANSIBLE) --version
	@$(GIT) --version

update-fork:
	@echo "Updating Fork from 'k3s-ansible' official repository to '${BRANCH}' branch ..."
	@$(GIT) pull $(GITHUB_FORK_REPO_URL) ${GITHUB_FORK_BRANCH}
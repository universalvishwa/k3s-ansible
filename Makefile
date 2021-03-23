
# Title         :   Execution modules for k3s Ansible playbook
# Version       :   v0.1
# Last Updated  :   03/22/2021


# Variables
GITHUB_FORK_REPO_URL := https://github.com/k3s-io/k3s-ansible.git
GITHUB_FORK_BRANCH := master
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

## Set environment
# Determine current branch
# ifeq ($(origin CI_COMMIT_REF_SLUG), undefined)
#     export BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
# else
#     export BRANCH := ${CI_COMMIT_REF_SLUG}
# endif
# Environment - Use the Branch name as the environment if working directly off that branch. Otherwise, default to dev environment.
# ifeq ($(BRANCH), dev)
#     export ENV := dev
# else ifeq ($(BRANCH), preqa)
#     export ENV := qa
# else ifeq ($(BRANCH), qa)
#     export ENV := qa
# else ifeq ($(BRANCH), preprod)
#     export ENV := prod
# else ifeq ($(BRANCH), prod)
#     export ENV := prod
# else # Default to dev branch if on a branch other than dev, preqa, qa, prepord, prod.
#     export ENV := dev
# endif

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

# # Python3
# ifeq ($(shell which python3), undefined)
#     $(error Python installation not found!)
# else
#     export PYTHON := $(shell which python3)
# endif

# # Jinja2
# ifeq (, $(shell which j2))
#     $(error Jinja2 Installation Not Found!)
# else
#     export J2 := $(shell which j2)
# endif

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
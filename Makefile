.ONESHELL:
SHELL := /bin/bash

VIRTUALENV = ./.cv
PACKAGE=cvbench
PYTHON = $(VIRTUALENV)/bin/python
.PHONY: test lint coverage help

default: clean env test

all: $(TARGETS)

clean: ## Clean all build files
	-@echo y | pip uninstall hack-python
	@rm -rdf $(PACKAGE).egg*
	@find . -name *.pyc -delete
	@rm -rdf build dist
	@rm -rdf $(VIRTUALENV)
	@rm -frd .pytest_cache .ruff_cache .coverage
	@rm -rfd __pycache__

dev:$(VIRTUALENV)/bin/python  ## Install this for development
	@$(PYTHON) -m pip install --upgrade pip
	@$(PYTHON) -m pip install -e .

	@$(PYTHON) -m pip install opencv-contrib-python

	@$(PYTHON) -m pip install ruff
	@$(PYTHON) -m pip install pytest
	@$(PYTHON) -m pip install coverage
	-@$(PYTHON) -m pip install -r requirements.txt

test:  ## Run all tests
	@pytest

lint: test ## Static code checking
	@ruff check .

coverage: ## Code coverage
	@coverage run -m pytest
	@coverage report -m 

$(VIRTUALENV)/bin/python: # create the local virtualenv
	virtualenv $(VIRTUALENV)
	echo "To activate 'source $(VIRTUALENV)/bin/activate'"

count:
	find . -path $(VIRTUALENV) -prune -o -name '*.py' | xargs wc -l

freeze:  ## Freezes pip requirements
	@echo "# Generated on `date`" >| requirements.txt
	@$(PYTHON) -m pip freeze | grep -v "$(PACKAGE)" >> requirements.txt

help: ## Shows help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
	@echo ""

VENV=.venv

venv_check:
ifndef VIRTUAL_ENV
	$(error Not in a virtual environment)
endif

venv_create:
ifndef VIRTUAL_ENV
	python -m venv $(VENV)
	@echo "Virtual environment $(VENV) created, activate running: source $(VENV)/bin/activate"
else
	$(warning VIRTUAL_ENV variable present, already within a virtual environment?)
endif

setup: venv_check
	python -m pip install cookiecutter
	rm -rf baking-test
	cookiecutter . --no-input
	cd baking-test && make install

test: setup
	cd baking-test && make -f Makefile test

run: setup
	cd baking-test && make -f Makefile run

coverage: setup
	cd baking-test && make -f Makefile coverage

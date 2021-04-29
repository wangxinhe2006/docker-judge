build: clean-build
	python3 setup.py build

dist: clean
	python3 setup.py sdist bdist_wheel

install: build
	python3 setup.py install

compileall: clean-pycache
	python3 -m compileall dockerjudge


clean: clean-build clean-dist clean-egg-info

clean-pycache:
	rm -rf dockerjudge/__pycache__

clean-build:
	rm -rf build

clean-dist:
	rm -rf dist

clean-egg-info:
	rm -rf dockerjudge.egg-info


pip:
	python3 -m pip install -Ur requirements.txt


tox:
	tox -p all

tox-lint:
	tox -e py3,flake8,pylint -p all


test:
	python3 -W ignore test_*.py

pytest:
	pytest --cov=dockerjudge --cov-report term-missing --cov-report xml


docker-pull:
	chmod +x docker-pull.sh
	./docker-pull.sh


lint: black flake8 pylint

black:
	black --check dockerjudge test_*.py

flake8:
	flake8 dockerjudge test_*.py

pylint:
	pylint dockerjudge test_*.py

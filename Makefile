default: all

all:
	python setup.py build

install: all
	python setup.py install

clean:
	rm -f *.pyc
	cd tests && rm -f *.pyc
	cd rdlm && rm -f *.pyc
	cd tests && rm -Rf htmlcov 
	rm -f .coverage tests/.coverage
	rm -f MANIFEST
	rm -Rf build
	rm -Rf dist
	rm -f *.rst
	rm -Rf rdlm.egg-info
	rm -Rf rdlm/__pycache__
	rm -Rf tests/__pycache__

sdist: clean
	python setup.py sdist

test:
	cd tests && nosetests

rst:
	cat README.md |pandoc --from=markdown --to=rst >README.rst

upload: rst
	python setup.py sdist register upload

coverage:
	cd tests && coverage run `which nosetests` && coverage html --include='*/restful-distributed-lock-manager/*' --omit='test_*'

release: test coverage clean upload clean 

.PHONY: test doctest test-integration docs install

test:
	PYTHONPATH=$$PYTHONPATH:. pytest -s -m "not integration" $(filter-out $@,$(MAKECMDGOALS))

test-integration:
	PYTHONPATH=$$PYTHONPATH:. pytest -s -m integration $(filter-out $@,$(MAKECMDGOALS))

doctest:
	PYTHONPATH=$$PYTHONPATH:. pytest --doctest-modules langstream/utils && PYTHONPATH=$PYTHONPATH:. pytest --doctest-modules langstream/core && PYTHONPATH=$PYTHONPATH:. pytest --doctest-modules langstream/contrib/llms

nbtest:
	nbdoc_test --fname docs/docs/

docs:
	make pdocs && make nbdocs && cd docs && npm run build

pdocs:
	pdoc --html -o ./docs/static/reference --template-dir ./docs/pdoc_template langstream --force

nbdocs:
	nbdoc_build --srcdir docs/docs

docs-dev-server:
	cd docs && npm start

install:
	pip install -r requirements.txt

%:
	@:
#!/usr/bin/make

ALL_SMOKE_TESTS := $(shell find spec/tests -type f)

prepos:
	@echo "Installing OS dependencies ..."
	@sudo apt-get install --no-install-recommends -y bundler puppet
	@echo "Done"

prep:
	@echo "Installing dependencies ..."
	@bundle install --path=vendor
	@bundle exec rake clean
	@bundle exec rake spec_clean
	@rm -rf modules
	@rm -f Puppetfile.lock
	@rm -rf .tmp/
	@rm -rf .librarian/
	@bundle exec rake spec_prep
	@echo "Done"

clean:
	@echo "Cleaning up"
	@rm -rf vendor
	@echo "Done"

cleanos:
	@echo "Cleaning OS dependencies ..."
	@sudo apt-get remove --purge -y bundler puppet
	@sudo apt-get autoremove --purge -y
	@echo "Done"

$(ALL_SMOKE_TESTS):
	@echo Running $@
	@echo
	FACTER_smoketesting=true FACTER_lsbmajdistrelease=14 FACTER_operatingsystemrelease=14.04 FACTER_operatingsystem=Ubuntu FACTER_osfamily=Debian puppet apply --noop --modulepath spec/fixtures/modules/ $@
	@echo

smoketest: prepos prep $(ALL_SMOKE_TESTS) clean cleanos

raketest: prepos prep
	@echo "Running rake tests"
	bundle exec rake test
	@echo "Done"
	@make clean
	@make cleanos

raketesttravis: prep
	@echo "Running rake tests"
	bundle exec rake test
	@echo "Done"
	@make clean

test: smoketest raketest

testtravis: raketesttravis

puppet:
	@sudo apt-get install --no-install-recommends -y bundler puppet git
	@bundle install --path=vendor
	@echo "Installing puppet dependencies ..."
	bundle exec librarian-puppet install --verbose
	@echo
	@echo "Setting up for puppet run"
	@if [ -d dist ]; then \
		cp -a dist/* modules/; \
	fi
	@echo "Done"
	@echo "Running puppet"
	@sudo puppet apply --modulepath modules/ manifests/site.pp
	@echo "Done"
	@echo "Cleaning up"
	@rm -rf vendor
	@sudo apt-get remove --purge -y bundler puppet git
	@sudo apt-get autoremove --purge -y
	@echo "Done"

serverspec:
	@echo "Installing serverspec dependencies ..."
	@sudo apt-get install --no-install-recommends -y bundler
	@(cd serverspec && bundle install --path=vendor)
	@echo "Done"
	@echo "Running serverspec"
	@(cd serverspec && bundle exec rake spec)
	@echo "Done"
	@echo "Cleaning up"
	@rm -rf serverspec/vendor
	@sudo apt-get remove --purge -y bundler
	@sudo apt-get autoremove --purge -y
	@echo "Done"

.PHONY: prepos prep clean cleanos smoketest raketest raketesttravis test testtravis puppet serverspec $(ALL_SMOKE_TESTS)

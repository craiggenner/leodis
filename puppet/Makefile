#!/usr/bin/make

ALL_SMOKE_TESTS := $(shell find spec/tests -type f)

prep:
	@echo "Installing smoketest dependencies ..."
	@sudo apt-get install --no-install-recommends -y bundler puppet
	@bundle install --path=vendor
	@bundle exec rake clean
	@bundle exec rake spec_clean
	@rm -rf modules
	@rm -f Puppetfile.lock
	@rm -rf .tmp/
	@rm -rf .librarian/
	@bundle exec rake spec_prep

$(ALL_SMOKE_TESTS):
	@echo Running $@
	@echo
	FACTER_smoketesting=true FACTER_lsbmajdistrelease=14 FACTER_operatingsystemrelease=14.04 FACTER_operatingsystem=Ubuntu FACTER_osfamily=Debian puppet apply --noop --modulepath spec/fixtures/modules/ $@
	@echo

smoketest: prep $(ALL_SMOKE_TESTS)
	@echo "Cleaning up"
	@rm -rf vendor
	@sudo apt-get remove --purge -y bundler puppet
	@sudo apt-get autoremove --purge -y
	@echo "Done"

raketest:
	@echo "Installing rake test dependencies ..."
	@sudo apt-get install --no-install-recommends -y bundler puppet
	@bundle install --path=vendor
	@bundle exec rake clean
	@bundle exec rake spec_clean
	@rm -rf modules
	@rm -f Puppetfile.lock
	@rm -rf .tmp/
	@rm -rf .librarian/
	bundle exec rake test
	@echo "Done"
	@echo "Cleaning up"
	@rm -rf vendor
	@sudo apt-get remove --purge -y bundler puppet
	@sudo apt-get autoremove --purge -y
	@echo "Done"

test: smoketest raketest

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

.PHONY: prep smoketest raketest test puppet serverspec $(ALL_SMOKE_TESTS)

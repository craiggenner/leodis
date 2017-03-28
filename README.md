# leodis

## Local Dev

Install and configure vagrant, check out the project and then do a `vagrant up` in the root folder.

Once started connect to the image with `vagrant ssh`, all code can then be found in the `/vagrant` folder.

## Testing

### Puppet tests

Switch to the `/vagrant/puppet` folder and run `make test`.

This will run puppet smoke and spec tests. You can run individual tests with `make smoketest` and `make raketest`.

(The results of the rake test produces a `rspec.xml` which is in the junit format for tools that support this output)

## Applying

Checkout the project to the destination server and run `make puppet`.

### Server Tests

This project comes with server spec tests configured to test the results of the puppet run.

To run these tests checkout the project, switch to the `puppet` folder and run `make serverspec`.

(As before the test produces a `rspec.xml`)

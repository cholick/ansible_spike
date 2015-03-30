### Setup

Prerequisites
* [Bundler](http://bundler.io/)
* [Vagrant](https://www.vagrantup.com/)
* [Ansible](http://www.ansible.com/home)

```
bundle install
```

### Testing

While developing, from the test folder run
```
test.sh
```

Before committing, do a fine test from a clean vm
```
test.sh --full
```

### References

* https://github.com/fdavis/ansible-best-practices
* http://www.geedew.com/setting-up-ansible-for-multiple-environment-deployments/
* http://blog.cliffano.com/2014/04/06/human-readable-ansible-playbook-log-output-using-callback-plugin/
* https://servercheck.in/blog/testing-ansible-roles-travis-ci-github

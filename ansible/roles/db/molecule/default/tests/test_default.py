import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'

# check if MongoDB is enabled and running
def test_mongo_running_and_enabled(host):
    mongo = host.service('mongodb')
    assert mongo.is_running
    assert mongo.is_enabled

# check if configuration file contains the required line
def test_config_file(host):
    config_file = host.file('/etc/mongodb.conf')
    assert config_file.is_file
    assert config_file.contains('bindIp: 0.0.0.0')

# check if configuration file contains the required line
def test_mongo_socket(host):
    mongo_socket = host.socket('tcp://0.0.0.0:27017')
    assert mongo_socket.is_listening

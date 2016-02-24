## Application Orchestration Training

### Setup Instructions

1. Clone this repository down to your local environment on your machine.
```
git clone https://github.com/velocity303/app_orchestration_training.git
```
2. Install Vagrant ([installation documentation](https://docs.vagrantup.com/v2/installation/))
3. Install Virtualbox ([Virtualbox Download](https://www.virtualbox.org/wiki/Downloads))
4. Install required vagrant plugins for vagrant environment
```
  $ vagrant plugin install oscar
  $ vagrant plugin install vagrant-hosts
  $ vagrant pluing install vagrant-reload
  $ vagrant plugin install vagrant-multiprovider-snap
```

5. Bring up environment with vagrant up puppet-master


# How to use this stack

This stack bootstraps itself by

1. Installing with an answer file that configures code manager to pull down from the app orchestration training control repo. 
2. Running a code manager deployment
3. Running puppet agent -t

# This Vagrant Stack is Based on the puppet-debugging-kit and npwalker-control-repo

Please follow the setup instructions for the debugging kit before cloning down this repo.

https://github.com/Sharpie/puppet-debugging-kit
https://github.com/npwalker/control-repo.git

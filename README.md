# Project 1 - ELK Stack Deployment

---

UC Davis Cybersecurity Bootcamp Class of 2022

---

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![alt text](https://github.com/jmccully315/Unit13_Project1/blob/main/Diagrams/VirtualNetworkDiagram.PNG "Virtual Network")


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the filebeat-playbook.yml file may be used to install only certain pieces of it, such as Filebeat.

![alt text](https://github.com/jmccully315/Unit13_Project1/blob/main/Diagrams/filebeat-playbook.yml.PNG "Filebeat Playbook")

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network. Load balancers protects the system from DDoS attacks by shifting attack traffic. The advantage of a jump box is to give access to the user from a single node that can be secured and monitored.
Here's a line for us to start with.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs.

-Filebeat watches for any information in the file system which has been changed and when it has.

-Metricbeat takes the metrics and statistics that collects and ships them to the output you specify



| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box   | Gateway  | 10.0.0.4   | Linux            |
| Web-1 DVWA | Server | 10.0.0.5   | Linux            |
| Web-2 DVWA | Server | 10.0.0.7   | Linux            |
| Web-3 DVWA | Server | 10.0.0.8   | Linux            |
| ELK Stack  | Server | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: _76.246.168.139_.

Machines within the network can only be accessed by the JumpBox: _20.106.125.0_

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes              | Home IP    |
| Web-1 DVWA | No                  | 20.125.115.186 (RedTeamLB) |
| Web-2 DVWA | No                  | 20.125.115.186 (RedTeamLB) |
| Web-3 DVWA | No                  | 20.125.115.186 (RedTeamLB) |
| ELK Server | Yes                 | Home IP              |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The main advantage is the automation of the configuration.

The playbook implements the following tasks:
- docker.io
- Install pip3
- Install Docker python module
- Increasing the virtual memory
- Download and launch a docker ELK docker container


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![alt text](https://github.com/jmccully315/Unit13_Project1/blob/main/Diagrams/dockerpsELKinstance.PNG "docker ps ELK")

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 10.0.0.5
- Web-2 10.0.0.7
- Web-3 10.0.0.8

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects system log management and collecting data like `sudo` commands, SSH logins, and new users as well as groups created.

While...
- Metricbeat is connected to DVWA and tracks CPU usage and core stats, Memory stats, Number of containers as well as Network stats.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

- Verify the Public IP of the machine you are using either by this link, [What is my IP address](https://www.icanhazip.com "icanhazip") 
- Or you can verify your IP address from the command line using the command `curl icanhazip.com`

SSH into the control node and follow the steps below:
- Copy the **yml** files to the control nodes **/etc/ansible/** folder.
- Update the **hosts** file to include IP addresses on the network.
- Run the **filebeat-playbook.yml** and **metricbeat-playbook.yml**, and navigate to http://[Your_ELK_IP_address]:5601/app/kibana to check that the installation worked as expected.

### ELK VM Configuration

- Copy the [ELK Installation Playbook Yaml file](https://github.com/jmccully315/Unit13_Project1/blob/main/Ansible/elk-playbook.yml.txt)
- Run the playbook from the **/etc/ansible/** folder using this command: `ansible-playbook elk-playbook.yml`

### For Filebeat

- Download Filebeat playbook using this command: `curl -L -O https://github.com/jmccully315/Unit13_Project1/blob/main/Ansible/filebeat-playbook.yml.txt > /etc/ansible/filebeat-config.yml`
- Copy the [Filebeat Config file](https://github.com/jmccully315/Unit13_Project1/blob/main/Ansible/filebeat-config.cfg.txt) to **/etc/ansible** folder
- Update the **filebeat-config.yml file to include your **ELK Server Private IP Address** by `nano /etc/ansible/filebeat-config.yml`

output.elasticsearch:
  # Boolean flag to enable or disable the output module.
  #enabled: true

  # Array of hosts to connect to.
  # Scheme and port can be left out and will be set to the default (http and 9200)
  # In case you specify and additional path, the scheme is required: http://localhost:9200/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:9200
  hosts: ["10.2.0.4:9200"]
  username: "elastic"
  password: "changeme" # TODO: Change this to the password you set

# Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
# This requires a Kibana endpoint configuration.
setup.kibana:
  host: "10.2.0.4:5601" 
# TODO: Change this to the IP address of your ELK server

- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

### As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.

- The specific commands the user will need to run in order to download the playbook and configuration files, update the files, etc:

| **COMMAND** | **PURPOSE** |
|-------------|-------------|
| `ssh-keygen` | Create a ssh key for setup of VM |
| `sudo cat /ssh/id_rsa.pub` | To view the ssh public key |
| `ssh [username]@[Jumpbox-IP-Address]` | Logs into Jumpbox VM |
| `sudo docker start [docker_container]` | Starts docker container [your_docker_container_name] |
| `sudo docker ps -a` | Lists all active/inactive containers |
| `sudo docker attach [docker_container]` | Logs into docker container [your_docker_container_name] |
| `cd /etc/ansible` | Changes directory to the Ansible directory |
| `ls -laA` | Lists all files in the directory (including hidden files) |
| `nano /etc/ansible/hosts` | To edit the **hosts** file |
| `nano /etc/ansible/ansible.cfg` | To edit the **ansible.cfg** file |
| `nano /etc/ansible/web-playbook.yml` | To edit the **web-playbook.yml** file |
| `ansible-playbook /location/filename/` | To run the playbook |
| `ssh ansibleuser@[WebVM-1_IP_Address]` | To log into the Web-1 VM |
| `ssh ansibleuser@[WebVM-2_IP_Address]` | To log into the Web-2 VM |
| `ssh ansibleuser@[WebVM-3_IP_Address]` | To log into the Web-3 VM |
| `ssh ansibleuser@[ELK_Server_IP_Address]` | To log into the ELK Server VM |
| `exit` | To exit out of any ssh session in any docker container/ Jumpbox |
| `sudo apt-get update` | This will update all packages |
| `sudo apt install docker.io` | Installs the docker application |
| `sudo service docker start` | Starts the docker application |
| `sudo systemctl status docker` | Checks the status of the docker application |
| `sudo systemctl start docker` | Starts the docker service (if not already running) |
| `sudo docker pull cyberxsecurity/ansible` | Pulls the docker container file |
| `sudo docker run -ti cyberxsecurity/ansible bash` | Runs and creates a docker container image |
| `ansible -m ping all` | Checks the connection of the ansible containers |
| `curl -L -O [location_of_the_file_on_the_web]` | Downloads a file from the web |
| `dpkg -i [filename]` | Installs the file i.e. (filebeat/metricbeat) |
| `http://[ELK_Server_IP_Address]:5601//app/kibana` | Open web browser and navigate to this link to access Kibana logs |
| `nano filebeat-config.yml` | Creates and/or edits filebeat configuration file |
| `nano filebeat-playbook.yml` | Creates and/or edits YAML file to install filebeat to webservers |
| `nano metricbeat-config.yml` | Creates and/or edits metricbeat configuration file |
| `nano metricbeat-playbook.yml` | Creates and/or edits YAML file to install metricbeat to webservers |


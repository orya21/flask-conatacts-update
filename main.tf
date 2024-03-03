data "vultr_ssh_key" "pub_key" {
  filter {
    name = "name"
    values = ["gagi"]
  }
}

resource "vultr_startup_script" "startup" {
  name = "preparing ubuntu for jenkins ci/cd"
  script = filebase64("startup.sh")
  type = "boot"
}

# resource "vultr_startup_script" "create_linuxuser" {
#   name = "create a gagi user"
#   script = filebase64("create_linux_user.sh")
#   type = "boot"
# }

resource "vultr_instance" "ubuntu-jenkins" {
    label = "Ubuntu Jenkins"
    plan = "vc2-2c-2gb"
    region = "fra"
    os_id = 1743
    backups = "disabled"
    enable_ipv6 = true
    hostname = "ubuntu-jenkins"
    ssh_key_ids = [data.vultr_ssh_key.pub_key.id]
    script_id = vultr_startup_script.startup.id
    # user_data = base64decode(vultr_startup_script.startup.script)
    # embedded script as raw text
    # user_data = << EOF
    #         #!/bin/bash

    #         # Add Jenkins repository for ubuntu 22.04 
    #         wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    #         echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    #         apt-get update
    #         apt-get upgrade -y

    #         # Installing jenkins + git + docker
    #         apt-get install -y openjdk-17-jre 
    #         apt-get install -y jenkins docker.io git

    #         # Allow firewall rules to be accessable from the web
    #         ufw allow 8080
    #         ufw reload
	  # EOF
}

output "ip_address" {
   value = vultr_instance.ubuntu-jenkins.main_ip

}

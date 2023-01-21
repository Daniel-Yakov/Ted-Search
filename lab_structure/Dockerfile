FROM jenkins/jenkins:lts-jdk11
USER root
# install docker
RUN apt-get update -y && \
apt install docker.io -y && \
apt install docker-compose -y && \
usermod -aG docker jenkins && \
groupmod -g 999 docker

# install terraform
RUN apt-get update -y && apt-get -y install gnupg software-properties-common wget
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg 
RUN gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list 
RUN apt update -y && apt-get install terraform -y
USER jenkins
# Utilise Ubuntu 22.04
FROM ubuntu:22.04

# Installe SSH, sudo, Python (pour Ansible)
RUN apt update && apt install -y openssh-server sudo python3 && \
    mkdir /var/run/sshd && ssh-keygen -A

# Ajoute ta clé SSH publique dans root
# (remplace le contenu de la clé ci-dessous par le tien)
RUN mkdir -p /root/.ssh && \
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvy41HNTEvjez7MscgSLTVJDv5avPwMl8cVtCWlD7Yo vburton@vburton-VirtualBox" > /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && chmod 700 /root/.ssh

# Définis un mot de passe root (utile si tu veux aussi tester par mot de passe)
RUN echo 'root:ansible' | chpasswd

# Expose le port SSH
EXPOSE 22

# Lance SSHD au démarrage
CMD ["/usr/sbin/sshd", "-D"]

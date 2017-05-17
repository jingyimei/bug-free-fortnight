FROM pivotaldata/sles-gpdb-dev:11-beta

RUN zypper addrepo --no-gpgcheck http://download.opensuse.org/distribution/11.4/repo/oss/ ossrepo \
	&& zypper -n refresh ossrepo
RUN zypper -n install ccache sudo

# generate server keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

RUN groupadd gpadmin \
	&& useradd --password '$5$uitFy1zdHuG$f7NutSS0aAyl7EqqPBhKZOk4iKJzxFkGGYd8s2hERM8' --groups gpadmin --create-home gpadmin \
	&& echo '%gpadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN chmod g+w -R /opt \
	&& chgrp -R gpadmin /opt

WORKDIR /build
RUN chown -R gpadmin:gpadmin /build

USER gpadmin

RUN ssh-keygen -f ~/.ssh/id_rsa -N '' \
	&& cp ~/.ssh/{id_rsa.pub,authorized_keys}

CMD sudo /usr/sbin/sshd -D
ENV JAVA_HOME=/usr/java/default
ENV PATH ${PATH}:${JAVA_HOME}/bin

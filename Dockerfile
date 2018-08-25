FROM centos:7.5.1804
LABEL org.thenuclei.creator="Brian Provenzano" \
      org.thenuclei.email="bproven@example.com"
USER root
RUN yum install -y deltarpm \
https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest-2.el7.noarch.rpm \
&& yum clean expire-cache \
&& yum install -y python36 salt-master salt-minion \
&& yum update -y \
&& yum clean all  && rm -rf /var/cache/yum
#setup local minion
COPY --chown=root:root start-salt.sh /root/start-salt.sh
COPY --chown=root:root keys.py /root/keys.py
RUN chmod ug+x /root/start-salt.sh /root/keys.py
#salt ports
EXPOSE 4505 4506 443
ENTRYPOINT [ "/root/start-salt.sh"]
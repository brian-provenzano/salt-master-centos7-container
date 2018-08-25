

pull:
	@docker pull centos:7.5.1804
build:
	@docker build -t warpigg/salt-master-centos7:$(version) .
build-pull: pull
	@docker build -t warpigg/salt-master-centos7:$(version) .
run:
	@docker run --name=salt-master-centos7 -v centos7_saltmaster_etc:/etc/salt -v centos7_saltmaster_cache:/var/cache/salt -d warpigg/salt-master-centos7:$(version)
start:
	@docker container start salt-master-centos7
stop:
	@docker container stop salt-master-centos7
show:
	@docker container ls
logs: 
	@docker logs -f salt-master-centos7
cli:
	@docker container exec -it -u root salt-master-centos7 /bin/bash
clean:	stop
	@docker container rm salt-master-centos7
cleanall: clean
	@docker volume rm centos7_saltmaster_etc centos7_saltmaster_cache

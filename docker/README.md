
# 1. docker swarm 관리
 1) docker build 사용
  - 커스텀 이미지 사용이 필요한 경우 아래와 같이 Dockerfile을만들고 생성명령어를 사용한다.
  ```
  [jjpark@AJU nginx_custom]$ cat Dockerfile
FROM nginx

COPY default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
  ```
  - 빌드 명령어
    > docker build -t nginx:custom .
    
  2) docker swarm배보를 위한 docker-compose.xml 파일 만들기  
  - docker-compose.xml 양식
  ```
  [jjpark@AJU ~]$ cat docker-compose.yml
version: "3.7"

services:
  eamswas:
    container_name: eamswas
    image: tomcat
    ports:
      - "8080:8080"
    deploy:
      mode: replicated
      replicas: 2
    volumes:
       - /home/jjpark/eams.war:/usr/local/tomcat/webapps/eams.war
#    networks: # 서버와 같은 네트워크, 잊지 마세요!
#       - backend

  nginx:
    image: nginx:custom
    ports:
      - "80:80"
    deploy:
      mode: replicated
      replicas: 1
#    networks: # 서버와 같은 네트워크, 잊지 마세요!
#       - backend

#networks: # 가장 기본적인 bridge 네트워크
#  backend:
#    driver: bridge
```
  - docker stack deploy 명령어   
   > docker stack deploy STACK --compose-file docker-compose.yml --force   
   > docker stack deploy -c docker-compose.yml  STACK  
  
  - docker에서 사용됫던 명령어 참고
  ```
    945  docker stack deploy -c docker-compose.yml  STACK
  946  watch -n 1 docker service logs -ft STACK_eams
  947  docker service ls
  948  watch -n 1 docker service logs -ft STACK_eamswas
  949  watch -n 1 docker stack service ps STACK_eamswas
  950  watch -n 1 docker stack ps STACK_eamswas
  951  watch -n 1 docker stack ps STACK
  952  docker stack deploy STACK --compose-file docker-compose.yml --force
  953  docker stack deploy STACK --compose-file docker-compose.yml
  954  docker stack rm STACK
  955  docker stack deploy STACK --compose-file docker-compose.yml
  958  docker stack deploy --compose-file docker-compose.yml STACK
  962  docker stack deploy --compose-file docker-compose.yml STACK
  963  docker service update --force STACK_eamswas
  968  docker stack deploy --compose-file docker-compose.yml STACK
  969  docker service update --force STACK_eamswas
  970  docker ps
  971  docker node ls
  972  docker ps
  976  docker ps
  977  docker node ls
  978  docker service ls
  981  docker ps
  984  docker stack rm STACK
  992  docker build -t nginx:custom .
  993  docker build -t nginx:custom .
  997  cat docker-compose.yml
  999  docker stack deploy -c docker-compose.yml  STACK
 1002  cat docker-compose.yml
 1044  cat docker-compose.yml
 1046  history | grep docker
  ```
  

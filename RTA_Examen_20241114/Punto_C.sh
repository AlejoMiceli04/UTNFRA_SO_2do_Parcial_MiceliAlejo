Trabajar dentro de la carpeta <path-repo>/202406/docker/

En el directorio de la repo:

cd 202406/

cd docker/

vim html.index

Completa con tus datos 

-ejecutar:

sudo usermod -a -G docker miceli

una vez ejecutado este comando el usuario vagrant va a tener permisos para ejecutar los comandos de docker.


-Corroborar con:

cat /etc/group


Crear el dockerfile:

cat << EOF > dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF


Creo el run.sh:

cat << EOF > run.sh
 	#! bin/bash
	docker run -d -p 8080:80 alejomiceli04/2doparcial:latest
EOF

nos logueamos en docker:

docker login -u alejomiceli04

docker build -t web1-miceli .
nos tagueamos:
docker tag web1-miceli alejomiceli04/2doparcial:latest

hacemos el push (levanta la pagina):
docker push alejomiceli04/2doparcial:latest

ejecutamos:
docker run -d -p 8080:80 alejomiceli04/2doparcial:latest


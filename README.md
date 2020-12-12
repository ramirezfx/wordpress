# wordpress
Get The file with
wget https://github.com/ramirezfx/wordpress/archive/main.zip

Uncompress the file
unzip main.zip

Navigate To The Working-Directory:
cd wordpress-main

Change The File docker-compose.yaml to your needs (DB-NAME, DW-PWD,...)

Compile/Start The Container:
docker-compose up -d

Point Your Browser To http://localhost:port (8080 by default)

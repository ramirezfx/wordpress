# wordpress
Get The file with

`git clone https://github.com/ramirezfx/wordpress.git`

Rename the folder to your project or domain:

`mv wordpress yourproject`

Navigate To The Working-Directory:

`cd yourproject`

Change The File .env to your needs (DB-NAME, DW-PWD,...)

Compile/Start The Container:

`docker-compose up -d`

Point Your Browser To http://localhost:port (8080 by default) and start the installation

If you use all-in-one-wp-migration, you can use this procedure to restore:
Download and install the plugin:

https://drive.google.com/file/d/1hfHc6pFAaKi43QRYifV-LFteBiYew6bp/view?usp=sharing

Check This Video to eliminate the max-upload-limit:

`https://www.youtube.com/watch?v=4TvZPXBUV2g`

Copy the backup into the container:

`docker cp {BACKUPFILE} {WP-CONTAINER}:/var/www/html/wp-content/ai1wm-backups`

Change the correct permissions:

`docker exec -it {WP-CONTAINER} chown www-data /var/www/html/wp-content/ai1wm-backups/{BACKUPFILE}`

`docker exec -it {WP-CONTAINER} chgrp www-data /var/www/html/wp-content/ai1wm-backups/{BACKUPFILE}`

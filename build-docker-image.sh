echo "TAG (example: filezilla:latest)"
read tag
echo "Container-name"
read containername
sudo docker build -t $tag .
echo "Build finished"
echo "Creating Container...."
docker run -it -d --restart always -p 80:80 -p 443:443 --name $containername $tag
sleep 10
docker exec -it $containername /bin/bash /tmp/firstrun.sh
docker container stop $containername
docker container start $containername

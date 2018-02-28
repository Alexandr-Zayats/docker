docker plugin install rexray/csi-nfs
docker plugin disable rexray/csi-nfs
docker plugin set rexray/csi-nfs X_CSI_NFS_VOLUMES="openstack=172.28.27.15:/openstack"
docker plugin enable rexray/csi-nfs
docker volume ls
docker run -it -v openstack:/mnt alpine sh

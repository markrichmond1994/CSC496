FROM alpine:latest
RUN -d --name nfs --privileged --net=host
RUN -v /home/ubuntu/logs:/nfsshare -e SHARED_DIRECTORY=/nfsshare
RUN itsthenetwork/nfs-server-alpine:latest
RUN sudo apt install -y nfs-common
RUN sudo mount -v 192.168.56.106:/ CSC496NFS

FROM busybox

# TODO: Split later to docker-shop-base and use that as FROM (to have common tool scripts in all shop-containers)
COPY base /

# Scripts
COPY list.sh /
COPY install.sh /

# Empty data folder where later shop gets cloned/installed to dynamically
COPY data /
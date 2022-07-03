FROM debian:bullseye-slim

WORKDIR /var/www/app

RUN apt-get update && apt-get install -y wget xz-utils make python3

RUN LINUX_NUM=$(uname -r | cut -d'.' -f1) && \
    # Gets the Linux version and strips out the 'linuxkit' part
    LINUX_VER=$(uname -r | cut -d'.' -f1-3 | cut -d'-' -f1) && \
    # Downloads compressed linux-tools for the version
    wget "https://cdn.kernel.org/pub/linux/kernel/v$LINUX_NUM.x/linux-$LINUX_VER.tar.xz" && \
    tar -xf "./linux-$LINUX_VER.tar.xz" && cd "linux-$LINUX_VER/tools/perf/" && \
    # Install libelf-dev or `perf probe` gets disabled
    apt-get update && apt -y install flex bison ocaml libelf-dev libssl-dev libperl-dev libiberty-dev && \ 
    make -C . && make install && \
    # copy perf into the executable path. Works as long as "/usr/local/bin"
    # is in the $PATH variable
    cp perf /usr/local/bin

# Set up nginx
RUN apt-get install nginx -y

COPY conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
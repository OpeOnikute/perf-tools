# Perf Tools

Debian Docker image with perf installed, for use on Docker for MacOS. Blog post: https://opeonikute.dev/posts/how-to-use-perf-on-macos

Use the image as a base and install whatever tool you want to triage with perf. e.g. NodeJS or Nginx. This image comes with Nginx as a means of running the container, but you can change that.

## Usage

- Build the image
    ```
    docker run --name perf-tools --privileged -p 8080:80 -d opeo/perftools
    ```

- Create a bash shell
    ```
    docker exec -it perf-tools bash
    ```

- Run perf commands
    ```
    root@5851e5014e1d:/var/www/app# perf probe -x /usr/sbin/nginx -F
    ASN1_GENERALIZEDTIME_print@plt
    ASN1_TIME_print@plt
    ASN1_d2i_bio@plt
    BIO_ctrl@plt
    BIO_free@plt
    BIO_int_ctrl@plt
    BIO_new@plt
    BIO_new_file@plt
    BIO_new_mem_buf@plt
    BIO_read@plt
    ...
    ```
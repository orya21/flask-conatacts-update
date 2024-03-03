# Base image ...
FROM python:3.10.12
# Work directory / main directory
WORKDIR ...
# COPY NEEDED FILES FROM THE PROJECT
COPY
ADD

VOLUME

# RUNING commands to install the dependencies and run python project
RUN ...
RUN ...

CMD ["flask","run"]

# NEED TO EXPOSE PORT FROM THE CONTAINER!!!!
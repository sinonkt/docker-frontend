FROM sinonkt/docker-slurmbase

LABEL maintainer="oatkrittin@gmail.com"

ENV EASYBUILD_PREFIX=${MODULES_DIR}
ENV MODULEPATH=${MODULES_DIR}/modules/all:$MODULEPATH

# Install slurm, slurm-perlapi
RUN rpm -ivh ${ROOT_RPMS}/slurm-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-perlapi-${SLURM_VERSION}-1.el7.x86_64.rpm && \
  rm -rf ${ROOT_RPMS}/*

# Switch to user `modules` to install EasyBuild
USER modules
WORKDIR /home/modules

# Install EasyBuild, Simulate source profile when we ssh
# RUN source /etc/profile.d/z00_lmod.sh && \
#     wget https://raw.githubusercontent.com/easybuilders/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py && \
#     python bootstrap_eb.py $EASYBUILD_PREFIX && \
#     rm -f bootstrap_eb.py

# Switch to root before run script
USER root

VOLUME [ "/sys/fs/cgroup", "/etc/slurm" ]

EXPOSE 22
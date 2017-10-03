FROM centos:7
MAINTAINER ManageIQ https://github.com/ManageIQ/container-ruby

## For ruby
ENV RUBY_GEMS_ROOT=/opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0 \
    PATH=$PATH:/opt/rubies/ruby-2.4.2/bin \
    LANG=en_US.UTF-8

# Install repos
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    curl -sL https://copr.fedorainfracloud.org/coprs/postmodern/ruby-install/repo/fedora-25/postmodern-ruby-install-fedora-25.repo -o /etc/yum.repos.d/ruby-install.repo && \
    sed -i 's/\$releasever/25/g' /etc/yum.repos.d/ruby-install.repo

# Install ruby-install and make
RUN yum -y install --setopt=tsflags=nodocs ruby-install make

RUN ruby-install ruby 2.4.2 -- --disable-install-doc && rm -rf /usr/local/src/* && yum clean all

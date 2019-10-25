FROM centos:7
MAINTAINER ManageIQ https://github.com/ManageIQ/container-ruby

## For ruby
ENV RUBY_GEMS_ROOT=/usr/local/lib/ruby/gems/2.5.0 \
    LANG=en_US.UTF-8

# Install repos
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    curl -sL https://copr.fedorainfracloud.org/coprs/manageiq/ManageIQ-Master/repo/epel-7/manageiq-ManageIQ-Master-epel-7.repo -o /etc/yum.repos.d/manageiq.repo

# Install ruby-install and make
RUN yum -y install --setopt=tsflags=nodocs ruby-install make

RUN ruby-install --system ruby 2.5.7 -- --disable-install-doc --enable-shared && rm -rf /usr/local/src/* && yum clean all

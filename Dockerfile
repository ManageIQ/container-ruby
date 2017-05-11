FROM centos:7
MAINTAINER ManageIQ https://github.com/ManageIQ/manageiq-appliance-build

## For ruby
ENV RUBY_GEMS_ROOT=/opt/rubies/ruby-2.3.1/lib/ruby/gems/2.3.0 \
    LANG=en_US.UTF-8

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install --setopt=tsflags=nodocs \
                   automake                \
                   bzip2                   \
                   cmake                   \
                   gcc-c++                 \
                   gdbm-devel              \
                   git                     \
                   libcurl-devel           \
                   libffi-devel            \
                   libxml2-devel           \
                   libyaml-devel           \
                   make                    \
                   openssl-devel           \
                   readline-devel          \
                   &&                      \
    yum clean all

## Download chruby and chruby-install, install, setup environment, clean all
RUN curl -sL https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz | tar xz && \
    cd chruby-0.3.9 && \
    make install && \
    scripts/setup.sh && \
    echo "gem: --no-ri --no-rdoc --no-document" > ~/.gemrc && \
    echo "source /usr/local/share/chruby/chruby.sh" >> ~/.bashrc && \
    curl -sL https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz | tar xz && \
    cd ruby-install-0.6.0 && \
    make install && \
    ruby-install ruby 2.3.1 -- --disable-install-doc && \
    echo "chruby ruby-2.3.1" >> ~/.bash_profile && \
    rm -rf /chruby-* && \
    rm -rf /usr/local/src/* && \
    yum clean all

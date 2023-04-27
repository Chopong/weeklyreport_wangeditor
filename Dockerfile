# image: weeklyreport:0.3
FROM centos:7
MAINTAINER CodingCrush
ENV LANG en_US.UTF-8
# TimeZone: Asia/Shanghai
RUN ln -s -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    curl -fsSL https://setup.ius.io/ | sh && \
    yum update -y && \
    yum install -y python36u python36u-devel python36u-pip gcc gcc-c++ && \
    mkdir ~/.pip && \
    echo -e "[global]\nindex-url=http://pypi.douban.com/simple/\ntrusted-host=pypi.douban.com">~/.pip/pip.conf && \
    yum clean all

# RUN yum install -y libpqxx-devel postgresql14-libs postgresql14 postgresql14-devel
RUN yum install -y supervisor

RUN mkdir -p /deploy
WORKDIR /deploy
COPY requirements.txt /deploy/requirements.txt
RUN pip3.6 install -U pip && pip3.6 install -r requirements.txt --timeout=120

RUN mkdir -p /var/log/supervisor

COPY deploy /deploy

RUN mkdir -p /scripts
COPY checkdb.py /scripts/checkdb.py
COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

CMD ["/scripts/entrypoint.sh"]
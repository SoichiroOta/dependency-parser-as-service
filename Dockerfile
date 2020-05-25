FROM python:3.7

ENV PYTHONUNBUFFERED 1

ENV JUMAN_VERSION 7.01
ENV JUMAN_URL "http://nlp.ist.i.kyoto-u.ac.jp/DLcounter/lime.cgi?down=http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2&name=juman-7.01.tar.bz2"
ENV JUMANPP_VERSION "2.0.0-rc3"
ENV JUMANPP_URL "https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc3/jumanpp-2.0.0-rc3.tar.xz"
ENV KNP_VERSION 4.19
ENV KNP_URL "http://nlp.ist.i.kyoto-u.ac.jp/DLcounter/lime.cgi?down=http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-${KNP_VERSION}.tar.bz2&name=knp-${KNP_VERSION}.tar.bz2"

RUN cd /tmp && \
    wget ${JUMANPP_URL} && apt -y update && apt install -y cmake && tar xf jumanpp-${JUMANPP_VERSION}.tar.xz && \
    cd jumanpp-${JUMANPP_VERSION} && mkdir bld && cd bld && cmake .. -DCMAKE_BUILD_TYPE=Release && make install && rm -rf /tmp/*
RUN cd /tmp && \
    wget ${JUMAN_URL} -O juman.tar.bz2 && tar jxvf juman.tar.bz2 && cd juman-${JUMAN_VERSION} && ./configure && make && make install && \
    rm -rf /tmp/*
RUN ldconfig
RUN cd /tmp && \
    wget ${KNP_URL} -O knp.tar.bz2 && tar jxvf knp.tar.bz2 && cd knp-${KNP_VERSION} && ./configure && make && make install && \
    rm -rf /tmp/*

# set working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# add requirements
COPY ./requirements.txt /usr/src/app/requirements.txt

# install requirements
RUN pip install -r requirements.txt

# add app
COPY . /usr/src/app

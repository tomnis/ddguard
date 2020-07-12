FROM ubuntu:20.10
MAINTAINER tomas

RUN apt-get update -y && \
    apt-get install -y \
      python3-dev \
      python3-pip \
      python3-hid \
      python3-hidapi \
      python3-lzo \
      vim && \
    pip3 install --upgrade pip && \
    apt-get clean

WORKDIR /app
# We copy just the requirements.txt first to better leverage Docker cache
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY . .
ADD conf/ddguard.conf /etc

CMD [ "python3", "-u", "ddguard.py" ]

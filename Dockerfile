FROM python:2.7

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY run.sh /usr/src/app

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN pip install --no-cache-dir -r requirements.txt
ONBUILD COPY . /usr/src/app

RUN apt-get update && apt-get install -y \
		gcc \
		gettext \
		mysql-client libmysqlclient-dev \
		postgresql-client libpq-dev \
		sqlite3 \
	    --no-install-recommends 

RUN echo "Install opencv 2.9" && \
    apt-get install -y \	
    python-opencv --no-install-recommends \
    && pip install numpy \   
    && cp /usr/lib/python2.7/dist-packages/cv2.x86_64-linux-gnu.so /usr/local/lib/python2.7/site-packages/cv2.so \    
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8000

CMD /bin/bash -c 'ln -s /dev/null /dev/raw1394'; /usr/src/app/run.sh
#Start base image
FROM python:3
#metadata
LABEL maintainer="Nit"
LABEL description="This is a Django application setup with jenkins to deploy it in EC2 and K8S"
#Execution steps for logging and monitoring purpose
ENV PYTHONBUFFERED 1
#setup workdir 
WORKDIR /app
#Cpoy contents to /app
COPY . /app
#Upgrade python packages, install requirements and run manage.py
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && python manage.py migrate
#Create a non-root user
RUN useradd -ms /bin/bash myuser
USER myuser
#Exposing the port
EXPOSE 8000
#Running final application
CMD ["python","manage.py","runserver","0.0.0.0:8000"]
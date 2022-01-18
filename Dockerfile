# Set base image (host OS)
FROM python:3.9-alpine

ENV PYTHONUNBUFFERED 1
# Set the working directory in the container
WORKDIR /code

ENV FLASK_APP=app.py

ENV FLASK_RUN_HOST=0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Upgrad pip
RUN python -m pip install --upgrade pip

# Install any dependencies
RUN pip install -r requirements.txt
RUN pip install python-dotenv

# Copy the content of the local src directory to the working directory
# COPY . .
COPY app.py .

# By default, listen on port 5000
EXPOSE 5000

## Add the wait script to the image
# ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
# RUN chmod +x /wait
# #start-up command
# CMD /wait && npm start

# Specify the command to run on container start
# CMD [ "python", "./app.py" ]
CMD ["flask", "run"]

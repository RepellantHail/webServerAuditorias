# Python image for django
FROM python:3

#Set enviroment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONBUFFERED=1
ENV PORT 3000

#Working dir
WORKDIR /app

COPY requirements.txt ./
COPY package*.json ./

#Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --upgrade pip
RUN pip install python-dotenv
RUN pip install node

#Install Nodemon dependencies
# RUN npm install
# Install Node.js and npm within the container
RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g nodemon

# Install Bootstrap
RUN npm i bootstrap@5.3.3

# Install necessary packages
RUN apt-get update && apt-get install -y postgresql-client

# Freeze the installed packages into requirements.txt
RUN pip freeze > requirements.txt

#Copy Django Project
COPY . /app

# Expose the port
EXPOSE ${PORT}

# Set up Nodemon command
RUN ln -s /usr/local/bin/nodemon /usr/bin/nodemon

# Verify the link
RUN which nodemon

# Start the server with nodemon to reload on changes
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
# CMD ["gunicorn", "server.wsgi:application", "--bind", "0.0.0.0:8000"]
CMD ["sh", "-c", "/usr/local/bin/nodemon --watch . --ext py --exec 'gunicorn server.wsgi:application --bind 0.0.0.0:8000'"]
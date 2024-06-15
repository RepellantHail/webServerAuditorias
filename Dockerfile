FROM python:3

#Set enviroment variables
ENV PYTHONBUFFERED=1
ENV PORT 3000

#Working dir
WORKDIR /app

COPY requirements.txt ./

#Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --upgrade pip
RUN pip install python-dotenv

# Freeze the installed packages into requirements.txt
RUN pip freeze > requirements.txt

#Copy Django Project
COPY . /app

CMD gunicorn server.wsgi:application --bind 0.0.0.0:"${PORT}"

EXPOSE ${PORT}
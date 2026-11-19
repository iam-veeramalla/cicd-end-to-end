
FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir django==3.2

COPY . .

RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM python:3.7-buster

WORKDIR /app

RUN apt update

RUN apt install -y python3-opencv

COPY src/requirements.txt .

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

COPY src .

CMD ["python", "main.py"]
# ENTRYPOINT ["gunicorn", "src/main:app", "--bind", ":8080", "--worker-class", "aiohttp.GunicornWebWorker"]


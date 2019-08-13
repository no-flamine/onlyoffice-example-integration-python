from bottle import route, run, template, get, post, static_file, request  # подключение фреймворка и необходимых компонентов
from os import listdir  # подключение библиотеки для просмотра каталогов
import json
import pprint
import requests

config = json.loads(open('./config.json').read())
app_url = config['app']['protocol'] + "://" + config['app']['url'] + ":" + config['app']['port']
editor_url = config['editor']['protocol'] + "://" + config['editor']['url'] + ":" + config['editor']['port']
sample_files = [f for f in listdir('files')]


@route('/')  # настройка роутинга для запросов на /
def index():
    return template('index.tpl',
                    editor_url=editor_url,
                    app_url=app_url,
                    sample_files=sample_files)  # показываем шаблон в ответ на запрос


@get("/files/<filepath:re:.*\.*>")
def show_sample_files(filepath):
    return static_file(filepath, root="files")


@post("/callback")
def callback():
    if request.json['status'] == 2:
        file = requests.get(request.json['url']).content
        with open('files/' + request.query['filename'], 'wb') as f:
            f.write(file)
    return "{\"error\":0}"


run(host="0.0.0.0", port="8080")  # запускаем приложение на 8080 порте

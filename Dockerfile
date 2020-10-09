FROM python:3.4
#Создание группы пользователей uwsgi с помощью штатных средств Unix
RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN pip install Flask uWSGI requests==2.5.1 redis==2.10.3
#Flask==0.10.1 uWSGI==2.0.8
WORKDIR /app
COPY app /app
#добавление скрипта в контейнер
COPY cmd.sh / 
#Использование инструкции EXPOSE для объявления портов, доступных для хоста и других контейнеров
EXPOSE 9090 9191
#Определение имени пользователя uwsgi для всех последующих строк
USER uwsgi

#CMD ["uwsgi", "--http", "0.0.0.0:9090", "--wsgi-file", "/app/identidock.py", \
#    "--callable","app", "--stats", "0.0.0.0:9191" ]
#вызов скрипта из инструкции CMD
CMD [ "/cmd.sh" ]
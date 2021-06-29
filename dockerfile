FROM python:alpine2.7
COPY . /app
WORKDIR /app
RUN pip install --upgrade pip
RUN pip install -r prerequisites.txt
EXPOSE 5001
ENTRYPOINT [ "python" ]
CMD [ "GAPHHackathon26June2021/src/com/ibm/hackathon/__init__.py" ]
FROM tensorflow/tensorflow:1.14.0-gpu-py3

WORKDIR /home

# add required files to srv folder
COPY requirements.txt /srv/requirements.txt
# pip install requirements
# Flask==1.1.1
#RUN pip3 install Flask==1.1.1
RUN pip3 install -r /srv/requirements.txt

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
#ENTRYPOINT [ "bash" ]
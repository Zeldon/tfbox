FROM tensorflow/tensorflow:1.14.0-gpu-py3-jupyter
#FROM tensorflow/tensorflow:1.14.0-gpu-py3

# Set non-interactive frontend for installs
ENV DEBIAN_FRONTEND=noninteractive

# install git
RUN apt-get update -y
#RUN apt-get upgrade
RUN apt-get -y install git

# Get the tensorflow models research directory, and move it into tensorflow
# source folder to match recommendation of installation
RUN git clone --depth 1 https://github.com/tensorflow/models.git && \
mkdir /tensorflow && \
mv models /tensorflow/models

# Install gcloud and gsutil commands
# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
apt-get update -y && apt-get install google-cloud-sdk -y

# Install object detection api dependencies
RUN apt-get install -y protobuf-compiler python-pil python-lxml python-tk && \
pip install Cython && \
pip install contextlib2 && \
pip install jupyter && \
pip install matplotlib

# Install pycocoapi
RUN git clone --depth 1 https://github.com/cocodataset/cocoapi.git && \
cd cocoapi/PythonAPI && \
make -j8 && \
cp -r pycocotools /tensorflow/models/research && \
cd ../../ && \
rm -rf cocoapi

# Get protoc 3.0.0, rather than the old version already in the container
RUN curl -OL "https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip" && \
unzip protoc-3.0.0-linux-x86_64.zip -d proto3 && \
mv proto3/bin/* /usr/local/bin && \
mv proto3/include/* /usr/local/include && \
rm -rf proto3 protoc-3.0.0-linux-x86_64.zi

# Run protoc on the object detection repo
RUN cd /tensorflow/models/research && \
protoc object_detection/protos/*.proto --python_out=.

# Set the PYTHONPATH to finish installing the API
ENV PYTHONPATH $PYTHONPATH:/tensorflow/models/research:/tensorflow/models/research/slim


# set working directory
WORKDIR /home

# add required files to srv folder
COPY requirements.txt /srv/requirements.txt
# pip install requirements
# Flask==1.1.1
#RUN pip3 install Flask==1.1.1
RUN pip3 install -r /srv/requirements.txt

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
#ENTRYPOINT [ "bash" ]
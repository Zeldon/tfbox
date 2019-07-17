# tfbox
This is a box setup to work on tensorflow stuff. A gui will be presented via flask, to abstract out some pre-processing and logistics, however the documentation will also be included to explain the code and logic behind it.

### TODOs
1. Overview pipeline.
2. Model Choices.
3. Pipeline Explanation.
4. GUI controls.

### Notes
1. docker-compose can't provide nvidia runtime yet. Hence using shell script to launch flask environment.

## Overview

### Build Image
Build image with script via  
`sh createdockerimage.sh`

Image base comes from tensorflow/1.14-py3
Image name is currently alised zeltf.

Run container with script via  
`sh runflaskcontainer.sh`

### Docker setups

#### 1. docker-compose
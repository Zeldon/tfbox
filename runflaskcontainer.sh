docker run -it --rm \
--runtime=nvidia \
-v $(pwd)/app:/home \
-p 5000:5000 zeltf:latest
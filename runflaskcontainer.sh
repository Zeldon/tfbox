docker run -it --rm \
-e FLASK_APP=tfgui.py \
-e FLASK_DEBUG=1 \
-v $(pwd)/tfgui:/home \
--runtime=nvidia \
-p 5000:5000 \
-d \
--name fg \
zeltf:latest
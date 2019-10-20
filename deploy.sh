docker stop angularapp && \
docker rm angularapp && \
docker pull manonair/angularapp && \
docker run -d --name=angularapp -p 8000:80 manonair/angularapp

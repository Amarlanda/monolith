name="docker-terraform"
echo $name
rm $name -rf
mkdir $name
chmod 755 $name
cd $name

echo location
pwd

echo '# Test dockerfile to build terraform
# Linux x64
FROM hashicorp/terraform:full

LABEL maintainer="al@amarlanda.com"

# Install Node and NPM
#RUN apk add --update nodejs nodejs-npm

# Copy app to /src
#COPY . /src

#WORKDIR /src

# Install dependencies
#RUN  npm install

#RUN make /app
#CMD terraform build'>> Dockerfile.yaml
ls
pwd
chmod 755  Dockerfile.yaml
docker image build .

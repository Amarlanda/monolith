
FROM hashicorp/terraform:full

#RUN apk add --no-cache
RUN apk add bash
RUN apk add py-pip
RUN apk add jq
RUN apk add git
RUN apk add openssh-server

RUN pip install --upgrade \
        pip \
        awscli


ENTRYPOINT ["/bin/bash"]

ARG ssh_prv_key
ARG ssh_pub_key

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Add the keys and set permissions
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub

# Avoid cache purge by adding requirements first
#ADD ./requirements.txt /app/requirements.txt

#WORKDIR /app/

#RUN pip install -r requirements.txt

# Remove SSH keys
#RUN rm -rf /root/.ssh/

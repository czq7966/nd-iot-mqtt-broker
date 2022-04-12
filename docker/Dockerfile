FROM node:10.14.1
RUN mkdir -p /home/mqtt \
    && groupadd -r mqtt \
    && useradd -r -g mqtt -d /home/mqtt -u 8080 mqtt \
    && usermod -a -G sudo mqtt \
    && usermod -a -G adm mqtt \
    && usermod -a -G staff mqtt \
    && chown -R mqtt:mqtt /home/mqtt \
    && echo "root:123456" | chpasswd

USER mqtt      
RUN mkdir -p /home/mqtt/app
ADD data /home/mqtt/app
RUN cd /home/mqtt/app \
    &&  npm install -g forever  \
    &&  npm install
WORKDIR /home/mqtt/app
EXPOSE 8080
CMD ["forever", "src/index.js"]

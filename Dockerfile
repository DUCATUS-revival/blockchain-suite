FROM ducatuscore-ducatuscoin-p90x

WORKDIR /root/

RUN apt-get install -y curl
RUN curl –sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

ADD ducatusnode.tar.gz /root/ducatusnode
RUN npm install -g litecore-node@latest && \
rm -rf node_modules/insight-lite-ui

RUN cp /usr/local/bin/ducatuscoind /root/ducatusnode/node_modules/litecore-node/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /root/ducatusnode/node_modules/litecore-node/bin/litecoin-0.13.2/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /root/ducatusnode/node_modules/.bin/litecoind && \
cp /usr/local/bin/ducatuscoind /usr/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /usr/bin/bitcoind && \
cp /usr/local/bin/ducatuscoind /usr/lib/node_modules/litecore-node/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /usr/lib/node_modules/litecore-node/bin/litecoin-0.13.2/bin/litecoind

RUN sed -i 's/rpcport: 9332/rpcport: 9690/g' /root/ducatusnode/node_modules/litecore-node/lib/services/bitcoind.js
ADD ./docker-files/network.js /root/ducatusnode/node_modules/litecore-lib/lib/networks.js
ADD ./docker-files/bitcoin.conf /root/ducatusnode/data/bitcoin.conf
ADD ./docker-files/bitcoin.conf /root/ducatusnode/data/litecoin.conf
ADD ./docker-files/bitcoin.conf /root/ducatusnode/data/ducatuscoin.conf

ADD insight-ducatus-ui /root/ducatusnode/node_modules/insight-lite-ui

WORKDIR /root/ducatusnode

# Expose ports
EXPOSE 3001 9690 9691

CMD ["litecore-node", "start"]


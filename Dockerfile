FROM ducatuscore-ducatuscoin

WORKDIR /root/

RUN apt-get install -y curl
RUN curl –sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

RUN npm install -g litecore-node@latest && \
litecore-node create ducatusnode && \
cd ducatusnode && \
litecore-node install insight-lite-api && \
litecore-node install insight-lite-ui

RUN cp /usr/local/bin/ducatuscoind /root/ducatusnode/node_modules/litecore-node/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /root/ducatusnode/node_modules/litecore-node/bin/litecoin-0.13.2/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /root/ducatusnode/node_modules/.bin/litecoind && \
cp /usr/local/bin/ducatuscoind /usr/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /usr/lib/node_modules/litecore-node/bin/litecoind && \
cp /usr/local/bin/ducatuscoind /usr/lib/node_modules/litecore-node/bin/litecoin-0.13.2/bin/litecoind

RUN sed -i 's/rpcport: 9332/rpcport: 9690/g' /root/ducatusnode/node_modules/litecore-node/lib/services/bitcoind.js  
ADD ./docker-files/network.js /root/ducatusnode/node_modules/litecore-lib/lib/networks.js
ADD ./docker-files/bitcoin.conf /root/ducatusnode/data/bitcoin.conf
ADD ./docker-files/bitcoin.conf /root/ducatusnode/data/litecoin.conf
ADD ./docker-files/bitcoin.conf /root/ducatusnode/data/ducatuscoin.conf

EXPOSE 3001

CMD ["/bin/bash"]

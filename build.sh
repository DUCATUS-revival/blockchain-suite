#!/bin/bash
cat ducatusnode-part-* > ducatusnode.tar.gz
docker build . -t ducatus-blockchain-explorer 

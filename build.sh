#!/bin/bash
cat ducatusnode-part-* > ducatusnode.tar.gz
cat usr_lib_node_modules-* > usr_lib_node_modules.tar.gz
docker build . -t ducatus-blockchain-explorer-p90x

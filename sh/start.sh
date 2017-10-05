# This script starts the private network
# it works as aspected only if you already had initialized it;
# the networkid passed in has to be the same defined inside the genesis.json 
# and yeh, you need to pass --datadir every time

geth --datadir net/.data --networkid 123 --mine --minerthreads=2

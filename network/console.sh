# once you initialized a network (init.sh)
# and started it (start.sh)
# you can launch a console in another shell and send command to your network;
# This script launch the console and attach it to the network

geth attach .chaindata/geth.ipc

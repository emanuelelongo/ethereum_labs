# this script initilize the private network
# launch this just once or when you need to reset everythingù

# clear previous data
rm -rf .chaindata
mkdir .chaindata

# generate couple of addresses and insert them into the genesis.json
ADDR=$(geth --datadir=.chaindata --password ./password.txt account new | cut -d "{" -f2 | cut -d "}" -f1)
sed -e "s/ADDR1/$ADDR/g" genesis_template.json > genesis.json
ADDR=$(geth --datadir=.chaindata --password ./password.txt account new | cut -d "{" -f2 | cut -d "}" -f1)
sed -i -e "s/ADDR2/$ADDR/g" genesis.json
rm *-e

# initialize the network
geth --datadir .chaindata init genesis.json

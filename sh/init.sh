# this script initilize the private network
# launch this just once or when you need to reset everythingù

# clear previous data
rm -rf net/.data
mkdir net/.data

# generate couple of addresses and insert them into the genesis.json
# since it is a testing network I don't mind having different passwords for each account
ADDR=$(geth --datadir=net/.data --password net/password.txt account new | cut -d "{" -f2 | cut -d "}" -f1)
sed -e "s/ADDR1/$ADDR/g" net/genesis_template.json > net/genesis.json
ADDR=$(geth --datadir=net/.data --password net/password.txt account new | cut -d "{" -f2 | cut -d "}" -f1)
sed -i -e "s/ADDR2/$ADDR/g" net/genesis.json
rm net/*-e

# initialize the network
geth --datadir net/.data init net/genesis.json

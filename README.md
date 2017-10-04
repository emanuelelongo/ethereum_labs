# -- draft --

## Ethereum Blockchain Programming

The following repository contains experiments on the Ethereum blockchain programming.
If you are totally new to the subject there is a lot of stuff to read, just to begin:

* [intro to programming smart contract](https://medium.com/@ConsenSys/a-101-noob-intro-to-programming-smart-contracts-on-ethereum-695d15c1dab4)
* [solidity](https://solidity.readthedocs.io/en/develop/)

Long story short, you write a kind of singleton classes, called _smart contracts_, that are deployed over the network and kept in execution by the miners. Miners take commissions to run this code so a contract needs some money - or [gas](https://ethereum.stackexchange.com/questions/3/what-is-meant-by-the-term-gas) - to stay alive.

In order to easly experiment we need a test environment where to deploy the contract so the first step is to create a private network, something like a clone of the real Ethereum network but inside you PC. Inside this network we can mine, execute transactions and deploy contracts.

### Create the network
To create the network you need to install one of the several implementations of Ethereum, I opted for [geth](https://github.com/ethereum/go-ethereum), the Golang version.

```
$ brew tap ethereum/ethereum
$ brew install ethereum
```

Once installed, _geth_ allow you to interact with the real network as well as a private networks. Keep in mind that unless you avoid it explicitly by parameters, geth will try to _connect_ to the real network and to download a huge amount of data so don't go blind and keep reading.

To make things easier the <code>network</code> folder of this repo contains some script that automate creation of the network. 

 We'll need to create some accounts in order to execute transactions.
First step is to define the password of these accounts.
Since it is a testing network we don't mind to have different passwords for each account, instead simply decide your unique password and write it inside the <code>network/password.txt</code> file.

This is the only configuration I left outside these scripts, if you want more control take a look at <code>network/genesis_template.json</code> file.


```
cd network
vim password.txt
# write your password and save
./init.sh
./start.sh
```

Your network is now created and running.
Next time you'll need to start it, simply run the <code>start.sh</code> script.

Now you are ready to open a console and interact with your fresh network.
Open another shell and let's check the two account we creted:

```
cd network
./console.sh
> eth.accounts
```

You should see an array of two address.
We want now check the balance of these two address

```
web3.fromWei(eth.getBalance('<first address>'), "ether")
web3.fromWei(eth.getBalance('<second address>'), "ether")
```

### Send a transaction

```
personal.unlockAccount('<first address>', 'password')
eth.sendTransaction({from: '<first address>', to: '<first address>', value: web3.toWei(1, 'ether')})
web3.fromWei(eth.getBalance('<first address>'), "ether")
web3.fromWei(eth.getBalance('<second address>'), "ether")
```

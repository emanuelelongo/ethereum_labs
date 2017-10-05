# -- draft --

## Ethereum Blockchain Programming

The following repository contains experiments on the Ethereum blockchain programming.
If you are totally new to the subject there is a lot of stuff to read, just to begin:

* [intro to programming smart contract](https://medium.com/@ConsenSys/a-101-noob-intro-to-programming-smart-contracts-on-ethereum-695d15c1dab4)
* [solidity](https://solidity.readthedocs.io/en/develop/)
* [deploying smart contract the hard way](https://medium.com/@gus_tavo_guim/deploying-a-smart-contract-the-hard-way-8aae778d4f2a)

Long story short, you write a kind of singleton classes, called _smart contracts_, that are deployed over the network and kept in execution by the miners. Miners take commissions to run this code so a contract needs some money - or [gas](https://ethereum.stackexchange.com/questions/3/what-is-meant-by-the-term-gas) - to stay alive.

In order to easly experiment we need a test environment where to deploy the contract so the first step is to create a private network, something like a clone of the real Ethereum network but inside you PC. Inside this network we can mine, execute transactions and deploy contracts.

### Create the network
To create the network you need to install one of the several implementations of Ethereum, I opted for [geth](https://github.com/ethereum/go-ethereum), the Golang version.

```
$ brew tap ethereum/ethereum
$ brew install ethereum
```

Once installed, _geth_ allow you to interact with the real network as well as a private networks. Keep in mind that unless you avoid it explicitly by parameters, geth will try to _connect_ to the real network and to download a huge amount of data so don't go blind and keep reading.

To make things easier the <code>sh</code> folder of this repo contains some script that automate common tasks.

The first script we are going to run is <code>sh/init.sh</code>.
This script will initialize the network creating two prefilled account. I recommend to go deeper in details looking at the script itself, it is commented.
The second one is <code>sh/start.sh</code> that will start the network.

```
$ sh/init.sh
$ sh/start.sh
```

Your network is now here and running.
Next time you'll need to start it, simply run the <code>sh/start.sh</code> script.

### Using the console
Now you are ready to open a console and interact with your fresh network.
Open another shell and let's check the two account we creted:

```
$ sh/console.sh
> eth.accounts
```

You should see an array of two address.
We want now check the balance of these two address

```
> web3.fromWei(eth.getBalance('<first address>'), "ether")
> web3.fromWei(eth.getBalance('<second address>'), "ether")
```

As you will have noticed, internal amount are stored in [_Wei_](https://github.com/ethereum/web3.js/blob/0.15.0/lib/utils/utils.js#L40) so we always need to use the <code>web3.fromWei</code> utility to translate in _ether_.

### Send a transaction
...description...
```
> personal.unlockAccount('<first address>', 'password')
> eth.sendTransaction({from: '<first address>', to: '<first address>', > value: web3.toWei(1, 'ether')})
> web3.fromWei(eth.getBalance('<first address>'), "ether")
> web3.fromWei(eth.getBalance('<second address>'), "ether")
```

### Starting and stopping miner
...description...
```
> miner.start(1) # 1 is the number of thread to use
> miner.stop()
```

### Loading script
...description...
```
> loadScript('path/to/script.js')
```

### compile and deploy contracts
...description...
```
$ sh/compile.sh contracts/greeter.sol
$ sh/console.sh
> loadScript('ext/deployContract.js')
> personal.unlockAccount(eth.accounts[0])
> instance = deployContract('greeter', 'ciao!')
> eth.getTransactionReceipt(instance.transactionHash)
```

### Execute deployed contract
...description...

```
> instance.greet()
```
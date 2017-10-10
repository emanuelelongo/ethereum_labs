# Ethereum Blockchain Programming

This repository contains code and notes about my personal exploration of the Ethereum Blockchain Programming.

These experiments are made by "_the hard way_" meaning that I tried to do everything at the lower level possible with the aim of obtaining a good understanding of how things works under the hood.

Since the topic is very wide and complex, this is some useful link to keep on hand:
* [Ethereum white-paper](https://github.com/ethereum/wiki/wiki/White-Paper)
* [Build server less application](https://blog.ethereum.org/2016/07/12/build-server-less-applications-mist/)
* [Solidity](https://solidity.readthedocs.io/en/develop/)
* [Intro to programming smart contracts](https://medium.com/@ConsenSys/a-101-noob-intro-to-programming-smart-contracts-on-ethereum-695d15c1dab4)

Long story short, you are going to write a kind of singleton classes, called _smart contracts_, that are deployed over the network and kept in execution by the miners. Miners take commissions to run this code so a contract needs some money - or [gas](https://ethereum.stackexchange.com/questions/3/what-is-meant-by-the-term-gas) - to stay alive.

In order to easly experiment, we need a test environment where to deploy the contract so the first step is to create a private network, something like a clone of the real Ethereum network but inside you PC. Inside this network we can mine, execute transactions and deploy contracts.

---

### Create the network
To create the network we need to install one of the several implementations of Ethereum, I opted for [geth](https://github.com/ethereum/go-ethereum), the Golang version:

```
$ brew tap ethereum/ethereum
$ brew install ethereum
```

Once installed, _geth_ allow you to interact with the real network as well as a private networks. Keep in mind that unless you avoid it explicitly by passing certain parameters, geth will try to _connect_ to the real network and to download a huge amount of data so don't go blind and keep reading.

To make things easier to replicate I wrote a bash script for almost every command I tried and the <code>sh</code> folder contains these scripts which I will often refer.

The first script we are going to run is <code>sh/init.sh</code>.
This script will initialize the network creating two prefilled account. I would recommend you to go deeper in details looking at the script itself, it is commented.

The second one is <code>sh/start.sh</code> that will start the network.

```
$ sh/init.sh
$ sh/start.sh
```

Your network is now ready and running.
Next time you'll need to start it, simply run the <code>sh/start.sh</code> script.

---

### Using the console
Now you are ready to open a console and interact with your fresh network.
Open another shell and check that the two account we creted:

```
$ sh/console.sh
> eth.accounts
["0x4d07d286781ab735319d4f17ae00beee92a1ccac", "0x91f3e0f9dced777da01dad19376aa1b7ed67da78"]

> eth.getBalance('0x4d07d286781ab735319d4f17ae00beee92a1ccac')
300000
> eth.getBalance('0x91f3e0f9dced777da01dad19376aa1b7ed67da78')
400000
```

As you will have noticed, internal amount are stored in [_Wei_](https://github.com/ethereum/web3.js/blob/0.15.0/lib/utils/utils.js#L40), eventually you can use the <code>web3.fromWei</code> utility to translate in common _ether_.

---

### Send a transaction
Now we'll try to move some money from the first to the second account. To do this we first need to unlock the sender account:

```
> personal.unlockAccount('0x4d07d286781ab735319d4f17ae00beee92a1ccac', 'password')
true
> eth.sendTransaction({from: '0x4d07d286781ab735319d4f17ae00beee92a1ccac', to: '0x91f3e0f9dced777da01dad19376aa1b7ed67da78', > value: web3.toWei(0.01, 'ether')})
```

If we check again the balances of both account we will see that nothing has changed because the transaction has to be confirmed by the network and it take some minutes.

---

### Compile and deploy a contract
Let's exit from the console and back to the bash to compile our first contract.

We need to install the compiler first:

```
$ brew install solidity
$ brew linkapps solidity
```

now we can compile the contract using the script:

```
$ sh/compile.sh contracts/greeter.sol
```
This will produce a file inside the <code>build</code> folder ready to be deployed.

```
$ sh/console.sh
> loadScript('ext/deployContract.js')
> instance = deployContract('greeter', 'ciao!')
> eth.getTransactionReceipt(instance.transactionHash)
null
```

Again, we need some minute for the network to confirm the deployement transaction, if you run again the <code>getTransactionReceipt()</code> method again you'll see some detail about the contract.

---

### Execute a deployed contract
Last step is to execute a method of the contract:

```
> instance.greet()
ciao!
```
Cool! It worked!

---

### Note 
As already said these experiments are done at a low level just to understand how things works but there are tool like [truffle](http://truffleframework.com/) and [testrpc](https://github.com/ethereumjs/testrpc) that can considerably simplify the process of developing and testing a real contract so don't esitate to use them.
var global = this
function deployContract(name, contractCtorParams) {
    loadScript('build/'+name+'.js')
    var contracts = global[name+'Compiled'].contracts
    var contractName = Object.keys(contracts)[0]
    var contract = eth.contract(JSON.parse(contracts[contractName].abi))
    var bin = "0x"+contracts[contractName].bin
    global.lastDeployedContract = contract.new(contractCtorParams, {from: eth.accounts[0], data: bin, gas: 1000000})
    return global.lastDeployedContract

    // ...or to handle multiple parameters to constructor (but doesn't work)
    // var params = [].slice.call(arguments, 1)
    // params.push({ from: eth.accounts[0], data: bin, gas: 1000000 })
    // contract.new.apply(null, params)
}

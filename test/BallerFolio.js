var BallerFolio = artifacts.require("./BallerFolio.sol");


contract('BallerFolio', function(accounts) {
    var account1 = accounts[0];
    var account2 = accounts[1];
    var account3 = accounts[2];
    var account4 = accounts[3];
    var account5 = accounts[4];
    var account6 = accounts[5];
    var name1 = "jaredb";
    var dogTokenAddr = "0x5C323fEA9A614CA64030daB8dBF0e65f7a916CEC";
    var catTokenAddr="0x81A746E15b717E8fa9d521BB7d9Fb298Aa67f8AA";
    var u;


    it("creates a new instance and gets eth balance ", function() {
        return BallerFolio.new({from: account1}).then(function(instance) {
            u = instance;
            return u.getIdEth.call(name1);
        }).then(function(balance) {
            console.log(name1 + "'s balance = " + web3.fromWei(balance.toNumber()));
        });
    });


    it("creates a new instance and gets token balances ", function() {
        return BallerFolio.new({from: account1}).then(function(instance) {
            u = instance;
            return u.getIdEth.call(name1);
        }).then(function(balance) {
            console.log(name1 + "'s balance = " + web3.fromWei(balance.toNumber()));
        });
    });

    it("sets and get dogTokenAddr ", function() {
        return BallerFolio.new({from: account1}).then(function(instance) {
            u = instance;
            return u.editTokenAddress("dog", dogTokenAddr);
        }).then(function(tx) {
            return u.getTokenAddress("dog");
        }).then(function(address) {
            assert.equal(dogTokenAddr.toLowerCase(), address.toString(), "addresses not equal");
        });
    });

    it("retreives a balance from dogtoken ", function() {
        return BallerFolio.new({from: account1}).then(function(instance) {
            u = instance;
            return u.editTokenAddress("dog", dogTokenAddr);
        }).then(function(tx) {
            return u.getTokenAddress("dog");
        }).then(function(address) {
            //return u.getIdTokenBalance("jaredb", "dog");
            return u.tokenBalance(account1, "dog");
        }).then(function(balance) {
            console.log(balance.toNumber());

//            assert.equal(dogTokenAddr.toLowerCase(), address.toString(), "addresses not equal");
        });
    });

});

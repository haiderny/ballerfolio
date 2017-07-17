var BallerFolio = artifacts.require("./BallerFolio.sol");


contract('BallerFolio', function(accounts) {
    var account1 = accounts[0];
    var account2 = accounts[1];
    var account3 = accounts[2];
    var account4 = accounts[3];
    var account5 = accounts[4];
    var account6 = accounts[5];

    var name1 = "jaredb";

    it("creates a new instance and gets eth balance ", function() {
        return BallerFolio.new().then(function(instance) {
            u = instance;
            return u.getIdsEth.call(name1);
        }).then(function(balance) {
            console.log(name1 + "'s balance = " + web3.fromWei(balance.toNumber()));
        });
    });
});

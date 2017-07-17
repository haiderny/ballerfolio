var BallerFolio = artifacts.require("./BallerFolio.sol");


contract('BallerFolio', function(accounts) {
    var account1 = accounts[0];
    var account2 = accounts[1];
    var account3 = accounts[2];
    var account4 = accounts[3];
    var account5 = accounts[4];
    var account6 = accounts[5];

    var name1 = "timtime";
    var name2 = "jbyo";
    var weiToExtend = 5;
    var weiToCreate = 3;



    it("creates a new instance of Foundation and gets weiToExtend", function() {
        var extend=5000;
        var ns;
        return Foundation.new(name2, extend, weiToCreate).then(function(instance) {
            u = instance;
            return u.getWeiToExtend.call();
        }).then(function(wei) {
            assert.equal(wei.toNumber(), extend, extend + " doesn't equal " + wei.toNumber());
        });
    });
});

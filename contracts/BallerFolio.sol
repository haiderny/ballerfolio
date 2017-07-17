pragma solidity ^0.4.11;

/**
@title BallerFolio
@author Jared Bowie
@dev Displays the value of a user's Foundation profile.
*/

contract Foundation {
  uint addrSize;
  function resolveToName(address _addr) constant returns (bytes32) {}
  function getAddrLength(bytes32 _name) constant returns (uint) {}
  function getAddrIndex(bytes32 _name, uint index) constant returns (address) {}
  function hasName(address _addr) constant returns (bool) {}
  function areSameId(address _addr1, address _addr2) constant returns (bool) {}
}

contract BallerFolio {

  address foundationAddress = 0x223CaeB40d6caceB54b67D015d92cD4fd56D75c6;

  function BallerFolio() {
  }

  //////////////////////////////////////////////
  //////////FOUNDATION FUNCTIONS ///////////////
  //////////////////////////////////////////////

  function getAddrIndex(bytes32 foundId, uint index) constant returns (address) {
    Foundation f = Foundation(foundationAddress);
    return f.getAddrIndex(foundId, index);
  }

  function getAddrLength(bytes32 foundId) constant returns (uint) {
    Foundation f = Foundation(foundationAddress);
    uint addrLength = f.getAddrLength(foundId);
    return addrLength;
  }

  address[] allAddr;
  function getFoundAddresses(bytes32 foundId) constant returns (address[]) {
    Foundation f = Foundation(foundationAddress);
    uint addrLength = f.getAddrLength(foundId);
    for (uint i=0; i < addrLength; i++) {
      allAddr.push(getAddrIndex(foundId, i));
    }
    return allAddr;
  }

  function getFoundId(address _addr) constant returns (bytes32) {
    Foundation f = Foundation(foundationAddress);
    bytes32 foundId = f.resolveToName(_addr);
    return foundId;
  }

  function hasFName(address _addr) constant returns (bool) {
    Foundation f = Foundation(foundationAddress);
    bool hasF = f.hasName(_addr);
    return hasF;
  }

  function areSameId(address _addr1, address _addr2) constant returns (bool) {
    Foundation f = Foundation(foundationAddress);
    bool areSameP = f.areSameId(_addr1, _addr2);
    return areSameP;
  }

  ///////////////////////////////////////

  function getOneAddrBal(address _addr) constant returns (uint) {
    return _addr.balance;
  }

    function getIdsEth(bytes32 foundId) constant returns (uint) {
    address[] memory allAddr = getFoundAddresses(foundId);
    uint addrLength = allAddr.length;
    uint totalBalance;
    for (uint i=0; i < addrLength; i++) {
      totalBalance = totalBalance + getOneAddrBal(allAddr[i]);
    }
    return totalBalance;
  }

}

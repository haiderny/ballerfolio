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
}

contract GenericToken {
    function balanceOf(address _owner) constant returns (uint balance) {}
}

contract BallerFolio {
  bytes32 admin;
  mapping (bytes32 => address) tokenAddress;
  address foundationAddress = 0x223CaeB40d6caceB54b67D015d92cD4fd56D75c6;

  /////Admin

  modifier isAdmin() {
    require(hasFName(msg.sender));
    require(admin==getFoundId(msg.sender));
    _;
  }


  function BallerFolio() {
    require(hasFName(msg.sender));
    admin=getFoundId(msg.sender);
  }

  /////

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

  ///////////////////////////////////////


  /////////////////////////////////////////////////
  //////////GENERIC TOKEN FUNCTIONS ///////////////
  ////////////////////////////////////////////////
  function tokenBalance(address _addr, bytes32 tokenName) constant returns (uint) {
    address tAddress = tokenAddress[tokenName];
    GenericToken t = GenericToken(tAddress);
    uint fBalance = t.balanceOf(_addr);
    return fBalance;
  }

  function getIdTokenBalance(bytes32 foundId, bytes32 tokenName) constant returns (uint) {
    address[] memory allAddr = getFoundAddresses(foundId);
    uint addrLength = allAddr.length;
    uint totalBalance;
    for (uint i=0; i < addrLength; i++) {
      totalBalance = totalBalance + tokenBalance(allAddr[i], tokenName);
    }
  }

    ///////////////////////////////////////


  function editTokenAddress(bytes32 _tName, address _tAddr) isAdmin {
    tokenAddress[_tName]=_tAddr;
  }

  function getTokenAddress(bytes32 _tName) constant returns (address) {
    return tokenAddress[_tName];
  }

  function getOneAddrBal(address _addr) constant returns (uint) {
    return _addr.balance;
  }

  function getIdEth(bytes32 foundId) constant returns (uint) {
    address[] memory allAddr = getFoundAddresses(foundId);
    uint addrLength = allAddr.length;
    uint totalBalance;
    for (uint i=0; i < addrLength; i++) {
      totalBalance = totalBalance + getOneAddrBal(allAddr[i]);
    }
    return totalBalance;
  }
}

// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 <0.9.0;

contract FirstCoin {
    address public minter; //address la 1 kieu du lieu trong solidity
    mapping (address => uint) public balances;

    event sent(address from, address to, uint amount);

    constructor () {
        minter = msg.sender;
    }

    //For 2
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter); // Phai la minter thi moi tao ra duoc dong coin
        require(amount < 1e60);

        balances[receiver] += amount;
    }

    // For 3
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Khong du tien");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender, receiver, amount);
    }
}

/*
1. Create a token/coin
2. Create amount token:
  + minter
  + Subly
  + Balance
3. Sent Token
  + Receiver:
   - Amount <= balance else thong bao khong du tien
   - balance of sender -= amount;
   - balance of receiver += amount;
  + Amount
*/
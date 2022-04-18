// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract simpleAution {
    //Variable
    address payable public beneficiary;
    uint public auctionEndTime;

    uint public highestBid;
    address public highestBidder;

    mapping (address => uint) public pendingReturns;

    event highestBidIncrease(address bidder, uint amount);
    event auctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _beneficiary) {
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    bool ended = false;

    //Function
    function bid() public payable {
        // If thoi gian < thoi gian dau qua =>
        if (block.timestamp > auctionEndTime) {
            revert("Aution ended.");// Ket thuc luon
        }

        if (msg.value <= highestBid) {
            revert("Your cost is lower than current bid");
        }

        if (highestBid != 0) {
            pendingReturns[highestBidder] = highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit highestBidIncrease(msg.sender, msg.value);
    }

    function withdraw() public returns(bool) {
        uint amount = pendingReturns[msg.sender];

        if  (amount > 0) {
            pendingReturns[msg.sender] = 0;

            if (!payable(msg.sender).send(amount)) {
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function autionEnd() public {
        if (ended) {
            revert("The auction has been ended.");
        }

        if (block.timestamp < auctionEndTime) {
            revert("The auction hasn't been ended yet.");
        }

        ended = true;
        emit auctionEnded(highestBidder, highestBid);

        beneficiary.transfer(highestBid);
    }
}
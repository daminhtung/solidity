// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Game {

    uint public countPlayer = 0;
    mapping (address => Player) public players;
    enum Level { Beginner, Intermadiate, Avande }

    struct Player {
        string fullName;
        uint age;
        string sex;
        Level myLevel;
    }

    function addPlayer(string memory fullName, uint age, string memory sex) public {
        players[msg.sender] = Player(fullName, age, sex, Level.Beginner);
        countPlayer += 1;
    }

    function getPlayerLevel(address player) public returns (Level) {
        return players[player].myLevel;
    }

    function setPlayerLevel(address player, Level level) public {
        players[player].myLevel = level;
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract CryptoDurak {
    address payable public owner;

    struct Game {
        string id;
        uint bank;
        mapping(address => uint) playersDeposited;
    }

    mapping(string => Game) public activeGames;

    function lockGameMoney(string memory _gameId) public payable {
        activeGames[_gameId].bank += msg.value;
        activeGames[_gameId].playersDeposited[msg.sender] = msg.value;
    }

    function payoutBank(string memory _gameId, address payable _winnerAddress, address _loserAddress) public {
            uint bankToSend = activeGames[_gameId].bank;
            activeGames[_gameId].bank = 0;

            activeGames[_gameId].playersDeposited[_winnerAddress] = 0;
            activeGames[_gameId].playersDeposited[_loserAddress] = 0;

            _winnerAddress.transfer(bankToSend);
    }
}
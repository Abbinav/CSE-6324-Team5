
// File: contracts\guess_the_random_number.sol

/*
 * @source: https://capturetheether.com/challenges/lotteries/guess-the-random-number/
 * @author: Steve Marx
 */

pragma solidity ^0.5.0;

contract GuessTheRandomNumberChallenge {
    uint answer;

    constructor() public payable {
        require(msg.value == 1 ether);
        answer = uint(keccak256(abi.encodePacked(blockhash(block.number - 1), now)));
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint n) public payable {
        require(msg.value == 1 ether);

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

import "stop-conditions.sol";
contract TestToken is Token {
    constructor() public{
        balances[msg.sender] = 10000;
    }
    // the property
    function crytic_test_balance() view public returns(bool){
        return balances[msg.sender] <= 10000;
    }   
}
pragma solidity >=0.4.25 <0.7.0;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/gas_gauge.sol";

contract Testbestyearn {

	 function testInsertInput1() public {

		 address[] memory input1 = new address[](3);
		 uint256[] memory input2 = new uint256[](3);

		bestyearn con = new bestyearn();
		 uint[] memory val = con.getStateVarInbulkTransfer(input1, input2);
		 Assert.equal(val[0], 0, "The number is");
	 }
	 function testInsertInput2() public {

		 address[] memory input1 = new address[](3);
		 uint256[] memory input2 = new uint256[](3);

		bestyearn con = new bestyearn();
		 uint[] memory val = con.getStateVarInbulkTransfer(input1, input2);
		 Assert.equal(val[1], 0, "The number is");
	 }
	 function testInsertInput3() public {

		 address[] memory input1 = new address[](3);
		 uint256[] memory input2 = new uint256[](3);

		bestyearn con = new bestyearn();
		 uint[] memory val = con.getStateVarInbulkTransfer(input1, input2);
		 Assert.equal(val[2], 0, "The number is");
	 }
}

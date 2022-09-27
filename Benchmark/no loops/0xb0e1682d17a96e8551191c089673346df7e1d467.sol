/**

 *Submitted for verification at Etherscan.io on 2020-12-20

*/



//pragma solidity ^0.7.0;     
pragma solidity >=0.5 <0.7.17;







 contract IDFSRegistry {

 

    function getAddr(bytes32 _id) public view  returns (address);



    function addNewContract(

        bytes32 _id,

        address _contractAddr,

        uint256 _waitPeriod

    ) public ;



    function startContractChange(bytes32 _id, address _newContractAddr) public ;



    function approveContractChange(bytes32 _id) public ;



    function cancelContractChange(bytes32 _id) public ;



    function changeWaitPeriod(bytes32 _id, uint256 _newWaitPeriod) public ;

}     







interface IERC20 {

    function totalSupply() external view returns (uint256 supply);



    function balanceOf(address _owner) external view returns (uint256 balance);



    function transfer(address _to, uint256 _value) external returns (bool success);



    function transferFrom(

        address _from,

        address _to,

        uint256 _value

    ) external returns (bool success);



    function approve(address _spender, uint256 _value) external returns (bool success);



    function allowance(address _owner, address _spender) external view returns (uint256 remaining);



    function decimals() external view returns (uint256 digits);



    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}     







library Address {

    function isContract(address account) internal view returns (bool) {

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts

        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned

        // for accounts without code, i.e. `keccak256('')`

        bytes32 codehash;

        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

        // solhint-disable-next-line no-inline-assembly

        assembly {

            codehash := extcodehash(account)

        }

        return (codehash != accountHash && codehash != 0x0);

    }



    function sendValue(address payable recipient, uint256 amount) internal {

        require(address(this).balance >= amount, "Address: insufficient balance");



        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value

        (bool success, ) = recipient.call.value(amount)("");

        require(success, "Address: unable to send value, recipient may have reverted");

    }



    function functionCall(address target, bytes memory data) internal returns (bytes memory) {

        return functionCall(target, data, "Address: low-level call failed");

    }



    function functionCall(

        address target,

        bytes memory data,

        string memory errorMessage

    ) internal returns (bytes memory) {

        return _functionCallWithValue(target, data, 0, errorMessage);

    }



    function functionCallWithValue(

        address target,

        bytes memory data,

        uint256 value

    ) internal returns (bytes memory) {

        return

            functionCallWithValue(target, data, value, "Address: low-level call with value failed");

    }



    function functionCallWithValue(

        address target,

        bytes memory data,

        uint256 value,

        string memory errorMessage

    ) internal returns (bytes memory) {

        require(address(this).balance >= value, "Address: insufficient balance for call");

        return _functionCallWithValue(target, data, value, errorMessage);

    }



    function _functionCallWithValue(

        address target,

        bytes memory data,

        uint256 weiValue,

        string memory errorMessage

    ) private returns (bytes memory) {

        require(isContract(target), "Address: call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = target.call.value(weiValue)(data);

        if (success) {

            return returndata;

        } else {

            // Look for revert reason and bubble it up if present

            if (returndata.length > 0) {

                // The easiest way to bubble the revert reason is using memory via assembly



                // solhint-disable-next-line no-inline-assembly

                assembly {

                    let returndata_size := mload(returndata)

                    revert(add(32, returndata), returndata_size)

                }

            } else {

                revert(errorMessage);

            }

        }

    }

}     







library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        require(c >= a, "SafeMath: addition overflow");



        return c;

    }



    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        return sub(a, b, "SafeMath: subtraction overflow");

    }



    function sub(

        uint256 a,

        uint256 b,

        string memory errorMessage

    ) internal pure returns (uint256) {

        require(b <= a, errorMessage);

        uint256 c = a - b;



        return c;

    }



    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the

        // benefit is lost if 'b' is also tested.

        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522

        if (a == 0) {

            return 0;

        }



        uint256 c = a * b;

        require(c / a == b, "SafeMath: multiplication overflow");



        return c;

    }



    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        return div(a, b, "SafeMath: division by zero");

    }



    function div(

        uint256 a,

        uint256 b,

        string memory errorMessage

    ) internal pure returns (uint256) {

        require(b > 0, errorMessage);

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold



        return c;

    }



    function mod(uint256 a, uint256 b) internal pure returns (uint256) {

        return mod(a, b, "SafeMath: modulo by zero");

    }



    function mod(

        uint256 a,

        uint256 b,

        string memory errorMessage

    ) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}     















library SafeERC20 {

    using SafeMath for uint256;

    using Address for address;



    function safeTransfer(

        IERC20 token,

        address to,

        uint256 value

    ) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));

    }



    function safeTransferFrom(

        IERC20 token,

        address from,

        address to,

        uint256 value

    ) internal {

        _callOptionalReturn(

            token,

            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)

        );

    }



    /**

     * @dev Deprecated. This function has issues similar to the ones found in

     * {ERC20-approve}, and its usage is discouraged.

     */

    function safeApprove(

        IERC20 token,

        address spender,

        uint256 value

    ) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, 0));

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));

    }



    function safeIncreaseAllowance(

        IERC20 token,

        address spender,

        uint256 value

    ) internal {

        uint256 newAllowance = token.allowance(address(this), spender).add(value);

        _callOptionalReturn(

            token,

            abi.encodeWithSelector(token.approve.selector, spender, newAllowance)

        );

    }



    function safeDecreaseAllowance(

        IERC20 token,

        address spender,

        uint256 value

    ) internal {

        uint256 newAllowance = token.allowance(address(this), spender).sub(

            value,

            "SafeERC20: decreased allowance below zero"

        );

        _callOptionalReturn(

            token,

            abi.encodeWithSelector(token.approve.selector, spender, newAllowance)

        );

    }



    function _callOptionalReturn(IERC20 token, bytes memory data) private {

        bytes memory returndata = address(token).functionCall(

            data,

            "SafeERC20: low-level call failed"

        );

        if (returndata.length > 0) {

            // Return data is optional

            // solhint-disable-next-line max-line-length

            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");

        }

    }

}     







contract AdminVault {

    address public owner;

    address public admin;



    constructor() public{

        owner = msg.sender;

        admin = 0x25eFA336886C74eA8E282ac466BdCd0199f85BB9;

    }



    /// @notice Admin is able to change owner

    /// @param _owner Address of new owner

    function changeOwner(address _owner) public {

        require(admin == msg.sender, "msg.sender not admin");

        owner = _owner;

    }



    /// @notice Admin is able to set new admin

    /// @param _admin Address of multisig that becomes new admin

    function changeAdmin(address _admin) public {

        require(admin == msg.sender, "msg.sender not admin");

        admin = _admin;

    }



}     

















/// @title AdminAuth Handles owner/admin priviligies over smart contracts

contract AdminAuth {

    using SafeERC20 for IERC20;



    AdminVault public adminVault = AdminVault(0xCCf3d848e08b94478Ed8f46fFead3008faF581fD);



    modifier onlyOwner() {

        require(adminVault.owner() == msg.sender, "msg.sender not owner");

        _;

    }



    modifier onlyAdmin() {

        require(adminVault.admin() == msg.sender, "msg.sender not admin");

        _;

    }



    /// @notice  withdraw stuck funds

    function withdrawStuckFunds(address _token, address payable _receiver, uint256 _amount) public onlyOwner {

        if (_token == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {

            _receiver.transfer(_amount);

        } else {

            IERC20(_token).safeTransfer(_receiver, _amount);

        }

    }



    /// @notice Destroy the contract

    function kill() public onlyAdmin {

        selfdestruct(msg.sender);

    }



    /// @notice Changes the admin vault that is currently used

    /// @param _newAdminVault Address of the new Admin Vault contract

    function changeAdminVault(address _newAdminVault) public onlyAdmin {

        adminVault = AdminVault(_newAdminVault);

    }

}     







contract DefisaverLogger {

    event LogEvent(

        address indexed contractAddress,

        address indexed caller,

        string indexed logName,

        bytes data

    );



    // solhint-disable-next-line func-name-mixedcase

    function Log(

        address _contract,

        address _caller,

        string memory _logName,

        bytes memory _data

    ) public {

        emit LogEvent(_contract, _caller, _logName, _data);

    }

}     













/// @title Stores all the important DFS addresses and can be changed (timelock)

contract DFSRegistry is AdminAuth {

    DefisaverLogger public constant logger = DefisaverLogger(

        0x5c55B921f590a89C1Ebe84dF170E655a82b62126

    );



    string public constant ERR_ENTRY_ALREADY_EXISTS = "Entry id already exists";

    string public constant ERR_ENTRY_NON_EXISTENT = "Entry id doesn't exists";

    string public constant ERR_ENTRY_NOT_IN_CHANGE = "Entry not in change process";

    string public constant ERR_WAIT_PERIOD_SHORTER = "New wait period must be bigger";

    string public constant ERR_CHANGE_NOT_READY = "Change not ready yet";

    string public constant ERR_EMPTY_PREV_ADDR = "Previous addr is 0";

    string public constant ERR_ALREADY_IN_CONTRACT_CHANGE = "Already in contract change";

    string public constant ERR_ALREADY_IN_WAIT_PERIOD_CHANGE = "Already in wait period change";



    struct Entry {

        address contractAddr;

        uint256 waitPeriod;

        uint256 changeStartTime;

        bool inContractChange;

        bool inWaitPeriodChange;

        bool exists;

    }



    mapping(bytes32 => Entry) public entries;

    mapping(bytes32 => address) public previousAddresses;



    mapping(bytes32 => address) public pendingAddresses;

    mapping(bytes32 => uint256) public pendingWaitTimes;



    /// @notice Given an contract id returns the registred address

    /// @dev Id is keccak256 of the contract name

    /// @param _id Id of contract

    function getAddr(bytes32 _id) public view returns (address) {

        return entries[_id].contractAddr;

    }



    /// @notice Helper function to easily query if id is registred

    /// @param _id Id of contract

    function isRegistered(bytes32 _id) public view returns (bool) {

        return entries[_id].exists;

    }



    /////////////////////////// OWNER ONLY FUNCTIONS ///////////////////////////



    /// @notice Adds a new contract to the registry

    /// @param _id Id of contract

    /// @param _contractAddr Address of the contract

    /// @param _waitPeriod Amount of time to wait before a contract address can be changed

    function addNewContract(

        bytes32 _id,

        address _contractAddr,

        uint256 _waitPeriod

    ) public onlyOwner {

        require(!entries[_id].exists, ERR_ENTRY_ALREADY_EXISTS);



        entries[_id] = Entry({

            contractAddr: _contractAddr,

            waitPeriod: _waitPeriod,

            changeStartTime: 0,

            inContractChange: false,

            inWaitPeriodChange: false,

            exists: true

        });



        // Remember tha address so we can revert back to old addr if needed

        previousAddresses[_id] = _contractAddr;



        logger.Log(

            address(this),

            msg.sender,

            "AddNewContract",

            abi.encode(_id, _contractAddr, _waitPeriod)

        );

    }



    /// @notice Revertes to the previous address immediately

    /// @dev In case the new version has a fault, a quick way to fallback to the old contract

    /// @param _id Id of contract

    function revertToPreviousAddress(bytes32 _id) public onlyOwner {

        require(entries[_id].exists, ERR_ENTRY_NON_EXISTENT);

        require(previousAddresses[_id] != address(0), ERR_EMPTY_PREV_ADDR);



        address currentAddr = entries[_id].contractAddr;

        entries[_id].contractAddr = previousAddresses[_id];



        logger.Log(

            address(this),

            msg.sender,

            "RevertToPreviousAddress",

            abi.encode(_id, currentAddr, previousAddresses[_id])

        );

    }



    /// @notice Starts an address change for an existing entry

    /// @dev Can  a change that is currently in progress

    /// @param _id Id of contract

    /// @param _newContractAddr Address of the new contract

    function startContractChange(bytes32 _id, address _newContractAddr) public onlyOwner {

        require(entries[_id].exists, ERR_ENTRY_NON_EXISTENT);

        require(!entries[_id].inWaitPeriodChange, ERR_ALREADY_IN_WAIT_PERIOD_CHANGE);



        entries[_id].changeStartTime = block.timestamp; // solhint-disable-line

        entries[_id].inContractChange = true;



        pendingAddresses[_id] = _newContractAddr;



        logger.Log(

            address(this),

            msg.sender,

            "StartContractChange",

            abi.encode(_id, entries[_id].contractAddr, _newContractAddr)

        );

    }



    /// @notice Changes new contract address, correct time must have passed

    /// @param _id Id of contract

    function approveContractChange(bytes32 _id) public onlyOwner {

        require(entries[_id].exists, ERR_ENTRY_NON_EXISTENT);

        require(entries[_id].inContractChange, ERR_ENTRY_NOT_IN_CHANGE);

        require(

            block.timestamp >= (entries[_id].changeStartTime + entries[_id].waitPeriod), // solhint-disable-line

            ERR_CHANGE_NOT_READY

        );



        address oldContractAddr = entries[_id].contractAddr;

        entries[_id].contractAddr = pendingAddresses[_id];

        entries[_id].inContractChange = false;

        entries[_id].changeStartTime = 0;



        pendingAddresses[_id] = address(0);

        previousAddresses[_id] = oldContractAddr;



        logger.Log(

            address(this),

            msg.sender,

            "ApproveContractChange",

            abi.encode(_id, oldContractAddr, entries[_id].contractAddr)

        );

    }



    /// @notice Cancel pending change

    /// @param _id Id of contract

    function cancelContractChange(bytes32 _id) public onlyOwner {

        require(entries[_id].exists, ERR_ENTRY_NON_EXISTENT);

        require(entries[_id].inContractChange, ERR_ENTRY_NOT_IN_CHANGE);



        address oldContractAddr = pendingAddresses[_id];



        pendingAddresses[_id] = address(0);

        entries[_id].inContractChange = false;

        entries[_id].changeStartTime = 0;



        logger.Log(

            address(this),

            msg.sender,

            "CancelContractChange",

            abi.encode(_id, oldContractAddr, entries[_id].contractAddr)

        );

    }



    /// @notice Starts the change for waitPeriod

    /// @param _id Id of contract

    /// @param _newWaitPeriod New wait time

    function startWaitPeriodChange(bytes32 _id, uint256 _newWaitPeriod) public onlyOwner {

        require(entries[_id].exists, ERR_ENTRY_NON_EXISTENT);

        require(!entries[_id].inContractChange, ERR_ALREADY_IN_CONTRACT_CHANGE);



        pendingWaitTimes[_id] = _newWaitPeriod;



        entries[_id].changeStartTime = block.timestamp; // solhint-disable-line

        entries[_id].inWaitPeriodChange = true;



        logger.Log(

            address(this),

            msg.sender,

            "StartWaitPeriodChange",

            abi.encode(_id, _newWaitPeriod)

        );

    }



    /// @notice Changes new wait period, correct time must have passed

    /// @param _id Id of contract

    function approveWaitPeriodChange(bytes32 _id) public onlyOwner {

        require(entries[_id].exists, ERR_ENTRY_NON_EXISTENT);

        require(entries[_id].inWaitPeriodChange, ERR_ENTRY_NOT_IN_CHANGE);

        require(

            block.timestamp >= (entries[_id].changeStartTime + entries[_id].waitPeriod), // solhint-disable-line

            ERR_CHANGE_NOT_READY

        );



        uint256 oldWaitTime = entries[_id].waitPeriod;

        entries[_id].waitPeriod = pendingWaitTimes[_id];

        

        entries[_id].inWaitPeriodChange = false;

        entries[_id].changeStartTime = 0;



        pendingWaitTimes[_id] = 0;



        logger.Log(

            address(this),

            msg.sender,

            "ApproveWaitPeriodChange",

            abi.encode(_id, oldWaitTime, entries[_id].waitPeriod)

        );

    }



    /// @notice Cancel wait period change

    /// @param _id Id of contract

    function cancelWaitPeriodChange(bytes32 _id) public onlyOwner {

        require(entries[_id].exists, ERR_ENTRY_NON_EXISTENT);

        require(entries[_id].inWaitPeriodChange, ERR_ENTRY_NOT_IN_CHANGE);



        uint256 oldWaitPeriod = pendingWaitTimes[_id];



        pendingWaitTimes[_id] = 0;

        entries[_id].inWaitPeriodChange = false;

        entries[_id].changeStartTime = 0;



        logger.Log(

            address(this),

            msg.sender,

            "CancelWaitPeriodChange",

            abi.encode(_id, oldWaitPeriod, entries[_id].waitPeriod)

        );

    }

}

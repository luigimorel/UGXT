// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;


/// @title  UGXT  
/// @author Luigi Morel 
/// @notice A token that tethers the value of the Ugandan Shilling (UGX) to a contract on top of the Ethereum network.
/// @dev WIP




//  ------------------------ SafeMath Library -------------------------

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     * Counterpart to Solidity's `-` operator.
     * Requirements:
     * - Subtraction cannot overflow.
     */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     * Counterpart to Solidity's `*` operator.
     * Requirements:
     * - Multiplication cannot overflow.
     */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     * Requirements:
     * - The divisor cannot be zero.
     */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}


interface ERC20Essential 
{

    function transfer(address _to, uint256 _amount) external returns (bool);
    function transferFrom(address _from, address _to, uint256 _amount) external returns (bool);

}
 

//------------------------ Contract to manage the conversion from UGX to UGXT -------------------------

contract UGXT  {
 struct Transfer {
uint amountToConvert;
uint amountToTransfer;
 }

 address payable public receiver;
 uint public transferStart; 
 uint  conversionStart;
 uint public transferEnd;
bool public ended; 

mapping(address => Transfer[]) public transferAmounts ;

// Events that can be used for function calls 
event Sent(address from, address to, uint amount);
event Receive(address to, address from, uint amount);
event withdraw(address to, uint amount);
event TransferEnded (address receiver, uint amount );


    constructor (
        uint _transactionStartTime,
        uint _transactionEndTime,
        address payable _receiver
    )  {
         receiver = _receiver;
         transferStart = _transactionStartTime;
         transferEnd = block.timestamp + _transactionEndTime;
    }


    /**
        * @dev Modifiers to manage the holding and release of the token while the conversion is in progress... 
                    Reverts when dividing by zero.
    **/

        modifier onlyBefore (uint _time){  require( block.tim   estamp  <  _time  ); _;}
        modifier onlyAfter (uint _time){  require( block.timestamp  >  _time  ); _;}



// The total supply of all the tokens 

uint256 totalSupply_;

constructor (
    uint256 total
     )  {
    totalSupply_ = total ;
}

function totalSupply() public view returns (uint256) {
    return totalSupply;
}

/**
* @dev Avoid the re-entracy  by using the Checks-Effects-Interaction to avoid the multiple withdraw of the tokens by the user
 */
function withdraw() public {
    uint transferAmount = transferAmounts[msg.sender];
    transfers[msg.sender] = 0;
    msg.sender.transfer(transfer)
}

function send(address receiver, uint amount ) public {
    require(amount  <= balances[msg.sender], "Insufficient amount");
    balances[msg.sender] -= amount;
    balances[receiver]  += amount;
    emit Sent(msg.sender, receiver, amount);
}

function receive(address sender, uint amount ) public {
    
}
}
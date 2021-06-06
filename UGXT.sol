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
event Send(address account_from, address account_to, uint amount);
event withdraw(address account_from, uint amount);
event Convert(address to, uint amount);
    event Approval (
        address account_owner, 
        address account_spender, 
        uint256 _value
    );

    constructor (
        address payable _sender,
        address payable _receiver,
        uint _amount,
        uint256 _total
    )  {
          _receiver = receiver ;
         _sender = sender ;
          _amount = amount ;
         _total = total  ;
    }

    /**
        * @dev Modifiers to manage the holding and release of the token while the conversion is in progress... 
                    Reverts when dividing by zero.
    **/

        modifier onlyBefore (uint _time){  require( block.timestamp  <  _time  ); _;}
        modifier onlyAfter (uint _time){  require( block.timestamp  >  _time  ); _;}


/// @dev Get the total number of all the tokens in circulation.
//   However, they will be tethered to the value of the UGX at the particular day of trading in the global markets 
/// @return uint256
/// @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)

// uint256 totalSupply;
// function totalSupply() public view returns (uint256) {
//     return totalSupply;
// }

/**
* @dev Avoid the re-entracy  by using the Checks-Effects-Interaction to avoid the multiple withdraw of the tokens by the user
 */
function withdraw(address sender, uint balances, uint value) public {
        require(balances  <= 0, "Insufficient balance");
        require(value >= balances);
        balances[msg.sender] -= value;
        balances[msg.sender].transfer(value);
}

/// @dev Send money from one address(sender) to another (receiver) by emitting the `Send event`
/// @return Documents the return variables of a contract’s function state variable

    function transfer(address account_to uint256) public returns (bool success) {
        require(balanceOf[msg.sender]) >= _value;
        balanceOf[msg.sender] -= value;
        balanceOf[_to] += value; 
        emit Transfer(msg.sender, _to, value);
        return true;
    }

/// @notice Explain to an end user what this does
/// @dev Tracks the address from which the tokens have been sent from. For example track the transfer event from addr A to B
/// @param Documents a parameter just like in doxygen (must be followed by parameter name)
/// @return 


    function TransferFrom( address account_from, address account_to, uint256 value) public returns (bool success){
        require(value <= balanceOf[_from];)
        require(value <= allowance[_from][msg.sender]);
        balanceOf[_from] -= value;
        balanceOf[_to] += value;
        allowance[_from][msg.sender] -= value;
        emit Transfer(_from, _to, value); 
        return true;
    } 


/// @notice Converts the balance of the UGX owner into a token that can be sent as an ERC20 token... 
/// @dev Takes the balance that is possessed by the owner and returns tokens that can be sent over the network
/// @return Balance in form of tokens that can be transmitted across the network.

function covert(address sender, uint amount,  uint balances) public {
    require(amount > 0);
    balances[msg.sender] = tokens;
    emit Convert(msg.sender, tokens);
}
}
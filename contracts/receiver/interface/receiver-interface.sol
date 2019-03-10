pragma solidity ^0.4.24;
/*import "./implementation/basic-token.sol";*/
/*import "./implementation/mintable-token.sol";*/
/*@title Receiver contract Abstract Class
 *@dev this is an abstract class that is the building block of any contract that is supposed to recieve ERC223 token
 */
interface receiverInterface {

    function tokenFallback(address sender,address receiver, uint256 value, bytes memory data) public returns(bool);
    function tokenFallback(address sender, uint256 value, bytes memory data) public returns(bool);
    function whitelist(address tokenAddress) public returns(bool) ;
    function blacklist(address tokenAddress) public returns(bool);

}

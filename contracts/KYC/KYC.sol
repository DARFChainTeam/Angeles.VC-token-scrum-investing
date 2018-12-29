pragma solidity ^0.4.18;
import "./interface/KYC_interface.sol";
import "./implementation/Basic_KYC.sol";
import "../tokens/token.sol";
import "../Modifiers.sol";


contract KYC {

    //==============================================================================
    //Modification and access right------------------------------------------------





    function add_KYC(address investor_KYC, int KYC_level) public OnlyAdmin(msg.sender) {
        _investors[investor_KYC].KYC_level = KYC_level;
    }


}

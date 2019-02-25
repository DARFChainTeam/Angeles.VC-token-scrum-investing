pragma solidity ^0.5.0;

//import "./ANGToken.sol";



contract AngelContract {
// DECLARATION OF EVENTS ======================= start =========================

// DECLARATION OF VARIABLES ==================== start =========================
address public owner;
address public token_address;
// DECLARATION OF STRUCT ======================= start =========================

    constructor(address _token_address) public {
        owner = msg.sender;
        token_address = _token_address;
    }


}

pragma solidity ^0.4.18;
import "./interface/admin-interface.sol";
import "./implementation/basic-admin.sol";
import "../tokens/token.sol";
import "./libraries/Modifiers.sol";

  contract admin {

      uint ANG_tokens_rate = 1 ETH;
      address public token_address;
      address public owner;
      uint ANG_percent = 5;
      address public beneficiar;
      address public KYC_address;
      uint public discount_word;
      uint discount_size;


      constructor(address _token_address) public {
        owner = msg.sender;
        beneficiar = msg.sender;
        token_address = _token_address;
      }
//setting of valuees-----------------------------------------------------------


      struct Admin {
        bool active;
      }

      mapping (address => Admin) public _admins;
    //==============================================================================




    function setAdmin(address _admin_address, bool _admin_state) OnlyOwner(msg.sender) {
      _admins[_admin_address].active = _admin_state;
    }


    function change_conditions( uint new_ANG_tokens_rate,
                            uint new_ANG_percent,
                            address  new_KYC_address,
                            address  new_token_address,
                            address new_beneficiar,
                            address  new_owner ) public OnlyOwner(msg.sender) {

        if (new_ANG_tokens_rate > 0 ) ANG_tokens_rate = new_ANG_tokens_rate;
        if (new_ANG_percent > 0 ) ANG_percent = new_ANG_percent;
        if (new_KYC_address > 0) KYC_address = new_KYC_address;
        if (new_token_address > 0) token_address = new_token_address;
        if (new_owner > 0) owner = new_owner;
        if (new_beneficiar > 0) beneficiar = new_beneficiar;

        }




    function change_discount (uint new_discount_word, uint new_discount)  OnlyOwner(msg.sender) {
          if (new_discount_word > 0) discount_word = new_discount_word;
          if (new_discount > 0) discount_size =  new_discount;
      }

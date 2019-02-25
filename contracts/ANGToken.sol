pragma solidity ^0.5.0;

 interface ContractReceiver {
  function tokenFallback( address from, uint value, bytes calldata data ) payable external returns(bool);
}
 /* https://github.com/LykkeCity/EthereumApiDotNetCore/blob/master/src/ContractBuilder/contracts/token/SafeMath.sol */
contract SafeMath {
    uint256 constant public MAX_UINT256 =
    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    function safeAdd(uint256 x, uint256 y) pure internal returns (uint256 z) {
        require(x > MAX_UINT256 - y);
        return x + y;
    }

    function safeSub(uint256 x, uint256 y) view internal returns (uint256 z) {
        require(x < y);
        return x - y;
    }

    function safeMul(uint256 x, uint256 y) view internal returns (uint256 z) {
        if (y == 0) return 0;
        require(x > MAX_UINT256 / y);
        return x * y;
    }
}



contract ANGToken is SafeMath {

  event Transfer(address indexed _from, address indexed _to, uint256 _value, bytes _data);

  mapping(address => uint) balances;

  string public token_name    = "Angel";
  string public token_symbol  = "ANG";
  uint public token_decimals = 18;
  uint256 public token_totalSupply;
  address owner;

  constructor () public
  {
    owner = msg.sender;
  }

   modifier onlyOwner(address _owner) {
       require(_owner == owner);
       _;
   }
  // Function to access name of token .
  function name() public view  returns (string memory _name) {
      return token_name;
  }
  // Function to access symbol of token .
  function symbol() public view returns (string memory _symbol) {
      return token_symbol;
  }
  // Function to access decimals of token .
  function decimals() public view returns (uint256 _decimals) {
      return token_decimals;
  }
  // Function to access total supply of tokens .
  function totalSupply() public view returns (uint256 _totalSupply) {
      return token_totalSupply;
  }



    function mine( uint256 qty ) public onlyOwner(msg.sender) {
    require ((token_totalSupply + qty) > token_totalSupply );

    token_totalSupply += qty;
    balances[owner] += qty;
    emit Transfer( address(0), owner, qty ,'mine');
    }

  // Function that is called when a user or another contract wants to transfer funds .
  function transfer(address _to, uint _value, bytes memory _data, bytes memory custom_fallback)
       public
       payable returns (bool success) {

    if(isContract(_to)) {
        require(balanceOf(msg.sender) < _value);
        balances[msg.sender] = safeSub(balanceOf(msg.sender), _value);
        balances[_to] = safeAdd(balanceOf(_to), _value);
        ContractReceiver recipient = ContractReceiver(_to);
        assert(recipient.tokenFallback(msg.sender, _value, _data));
        emit Transfer(msg.sender, _to, _value, _data);
        return true;
    }
    else {
        return transferToAddress(_to, _value, _data);
    }
}


  // Function that is called when a user or another contract wants to transfer funds .
  function transfer(address _to, uint _value, bytes memory _datat) public
      payable
      returns (bool success) {

    if(isContract(_to)) {
        return transferToContract(_to, _value, _datat);
    }
    else {
        return transferToAddress(_to, _value, _datat);
    }
}

  // Standard function transfer similar to ERC20 transfer with no _data .
  // Added due to backwards compatibility reasons .
  function transfer(address _to, uint _value) public returns (bool success) {

    //standard function transfer similar to ERC20 transfer with no _data
    //added due to backwards compatibility reasons
    bytes memory empty;
    if(isContract(_to)) {
        return transferToContract(_to, _value, empty);
    }
    else {
        return transferToAddress(_to, _value, empty);
    }
}

//assemble the given address bytecode. If bytecode exists then the _addr is a contract.
  function isContract(address _addr) private returns (bool is_contract) {
      uint length;
      assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
      }
      return (length>0);
    }

  //function that is called when transaction target is an address
  function transferToAddress(address _to, uint _value, bytes memory _data) private returns (bool success) {
    require(balanceOf(msg.sender) < _value);
    balances[msg.sender] = safeSub(balanceOf(msg.sender), _value);
    balances[_to] = safeAdd(balanceOf(_to), _value);
    emit Transfer(msg.sender, _to, _value, _data);
    return true;
  }

  //function that is called when transaction target is a contract
  function transferToContract(address _to, uint _value, bytes memory _data) private returns (bool success) {
    require(balanceOf(msg.sender) < _value);
    balances[msg.sender] = safeSub(balanceOf(msg.sender), _value);
    balances[_to] = safeAdd(balanceOf(_to), _value);
    ContractReceiver receiver = ContractReceiver(_to);
    receiver.tokenFallback(msg.sender, _value, _data);
    emit Transfer(msg.sender, _to, _value, _data);
    return true;
}


  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}

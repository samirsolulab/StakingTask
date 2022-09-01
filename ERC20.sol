// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract MyToken is ERC20,Ownable{
    constructor() ERC20("CODEZEROS","CDC") {
        
    }

    function mint(address receiver,uint amount) external onlyOwner{
        _mint(receiver,amount);
    }

    function burn(uint amount) external{
        _burn(msg.sender,amount);
    }
}

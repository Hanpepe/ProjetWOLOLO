// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract WOLOLO is ERC20, Pausable, Ownable, ERC20Permit {
    
    mapping (address=>bool) whitelist;

    constructor() ERC20("WOLOLO", "WOL") ERC20Permit("WOLOLO") {
        _mint(address(this), 1000000 * 10 ** decimals());
        whitelist[msg.sender] = true;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function whitelistAddress (address addr) public onlyOwner {
        whitelist[addr] = true;
    } 
   
    function claimToken(address recipient, uint256 amount) external {
        require(whitelist[recipient]);
        transferFrom(address(this), recipient, amount);
    }
}

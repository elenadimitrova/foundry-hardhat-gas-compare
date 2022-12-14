// SPDX-License-Identifier: UNLINCENCEDs
pragma solidity ^0.8.15;

import "./MintImplementation.sol";

contract MintModule {

  function mint(address minter, uint256 quantity) external {
    // External call to MintImplementation (using a minimal proxy)
    MintImplementation(minter).mint(quantity);
  }
}

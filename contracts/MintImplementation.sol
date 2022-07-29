// SPDX-License-Identifier: UNLINCENCEDs
pragma solidity ^0.8.15;

import "./BaseMint.sol";

contract MintImplementation is BaseMint {

  function mint(uint256 quantity) external {
      return _mint(quantity);
  }
}

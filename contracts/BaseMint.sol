// SPDX-License-Identifier: UNLINCENCEDs
pragma solidity ^0.8.15;

abstract contract BaseMint {

  uint256 public totalQuantity;

  function _mint(uint256 quantity) internal {
      totalQuantity += quantity;
  }
}

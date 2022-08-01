// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.15;

import "../contracts/MinimalProxyFactory.sol";
import "../contracts/MintImplementation.sol";
import "../contracts/MintModule.sol";
import "../contracts/RouterProxy.sol";
import "../contracts/IMinter.sol";
import "forge-std/Test.sol";

contract Proxies_test is Test {

    function testMintUsingMinimalProxyAndModule() public {
      MinimalProxyFactory minimalProxyFactory = new MinimalProxyFactory();
      MintImplementation minterImplementation = new MintImplementation();

      address proxyAddress = minimalProxyFactory.create(address(minterImplementation));

      // Check the total quantity is 0 before unit test
      uint256 totalQuantity = IMinter(proxyAddress).totalQuantity();
      assertEq(totalQuantity, 0);

      MintModule minterModule = new MintModule();
      minterModule.mint(proxyAddress, 1);

      totalQuantity = IMinter(proxyAddress).totalQuantity();
      assertEq(totalQuantity, 1);
    }

    function testMintUsingRouterProxyAndImplementation() public {
      MintImplementation minterImplementation = new MintImplementation();
      RouterProxy routerProxy = new RouterProxy(address(minterImplementation));

      // Check the total quantity is 0 before unit test
      uint256 totalQuantity = IMinter(address(routerProxy)).totalQuantity();
      assertEq(totalQuantity, 0);

      MintImplementation minter = MintImplementation(address(routerProxy));
      minter.mint(1);

      totalQuantity = IMinter(address(routerProxy)).totalQuantity();
      assertEq(totalQuantity, 1);
    }
}
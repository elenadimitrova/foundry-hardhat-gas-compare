// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.15;

import "../contracts/MinimalProxyFactory.sol";
import "../contracts/MintImplementation.sol";
import "../contracts/MintModule.sol";
import "../contracts/RouterProxy.sol";

contract Proxies_test {

    function testMintUsingMinimalProxyAndModule() public {
      MinimalProxyFactory minimalProxyFactory = new MinimalProxyFactory();
      MintImplementation minterImplementation = new MintImplementation();

      address proxyAddress = minimalProxyFactory.create(address(minterImplementation));

      MintModule minterModule = new MintModule();
      minterModule.mint(proxyAddress, 1);
    }

    function testMintUsingRouterProxyAndImplementation() public {
      MintImplementation minterImplementation = new MintImplementation();
      RouterProxy routerProxy = new RouterProxy(address(minterImplementation));

      MintImplementation minter = MintImplementation(address(routerProxy));
      minter.mint(1);
    }
}
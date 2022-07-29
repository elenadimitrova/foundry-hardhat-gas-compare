// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

contract RouterProxy {
    address public immutable implementation;

    mapping (bytes4 => address) public pointers;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function _delegate(address _implementation) internal {
        assembly {
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    function _fallback() internal virtual {
        if (pointers[msg.sig] != address(0)) {
            _delegate(pointers[msg.sig]);
        } else {
            _delegate(implementation);
        }
    }

    fallback() external payable virtual {
        _fallback();
    }

    receive() external payable virtual {
        _fallback();
    }
}
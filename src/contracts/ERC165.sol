// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';

contract ERC165 is IERC165 {

    // hash table to keep track of contract fingerprint data of data of byte function conversations
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor(){
        _registerInterface(bytes4(keccak256('supportInterface(bytes4)')));
    }

    function supportsInterface(bytes4 interfaceId) external override view returns (bool){
        return _supportedInterfaces[interfaceId]; 
    }

    // registering the intyerface(comes from within)
    function _registerInterface(bytes4 interfaceId) public {
        require(interfaceId != 0xffffffff, 'ERC165: invalid interface');
         _supportedInterfaces[interfaceId] = true;
    }
}
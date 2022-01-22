// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {

    // Array to store our NFT's
    string[] public kryptoBirdz;

    // Chekcs if ID already exists
    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public {

        require(!_kryptoBirdzExists[_kryptoBird], 'Error - KryptoBird already exists');

       // uint256 _id = KryptoBirdz.push(_kryptoBird); => deprecated function .push()
       // .push no longer returns the length but a reference to the added element
       
        kryptoBirdz.push(_kryptoBird);
        uint256 _id = kryptoBirdz.length - 1;
        _mint(msg.sender, _id);
        _kryptoBirdzExists[_kryptoBird] = true;
    }

    constructor() ERC721Connector('Bhanu Kandregula', 'Bhanu Symbol') {

    }
}


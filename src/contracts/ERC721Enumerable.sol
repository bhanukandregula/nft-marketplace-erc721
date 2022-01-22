// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {
    // Places to keep the value if all tokens count
    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint => uint) private _allTokensIndex;

    // mapping of owner to list of all owner tokens ids
    mapping(address => uint[]) private _ownedTokens; 

    // mapping from token Id to index of the owner tokens list
    mapping(uint => uint) private _ownedTokensIndex;

    // return sthe total supply of the allTokens array
    function totalSupply() public view returns(uint256) {
        return _allTokens.length;
    }

    // This mint function will overide the another mint function in ERC721.sol 
    function _mint(address to, uint256 tokenId) internal override(ERC721)  {
        // super - key word will aloow us to grand the mint function fron ERC721.sol file 
        super._mint(to, tokenId);
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEmumeration(to, tokenId);
    }

    // a. add tokens to our total supply - to allTokens array, and set the position of the token indexes
    function _addTokensToAllTokenEnumeration(uint tokenId) private {
        // This will give us back the index where token ins stored in allTokens list
        _allTokensIndex[tokenId] = _allTokens.length; 
        // This will push the recent added token to an _allTokens array 
        _allTokens.push(tokenId);
    }  

    // b. what are all the tokens does specific owner consists of
    function _addTokensToOwnerEmumeration(address to, uint tokenId) private {
        // a. add address and tokenId to the ownedTokens
        _ownedTokens[to].push(tokenId);
        // b. ownedTokensIndex tokenId set to address of ownedTokens position
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
    }

    // a. one that returns tokenByIndex
    function tokenByIndex(uint index) public view returns (uint){
        // make sure that the index is not out of bounds of total supply
        require(index < totalSupply(), 'Global index is out of bounds');
        return _allTokens[index];
    }

    // b. another on ethat returns tokenOfOwnerByIndex
    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint) {
        require(index < balanceOf(owner), 'owner index is out of bounds');
        return _ownedTokens[owner][index];
    }

    
    
}
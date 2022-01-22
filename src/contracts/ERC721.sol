// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// BUILDING OUT MINTING FUNCTION
// a. NFT to point to an address
// b. keep track of the token ids
// c. keep track of owner addresses to token  ids 
// d. keep track of how many addresses each owner has
// e. create an event that emits transfer log - contract address where it is being minted to and its id

contract ERC721 {

    // Mapping in solodity creates a table, with key value pairs
    // Mapping token ID to the owner
    mapping(uint256 => address) private _tokenOwner;

    // Mapping from owner to number of owner tokens
    mapping(address => uint256) private _ownedTokensCount;

    function _exists(uint256 tokenId) internal view returns(bool){
        // setting the address of the NFT owner to check the mapping of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        // return truthiness the address is not zero
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal {
        // requires that the address isn't zero
        require(to != address(0), 'ERC721: minting to the zero address'); // address(0) is address of nobody
        // requires that the token does not already exists
        require(!_exists(tokenId), 'ERC721: token already minted');
        // we are adding a new address with a token id for minting
        _tokenOwner[tokenId] = to;
        // we are increasing the numbers to tokens owner owned (or)
        // keeping track of each address that is minting and adding one
        _ownedTokensCount[to] = _ownedTokensCount[to] + 1;

        emit Transfer(address(0), to, tokenId);
    }

    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    // count all the NFT's owner has in his account
    function balanceOf(address _owner) public view returns(uint256){
         // requires that the address isn't zero
        require(_owner != address(0), 'ERC721: Alert - This owner has zero address');
        // returns the total number of tokens specific owner has
        return _ownedTokensCount[_owner];
    }

    // Find the owner of an NFT
    function ownerOf(uint256 _tokenId) public view returns(address){
        address _owner = _tokenOwner[_tokenId];
        // requires that the address isn't zero
        require(_owner != address(0), 'ERC721: Alert - This owner has zero address');
        // This returns the owner address of whom the token belongs
        return _owner;
    }

    constructor(){

    }
}
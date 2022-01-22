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

    function _mint(address to, uint256 tokenId) internal virtual {
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

     // mapping from token id to approved addresses
    mapping(uint => address) private _tokenApprovals;

    // transferFunction
    function _transferFrom(address _from, address _to, uint _tokenId) internal {
        // d. require that the address receiving the token is not a zero address
        require(_to != address(0), 'ERC721: TRANSFER TO THE ZERO ADDRESS');
        // e. require the address transferring the token actually owns the token
        require(ownerOf(_tokenId) == _from, 'Trying to transfer the token address does not own');
        // b. update the balance of the address _from token
        _ownedTokensCount[_from] = _ownedTokensCount[_from] - 1;
        // c. update the balance of the address _to
        _ownedTokensCount[_to] = _ownedTokensCount[_to] + 1;
        // a. add the token id to the address receiving the token
        _tokenOwner[_tokenId] = _to;
        
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint _tokenId) public {
        // there is additional function shas to be writtne to approve, but for now; its just owner
        // we can get the additional notes from openzepplin library
        // node_modules/openzepplin/token/ERC721/
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _to, uint _tokenId) public {
        // a. require the person approving is the owner
        // b. approve an address to a token (tokenId)
        // c. require that we can't approve sending tokens to owner to the owner
        // d. update the map of the approval addresses

        address owner = ownerOf(_tokenId);
        require(_to != owner, 'Erroor: approvalk to current owner');
        require(msg.sender == owner, 'Current caller is not the owner');
        _tokenApprovals[_tokenId] = _to; 

        emit Approval(owner, _to, _tokenId);
    }

    function isApprovedOrOwner(address spender, uint _tokenId) internal view returns(bool){
        require(_exists(_tokenId), 'Token does not exists');
        address owner = ownerOf(_tokenId);
        return(spender == owner);
    }

    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    event Approval(
        address indexed owner,
        address indexed approved,
        uint indexed tokenId
    );

    constructor(){

    }
}
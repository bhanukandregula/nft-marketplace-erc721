pragma solidity >=0.7.0 < 0.9.0;

interface IERC165 {
    // this interface contains only unimplemented functions
    // should only one function inside interface for 165
    // this function allows other contracts checks data fingerprints
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    // function balanceOf(address _owner) external view returns (uint);
}

contract ERC165 is IERC165 {

    // write a caliculation interface function algo
    function calcFingerPrint() public view returns(bytes4) {
        // we are caliculating the above function signature into bytes here
        // XOR operator is here 
        return bytes4(keccak256("supportsInterface(bytes4)") ^ keccak256("balanceOf(bytes4)"));

        // byte value: 0x01ffc9a7 = interface ID
    }

    // function balanceOf(address _owner) external override view returns (uint){
    //     return 5;
    // }

    // hash table to keep track of contract fingerprint data of data of byte function conversations
    mapping(bytes4 => bool) private _supportedInterfaces;
    function supportsInterface(bytes4 interfaceId) external override view returns (bool){
        return _supportedInterfaces[interfaceId]; 
    }

    constructor(){
        _registerInterface(0x8b81fe23);
    }

    // registering the intyerface(comes from within)
    function _registerInterface(bytes4 interfaceId) public {
        require(interfaceId != 0xffffffff, 'ERC165: invalid interface');
         _supportedInterfaces[interfaceId] = true;
    }
}
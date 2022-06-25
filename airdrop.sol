//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

// airdroping the whitelisted people with nfts

contract Airdrop is ERC721{
    address public owner;
    mapping(address => bool) members; // whitelisted members
    uint public noOfMembers;
    uint public count;// count 
    uint public count2;
    mapping(address => bool) checking; // activity of who claimed

    constructor(uint _noOfMembers) ERC721("non fungible","NFT"){
        owner=msg.sender; // deployer is the owner
        noOfMembers=_noOfMembers;
        for(uint i=0;i<noOfMembers;i++){    //minting the nfts based on the noOfMembers
            _mint(owner,i);
        }
    }

    //to whitlelist the members
    function whiteList()public {
        require(msg.sender != owner);
        require(!members[msg.sender],"aleardy a member");
        require(count < noOfMembers);
        members[msg.sender]=true;
        count+=1;
    }

    //airdroping the whitelisted members with nfts
    
    //function to distribute the NFTs to the whitelisted members
    //transfering the nfts to the claimed people
    function ClaimNFT() public {
        require(owner!=msg.sender);
        require(!checking[msg.sender],"aleardy clamied");
        _transfer(owner,msg.sender,count2);
        checking[msg.sender]=true;
        count2+=1;
    }


}
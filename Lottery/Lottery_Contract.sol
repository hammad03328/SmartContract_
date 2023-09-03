// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8 <0.9;
contract lotery {

    address public manager;
    address[] public participants;

    constructor()
    {
        manager=msg.sender;   //store vallet address of manager
    }

    receive() external payable
    {
        require(msg.value==1 ether);
        participants.push(msg.sender);  // store wallet address of participants
    }

    function managerCoin() view public returns(uint)
    {
        require(msg.sender==manager);
       return address(this).balance;
    } 

    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.timestamp)));
    }

    function transferCoin() public returns(address)
    {
        require(msg.sender==manager);
        require(participants.length>=3);
        uint a=random()%participants.length;
        address payable winner=payable(participants[a]);
        winner.transfer(managerCoin());
        participants=new address payable[](0); 
        return winner;

    }

}
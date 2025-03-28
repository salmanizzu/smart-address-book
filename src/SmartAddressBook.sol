// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SmartAddressBook {
    error SmartAddressBook__NotOwner();

    uint256 number;
    address public owner;

    event MemberAdded(address indexed user, string name, uint256 favoriteNumber);

    constructor() {
        owner = msg.sender;
    }

    struct Member {
        string name;
        uint256 favoriteNumber;
    }

    Member[] public memberList;

    mapping(address => Member) public addressToMember;

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert SmartAddressBook__NotOwner();
        }
        _;
    }

    function addPerson(string memory _name, uint256 _favNum) public {
        require(bytes(_name).length > 0, "Name Required!");
        Member memory newMember = Member(_name, _favNum);
        memberList.push(newMember);
        addressToMember[msg.sender] = newMember;
        emit MemberAdded(msg.sender, _name, _favNum);
    }

    function updateName(string memory _name) public onlyOwner {
        addressToMember[msg.sender].name = _name;
    }

    function updateFavoriteNumber(uint256 _favNum) public onlyOwner {
        addressToMember[msg.sender].favoriteNumber = _favNum;
    }

    function getMyFavoriteNumber() external view returns (uint256) {
        return addressToMember[msg.sender].favoriteNumber;
    }
}

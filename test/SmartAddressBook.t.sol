// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {SmartAddressBook} from "../src/SmartAddressBook.sol";

contract SmartAddressBookTest is Test {
    SmartAddressBook smartAddressBook;
    address user = address(1);

    function setUp() public {
        smartAddressBook = new SmartAddressBook();
    }

    function testAddPersonStoresCorrectData(string memory _name, uint256 _favNum) public {
        vm.prank(user);
        smartAddressBook.addPerson(_name, _favNum);

        // Use fully qualified struct name and memory keyword
        (string memory name, uint256 favoriteNumber) = smartAddressBook.addressToMember(user);

        assertEq(name, _name);
        assertEq(favoriteNumber, _favNum);
    }
}

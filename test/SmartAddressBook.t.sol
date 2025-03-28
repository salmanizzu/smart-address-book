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
        vm.assume(bytes(_name).length > 0);
        vm.prank(user);
        smartAddressBook.addPerson(_name, _favNum);

        // Use fully qualified struct name and memory keyword
        (string memory name, uint256 favoriteNumber) = smartAddressBook.addressToMember(user);

        assertEq(name, _name);
        assertEq(favoriteNumber, _favNum);
    }

    function testOnlyOwnerCanUpdateName(string memory _name) public {
        vm.assume(bytes(_name).length > 0);
        vm.prank(user);
        smartAddressBook.addPerson("user", 0);

        vm.expectRevert(SmartAddressBook.SmartAddressBook__NotOwner.selector);
        vm.prank(address(2));
        smartAddressBook.updateName(_name);

        (string memory name,) = smartAddressBook.addressToMember(user);
        assertEq(name, "user");
    }

    function testOnlyOwnerCanUpdateFavoriteNumber(uint256 _favNum) public {
        vm.prank(user);
        smartAddressBook.addPerson("user", 0);

        vm.expectRevert(SmartAddressBook.SmartAddressBook__NotOwner.selector);
        vm.prank(address(2));
        smartAddressBook.updateFavoriteNumber(_favNum);

        (, uint256 favoriteNumber) = smartAddressBook.addressToMember(user);
        assertEq(favoriteNumber, 0);
    }

    function testAddPersonEmitsCorrectEvent(string memory _name, uint256 _favNum) public {
        vm.assume(bytes(_name).length > 0);
        vm.prank(user);
        vm.expectEmit();
        emit SmartAddressBook.MemberAdded(user, _name, _favNum);
        smartAddressBook.addPerson(_name, _favNum);
    }

    function testAddPersonWithEmptyNameFails() public {
        vm.expectRevert();
        vm.prank(user);
        smartAddressBook.addPerson("", 46);
    }

    function testAddPersonWithLargeNumber() public {
        uint256 largeNumber = type(uint256).max;
        vm.prank(user);
        smartAddressBook.addPerson("Large", largeNumber);
        (, uint256 number) = smartAddressBook.addressToMember(user);

        assertEq(largeNumber, number);
    }
}

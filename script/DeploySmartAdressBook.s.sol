// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {SmartAddressBook} from "../src/SmartAddressBook.sol";

contract DeploySmartAdressBook is Script {
    function run() external returns (SmartAddressBook) {
        vm.startBroadcast();
        SmartAddressBook smartAdressBook = new SmartAddressBook();
        vm.stopBroadcast();
        return smartAdressBook;
    }
}

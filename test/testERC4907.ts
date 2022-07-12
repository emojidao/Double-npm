import { expect } from "chai";
import { ethers } from "hardhat";

describe("Test ERC4907", function () {
    let alice, bob, carl;
    let contract;

    beforeEach(async function () {
        [alice, bob, carl] = await ethers.getSigners();

        const ERC4907Demo = await ethers.getContractFactory("ERC4907Demo");

        contract = await ERC4907Demo.deploy("49907", "4907");
    });

    describe("", function () {
        it("Should set user to bob", async function () {
            await contract.mint(1, alice.address);
            let expires = Math.floor(new Date().getTime() / 1000) + 1000;
            await contract.setUser(1, bob.address, BigInt(expires));
            expect(await contract.userOf(1)).equals(bob.address);
            expect(await contract.ownerOf(1)).equals(alice.address);
        });

        it("Should set user to carl", async function () {
            await contract.mint(1, alice.address);
            let expires = Math.floor(new Date().getTime() / 1000) + 1000;
            await contract.setUser(1, bob.address, BigInt(expires));
            await contract.setUser(1, carl.address, BigInt(expires));
            expect(await contract.userOf(1)).equals(carl.address);
            expect(await contract.ownerOf(1)).equals(alice.address);
        });

    });


});
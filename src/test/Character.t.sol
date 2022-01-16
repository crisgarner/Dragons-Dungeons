// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../Character.sol";
import "../races/Human.sol";
import "../classes/Barbarian.sol";

contract CharacterTest is DSTest {
    Character character;
    Human human = new Human(address(this));
    Barbarian barbarian = new Barbarian(address(this));
    address monster = address(0x1);

    function setUp() public {
        character = new Character("Character", "D&D", monster);
    }

    function testParams() public {
        assertEq(character.name(), "Character");
        assertEq(character.symbol(), "D&D");
        assertEq(character.monsterContract(), monster);
    }

    function testCreate() public {
        assertEq(character.lastId(), 0);
        character.create(
            "QmcoHdzc6E8aYCUM8Q3KEvHycgEHqEzpwJyXwnHU9ShzFv",
            address(human),
            address(barbarian)
        );

        assertEq(character.balanceOf(address(this)), 1);
        assertEq(character.ownerOf(0), address(this));
        assertEq(character.lastId(), 1);
        assertEq(character.characterExp(0), 0);

        character.create("Qma2FRWoD8AgvrFTVQyPgsrUvJxe2VFV5sdb7T4NCcAj9d", address(human), address(barbarian));

        assertEq(character.balanceOf(address(this)), 2);
        assertEq(character.ownerOf(1), address(this));
        assertEq(character.lastId(), 2);
        assertEq(character.characterExp(1), 0);

        // Checks values
        // Race should be it's own contract and add bonuses,
        // Class should be a contract
    }
    //
    //    function testSetAbilities() public {
    //        character.setAbilities(1, 15, 14, 13, 12, 10, 8);
    //        // Check values
    //    }
}

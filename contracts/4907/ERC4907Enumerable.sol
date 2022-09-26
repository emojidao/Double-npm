// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC4907.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract ERC4907Enumerable is ERC4907 {
    using EnumerableSet for EnumerableSet.UintSet;

    mapping(address => EnumerableSet.UintSet) _tokensOfUser;

    mapping(address => EnumerableSet.UintSet) _tokensOfOwner;

    constructor(string memory name_, string memory symbol_)
        ERC4907(name_, symbol_)
    {}

    function setUser(
        uint256 tokenId,
        address user,
        uint64 expires
    ) public virtual override {
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        address from = _users[tokenId].user;
        if (from != address(0)) {
            _tokensOfUser[from].remove(tokenId);
        }
        if (user != address(0) && expires > block.timestamp) {
            _tokensOfUser[user].add(tokenId);
        }
        UserInfo storage info = _users[tokenId];
        info.user = user;
        info.expires = expires;
        emit UpdateUser(tokenId, user, expires);
    }

    function tokensOfUser(address user) public view returns (uint256[] memory) {
        require(
            user != address(0),
            "ERC721: tokensOfUser query for the zero address"
        );
        return _tokensOfUser[user].values();
    }

    function tokensOfUser2(
        address user,
        uint256 startIndex,
        uint256 endIndex
    ) public view returns (uint256[] memory result) {
        require(
            user != address(0),
            "ERC721: tokensOfUser query for the zero address"
        );
        uint256 length = _tokensOfUser[user].length();
        if (endIndex == 0 || endIndex >= length) {
            endIndex = length - 1;
        }
        require(startIndex <= endIndex, "Error:startIndex > endIndex");
        uint256 i;
        result = new uint256[](endIndex - startIndex + 1);
        for (uint256 index = startIndex; index <= endIndex; index++) {
            result[i] = _tokensOfUser[user].at(index);
            i++;
        }
    }

    function balanceOfUsedBy(address user) public view returns (uint256) {
        require(
            user != address(0),
            "ERC721: balanceOfUsedBy query for the zero address"
        );
        return _tokensOfUser[user].length();
    }

    function tokensOfOwner(address owner)
        public
        view
        returns (uint256[] memory)
    {
        require(
            owner != address(0),
            "ERC721: tokensOfUser query for the zero address"
        );
        return _tokensOfOwner[owner].values();
    }

    function tokensOfOwner2(
        address owner,
        uint256 startIndex,
        uint256 endIndex
    ) public view returns (uint256[] memory result) {
        require(
            owner != address(0),
            "ERC721: tokensOfUser query for the zero address"
        );
        uint256 length = _tokensOfOwner[owner].length();
        if (endIndex == 0 || endIndex >= length) {
            endIndex = length - 1;
        }
        require(startIndex <= endIndex, "Error:startIndex > endIndex");
        uint256 i;
        result = new uint256[](endIndex - startIndex + 1);
        for (uint256 index = startIndex; index <= endIndex; index++) {
            result[i] = _tokensOfOwner[owner].at(index);
            i++;
        }
    }

    function balanceOfOwnedBy(address owner) public view returns (uint256) {
        require(
            owner != address(0),
            "ERC721: balanceOfOwnedBy query for the zero address"
        );
        return _tokensOfOwner[owner].length();
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        ERC721._beforeTokenTransfer(from, to, tokenId);
        if (from != to) {
            if (from != address(0)) {
                _tokensOfOwner[from].remove(tokenId);
            }
            if (to != address(0)) {
                _tokensOfOwner[to].add(tokenId);
            }
            if (to != _users[tokenId].user) {
                _tokensOfUser[_users[tokenId].user].remove(tokenId);
                _users[tokenId].user = address(0);
                _users[tokenId].expires = 0;
                emit UpdateUser(tokenId, address(0), 0);
            }
        }
    }
}

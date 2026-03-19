// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SoulboundRegistry
 * @dev A non-transferable NFT contract for digital identity.
 */
contract SoulboundRegistry is ERC721, Ownable {
    uint256 private _nextTokenId;

    event Attested(address indexed to, uint256 indexed tokenId);
    event Revoked(address indexed from, uint256 indexed tokenId);

    constructor(string memory name, string memory symbol) 
        ERC721(name, symbol) 
        Ownable(msg.sender) 
    {}

    /**
     * @dev Mints a Soulbound Token to a specific address.
     * Only the owner (issuer) can call this.
     */
    function issue(address to) external onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        emit Attested(to, tokenId);
        return tokenId;
    }

    /**
     * @dev Revokes a token. Useful for expired credentials.
     */
    function revoke(uint256 tokenId) external onlyOwner {
        _burn(tokenId);
        emit Revoked(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Overriding transfer functions to make the token Soulbound.
     * Reverts on any attempt to transfer.
     */
    function _update(address to, uint256 tokenId, address auth) 
        internal 
        override 
        returns (address) 
    {
        address from = _ownerOf(tokenId);
        
        // Allow minting (from == address(0)) and burning (to == address(0))
        // Revert on any actual transfer between wallets
        if (from != address(0) && to != address(0)) {
            revert("SoulboundToken: Transfer is prohibited");
        }

        return super._update(to, tokenId, auth);
    }

    /**
     * @dev Disable approvals to prevent marketplace listings.
     */
    function approve(address, uint256) public virtual override {
        revert("SoulboundToken: Approvals are prohibited");
    }

    function setApprovalForAll(address, bool) public virtual override {
        revert("SoulboundToken: Approvals are prohibited");
    }
}

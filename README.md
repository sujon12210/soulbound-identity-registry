# Soulbound Identity Registry

Soulbound Tokens (SBTs) are non-transferable NFTs that represent a person's credentials, affiliations, or commitments on the blockchain. This repository provides a secure, expert-level implementation that prevents the `transfer` and `approval` functions of the standard ERC-721 interface.

## Key Features
- **Non-Transferability**: Overridden internal transfer logic to ensure tokens stay in the original minted wallet.
- **Revocable vs. Permanent**: Includes logic for the issuer to revoke credentials if necessary.
- **EIP-5114 Inspired**: Follows modern standards for "Soulbound" properties.

## Use Cases
- University Diplomas & Certifications.
- KYC/AML Verification Badges.
- DAO Voting Power based on reputation.
- Event Attendance Protocols (POAPs) that shouldn't be sold.

## License
MIT

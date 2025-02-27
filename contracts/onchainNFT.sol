// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract onchainNFT is ERC721URIStorage, Ownable {
    uint256 tokenIdCounter;

    constructor() ERC721("DripNFT", "DNFT") Ownable(msg.sender) {}

    function mint(address _to) external onlyOwner {
        tokenIdCounter++;
        uint256 newTokenId = tokenIdCounter;
        _mint(_to, newTokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public pure override returns (string memory) {
        string
            memory svg = "<svg xmlns='http://www.w3.org/2000/svg' width='500' height='500'>"
            "<rect width='500' height='500' fill='linear-gradient(135deg, #ff9a9e, #fad0c4)'/>"
            "<text x='50%' y='50%' font-family='Arial' font-size='48' fill='white' font-weight='bold' text-anchor='middle' alignment-baseline='middle'>DripNFT</text>"
            "</svg>";

        string memory imageURI = string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(bytes(svg))
            )
        );

        string memory json = string(
            abi.encodePacked(
                '{"name": "DripNFT #',
                Strings.toString(tokenId),
                '", "description": "Let us drip, one love", "image": "',
                imageURI,
                '", "attributes": [{"trait_type": "Style", "value": "Neon"}, {"trait_type": "Background", "value": "Black"}]}'
            )
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(bytes(json))
                )
            );
    }
}

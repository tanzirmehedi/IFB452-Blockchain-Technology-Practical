// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FoodSupplyChain {
    // The contract owner's address
    address public owner;
    
    // Struct to define the structure of a product
    struct Product {
        string productName;  // Name of the product
        address producer;    // Address of the producer
        string origin;       // Origin or source of the product
        uint256 timestamp;   // Timestamp of when the product was created
    }  

    // Mapping to store product information based on product ID
    mapping (uint256 => Product) public products;
    
    // Counter to keep track of the total number of products
    uint256 public productCount;

    // Event triggered when a new product is created
    event ProductCreated(uint256 productId, string productName, address producer, string origin, uint256 timestamp);

    // Contract constructor, executed once during deployment
    constructor() {
        // Set the contract owner to the address that deploys the contract
        owner = msg.sender;
    }

    // Modifier to restrict access to only the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }

    // Function to create a new product
    function createProduct(string memory _productName, string memory _origin) public onlyOwner {
        // Increment productCount to generate a unique product ID
        productCount++;
        
        // Create a new product and store it in the products mapping
        products[productCount] = Product(_productName, msg.sender, _origin, block.timestamp);
        
        // Emit an event to signify the creation of a new product
        emit ProductCreated(productCount, _productName, msg.sender, _origin, block.timestamp);
    }

    // Function to get details of a specific product based on its ID
    function getProductDetails(uint256 _productId) public view returns (string memory, address, string memory, uint256) {
        // Check if the provided product ID is valid
        require(_productId > 0 && _productId <= productCount, "Invalid product ID");
        
        // Retrieve and return the details of the specified product
        Product storage product = products[_productId];
        return (product.productName, product.producer, product.origin, product.timestamp);
    }
}

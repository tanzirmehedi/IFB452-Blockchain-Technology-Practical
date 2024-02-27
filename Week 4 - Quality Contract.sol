// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {
    // The contract owner's address
    address public owner;
    
    // Struct to define the structure of a quality contract
    struct QualityContractData {
        string contractName;       // Name of the quality contract
        address[] stakeholders;    // Array to store stakeholders' addresses
        string qualityCriteria;    // Criteria for quality
        bool isCompleted;          // Flag to indicate if the quality contract is completed
    }  

    // Mapping to store quality contract information based on contract ID
    mapping (uint256 => QualityContractData) public qualityContracts;
    
    // Counter to keep track of the total number of quality contracts
    uint256 public contractCount;

    // Event triggered when a new quality contract is created
    event QualityContractCreated(uint256 contractId, string contractName, address[] stakeholders, string qualityCriteria);

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

    // Function to create a new quality contract
    function createQualityContract(string memory _contractName, address[] memory _stakeholders, string memory _qualityCriteria) public onlyOwner {
        // Increment contractCount to generate a unique contract ID
        contractCount++;
        
        // Create a new quality contract and store it in the qualityContracts mapping
        qualityContracts[contractCount] = QualityContractData(_contractName, _stakeholders, _qualityCriteria, false);
        
        // Emit an event to signify the creation of a new quality contract
        emit QualityContractCreated(contractCount, _contractName, _stakeholders, _qualityCriteria);
    }

    // Function to mark a quality contract as completed
    function completeQualityContract(uint256 _contractId) public onlyOwner {
        // Check if the provided contract ID is valid
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        
        // Mark the quality contract as completed
        qualityContracts[_contractId].isCompleted = true;
    }

    // Function to get details of a specific quality contract based on its ID
    function getQualityContractDetails(uint256 _contractId) public view returns (string memory, address[] memory, string memory, bool) {
        // Check if the provided contract ID is valid
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        
        // Retrieve and return the details of the specified quality contract
        QualityContractData storage contractData = qualityContracts[_contractId];
        return (contractData.contractName, contractData.stakeholders, contractData.qualityCriteria, contractData.isCompleted);
    }

    // Function for stakeholders to perform quality check
    function performQualityCheck(uint256 _contractId) public {
        // Check if the provided contract ID is valid
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");

        // Check if the caller is one of the stakeholders
        bool isStakeholder = false;
        for (uint i = 0; i < qualityContracts[_contractId].stakeholders.length; i++) {
            if (qualityContracts[_contractId].stakeholders[i] == msg.sender) {
                isStakeholder = true;
                break;
            }
        }
        require(isStakeholder, "Only stakeholders can perform quality check");

        // Perform quality check logic (replace with actual quality check logic)
        // For demonstration purposes, we just set the contract as completed
        qualityContracts[_contractId].isCompleted = true;
    }    
}

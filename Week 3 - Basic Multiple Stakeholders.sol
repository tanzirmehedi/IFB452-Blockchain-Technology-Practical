// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {
    mapping(address => bool) public stakeholders;
    uint256 public qualityScore;

    modifier onlyStakeholder() {
        require(stakeholders[msg.sender], "Only stakeholder can execute this");
        _;
    }

    constructor(address[] memory initialStakeholders) {
        for (uint256 i = 0; i < initialStakeholders.length; i++) {
            stakeholders[initialStakeholders[i]] = true;
        }
        qualityScore = 0;
    }

    function updateQualityScore(uint256 newScore) external onlyStakeholder {
        qualityScore = newScore;
    }

    function addStakeholder(address newStakeholder) external onlyStakeholder {
        stakeholders[newStakeholder] = true;
    }
}

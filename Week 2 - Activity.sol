// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {

    address public singleStakeholder;
    uint256 public qualityScore;


    modifier onlyStakeholder() {
        require(msg.sender == singleStakeholder, "Only stakeholder can execute this");
        _;
    }
    event QualityScoreUpdated(uint256 newScore);

    constructor() {
        singleStakeholder = msg.sender;
        qualityScore = 0;
    }

    function updateQualityScore(uint256 newScore) external onlyStakeholder {
        qualityScore = newScore;
        emit QualityScoreUpdated(newScore);
    }
}

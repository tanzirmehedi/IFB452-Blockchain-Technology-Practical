// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExamScoreContract {
    address public singleStudent;
    uint256 public examScore;

    modifier onlyStudent() {
        require(msg.sender == singleStudent, "Only student can execute this");
        _;
    }

    event ExamScoreUpdated(uint256 newScore);

    constructor(address initialStudent) {
        require(initialStudent != address(0), "Invalid initial student address");
        singleStudent = initialStudent;
        examScore = 0;
    }

    function updateScore(uint256 newScore) external onlyStudent {
        examScore = newScore;
        emit ExamScoreUpdated(newScore);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
contract stake {
    struct stakerData{
        address stakerAdd;
        address tokenAdd;
        uint when;
        uint amount;
        uint reward;
    }
    event stakeID(uint stakeid);
    event userReward(uint reward);
    stakerData [] public stakes;
    
    function stakeTokens(address token, uint amount) external {
        stakerData memory newStaker;
        newStaker.stakerAdd = msg.sender;
        newStaker.when = block.timestamp;
        newStaker.amount = amount;
        newStaker.tokenAdd = token;
        stakes.push(newStaker);
        IERC20(token).transferFrom(msg.sender,address(this),amount);
        emit stakeID(stakes.length - 1);
    }

    function unstakeTokens(uint id) external {
        stakerData storage Staker = stakes[id];
        require(msg.sender == Staker.stakerAdd,"Not a staker");
        uint reward = calculate(Staker.amount,Staker.when);
        Staker.reward = reward;

        IERC20(Staker.tokenAdd).transfer(msg.sender,Staker.amount);

        emit userReward(reward);
    }

    function calculate(uint amount,uint date) private view returns(uint reward){
        uint timepasses = block.timestamp - date;
        if (timepasses >= 365 days){
            return amount * 15 / 100;
        }
        if (timepasses >= 182 days){
            return amount * 10 / 100;
        }
        if (timepasses >= 30 days){
            return amount * 5 / 100;
        }
    }

}

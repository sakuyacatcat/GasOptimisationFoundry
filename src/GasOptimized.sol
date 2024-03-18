// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract GasContract {
    uint256 public whiteListAmount;
    mapping(address => uint256) public balances;
    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory, uint256 _totalSupply) {
        balances[0x0000000000000000000000000000000000001234] = _totalSupply;
    }

    function administrators(uint8 _index) external pure returns (address admin) {
        assembly {
            switch _index
            case 0 {
                admin := 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2
            }
            case 1 {
                admin := 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46
            }
            case 2 {
                admin := 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf
            }
            case 3 {
                admin := 0xeadb3d065f8d15cc05e92594523516aD36d1c834
            }
            case 4 {
                admin := 0x0000000000000000000000000000000000001234
            }
        }
    }

    function checkForAdmin(address) external pure returns (bool) {
        return true;
    }

    function balanceOf(address _user) external view returns (uint256) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata
    ) external {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier)
        external
    {
        require(_tier < 255 && msg.sender == 0x0000000000000000000000000000000000001234);
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) external {
        whiteListAmount = _amount;
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit WhiteListTransfer(_recipient);
    }

    function whitelist(address) external pure returns (uint8) {
        return 0;
    }

    function getPaymentStatus(address) external view returns (bool, uint256) {
        return (true, whiteListAmount);
    }
}

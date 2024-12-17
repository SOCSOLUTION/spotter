// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

error waitForSale();
error roundSupplyLimitExceed();
error pleaseSendTokenPrice();
error invalidUSDTPrice();
error claimNotAllowed();
error alReadyClaimed();
error minimumAndMaximumLimit();

contract SixenseUpgradablePreSale is Initializable, OwnableUpgradeable {
    using SafeERC20 for IERC20;

    bool public isSale;
    bool public isClaimAllowed;

    uint256 conversionRate;

    uint256 public salePrice;
    uint256 public raisedAmount;

    IERC20 USDTToken;
    IERC20 PreSaleToken;

    event buyWithEth(address _addr, uint256 _amount);
    event buyWithUSDT(address _addr, uint256 _amount);
    event buyWithCard(address _addr, uint256 _amount);

    event claimHistory(address _addr, uint256 _amount);

    mapping(address => uint256) public buyerTokens;

    function initialize(
        address _owner,
        address _usdt,
        address _saleToken
    ) public initializer {
        __Ownable_init(_owner);
        USDTToken = IERC20(_usdt);
        PreSaleToken = IERC20(_saleToken);
        salePrice = 0.0011 * 10 ** 6;
        conversionRate = 10 ** 12;
    }

    function startTheSale(bool _status) public onlyOwner {
        require(isSale != _status, "status is same");
        isSale = _status;
    }

    function changeSalePrice(uint256 _priceInUSDT) external onlyOwner {
        require(_priceInUSDT > 0, "Price must be greater than Zero");
        salePrice = _priceInUSDT;
    }

    function allowUserToClaim() external onlyOwner {
        isSale = false;
        isClaimAllowed = true;
    }

    function buyWithCreditCard(
        address buyer,
        uint256 _amount,
        uint256 payAmountInUSD
    ) external onlyOwner returns (bool) {
        if (!isSale) {
            revert waitForSale();
        }

        buyerTokens[buyer] += _amount;
        raisedAmount += payAmountInUSD;
        emit buyWithCard(buyer, _amount);
        return true;
    }

    //minting functiion in payable
    function buyWithETH(uint256 _amount) external payable returns (bool) {
        if (!isSale) {
            revert waitForSale();
        }

        if (PreSaleToken.balanceOf(address(this)) < _amount) {
            revert roundSupplyLimitExceed();
        }

        uint256 payAmountInUSD = sellTokenInUDSTPrice(_amount, salePrice);

        uint256 payAmount = sellTokenInETHPrice(_amount, salePrice);
        if (msg.value < payAmount) {
            revert pleaseSendTokenPrice();
        }

        payable(owner()).transfer(msg.value);
        PreSaleToken.safeTransfer(msg.sender, _amount);
        raisedAmount += payAmountInUSD;
        emit buyWithEth(msg.sender, _amount);
        return true;
    }

    function buyWithUSDTToken(uint256 _buyToken) external returns (bool) {
        if (!isSale) {
            revert waitForSale();
        }

        uint256 payAmountInUSD = sellTokenInUDSTPrice(_buyToken, salePrice);

        if (PreSaleToken.balanceOf(address(this)) < _buyToken) {
            revert roundSupplyLimitExceed();
        }

        uint256 payAmount = USDTToken.allowance(msg.sender, address(this));
        if (payAmountInUSD < payAmount) {
            revert pleaseSendTokenPrice();
        }

        USDTToken.safeTransferFrom(msg.sender, owner(), payAmountInUSD);
        PreSaleToken.safeTransfer(msg.sender, _buyToken);
        raisedAmount += payAmountInUSD;
        emit buyWithUSDT(msg.sender, _buyToken);
        return true;
    }

    // This function allows buyers to claim their tokens after the sale ends
    function claimTokens() external returns (bool) {
        if (!isClaimAllowed) {
            revert claimNotAllowed();
        }
        uint256 tokensToClaim = buyerTokens[msg.sender];
        if (tokensToClaim == 0) {
            revert alReadyClaimed();
        }
        require(
            PreSaleToken.balanceOf(address(this)) >= tokensToClaim,
            "Not enough tokens in contract"
        );
        PreSaleToken.safeTransfer(msg.sender, tokensToClaim);
        buyerTokens[msg.sender] = 0;
        emit claimHistory(msg.sender, tokensToClaim);
        return true;
    }

    function getLatestUSDTPrice() public view returns (uint256) {
        //0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46 USDt/ETH Ethereum mainnet
        //0xD5c40f5144848Bd4EF08a9605d860e727b991513 USDt/BNB BNBSmart mainnet
        AggregatorV3Interface USDTPriceFeed = AggregatorV3Interface(
            0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46
        ); // Mainnet contract address for USDT price feed
        (, int256 price, , , ) = USDTPriceFeed.latestRoundData(); // Get the latest USDT price data from Chainlink

        if (price <= 0) {
            // Ensure that the price is valid
            revert invalidUSDTPrice();
        }
        return uint256(price);
    }

    //this function sell token in Ether 18 decimal
    function sellTokenInETHPrice(
        uint256 _amount,
        uint256 _roundPrice
    ) public view returns (uint256) {
        uint256 conversion = _roundPrice * conversionRate;
        uint256 tokensAmountPrice = ((conversion * _amount) / 10 ** 18) /
            10 ** 12;
        uint256 amountinEthers = tokensAmountPrice * conversionRate;
        //if you want to change hardcode the getLatestUSDTPrice()
        uint256 amountInEth = (getLatestUSDTPrice() * amountinEthers) /
            10 ** 18;
        return amountInEth;
    }

    //This function sell token in USDT 6 decimal
    function sellTokenInUDSTPrice(
        uint256 _amount,
        uint256 _roundPrice
    ) public view returns (uint256) {
        uint256 conversion = _roundPrice * conversionRate;
        uint256 tokensAmountPrice = ((conversion * _amount) / 10 ** 18) /
            10 ** 12;
        return tokensAmountPrice;
    }

    //This function with tokens from contract
    function withdrawTokens(uint256 _amount) external onlyOwner returns (bool) {
        PreSaleToken.safeTransfer(owner(), _amount);
        return true;
    }
}

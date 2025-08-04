// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract UnifiedWaterToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    // ====================== CONFIGURACIÓN ======================
    AggregatorV3Interface public priceFeed;
    address public communityFund;
    address public marketingFund;
    address public constant WATER_FUND_WALLET = 0x834DD2BaFEe86f5B197255372a995D2cC3a5c176;
    
    uint256 public lastBurnTimestamp;
    uint256 private constant MAX_HOLDING_PERCENTAGE = 30;
    uint256 private constant TARGET_PROJECT_USD = 80000 * 10**18;
    uint256 private constant INITIAL_SUPPLY = 90_000_000 * 10**18;
    uint256 private constant FEE_DENOMINATOR = 100;

    mapping(address => bool) private frozenAccounts;

    // ====================== EVENTOS ======================
    event TokensFrozen(address indexed account);
    event TokensUnfrozen(address indexed account);
    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(uint256 amount);
    event FundsWithdrawnForWater(uint256 amount);
    event AutoBurnExecuted(uint256 amount);
    event TargetReached(uint256 amount);
    event ContractInitialized(address priceFeed, address communityFund, address marketingFund);

    // ====================== ERRORES ======================
    error ExceedsHoldingLimit();
    error AccountFrozen();
    error InvalidAddress();
    error AlreadyInitialized();

    // ====================== CONSTRUCTOR ======================
    constructor() ERC20("Unified Water Token", "UWT") Ownable(msg.sender) {
        lastBurnTimestamp = block.timestamp;
    }

    // ====================== FUNCIÓN DE INICIALIZACIÓN ======================
    function initialize(
        address _priceFeed,
        address _communityFund,
        address _marketingFund
    ) external onlyOwner {
        if (address(priceFeed) != address(0)) revert AlreadyInitialized();
        if (_communityFund == address(0) || _marketingFund == address(0)) revert InvalidAddress();

        priceFeed = AggregatorV3Interface(_priceFeed);
        communityFund = _communityFund;
        marketingFund = _marketingFund;

        _mint(msg.sender, INITIAL_SUPPLY);
        emit ContractInitialized(_priceFeed, _communityFund, _marketingFund);
    }

    // ====================== FUNCIONES PRINCIPALES ======================
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Pausable) {
        if (frozenAccounts[from]) revert AccountFrozen();
        if (frozenAccounts[to]) revert AccountFrozen();
        
        if (shouldCheckHoldingLimit(to)) {
            checkHoldingLimit(to, amount);
        }

        _autoBurn();
        
        if (shouldApplyFees(from)) {
            amount = applyFees(from, amount);
        }
        
        super._update(from, to, amount);
        _checkFundingThreshold();
    }

    // ====================== FUNCIONES INTERNAS CORREGIDAS ======================
    function shouldCheckHoldingLimit(address to) internal view returns (bool) {
        return to != address(0) && to != WATER_FUND_WALLET && to != address(this);
    }

    function checkHoldingLimit(address to, uint256 amount) internal view {
        uint256 maxHolding = (totalSupply() * MAX_HOLDING_PERCENTAGE) / FEE_DENOMINATOR;
        if (balanceOf(to) + amount > maxHolding) revert ExceedsHoldingLimit();
    }

    function shouldApplyFees(address from) internal view returns (bool) {
        return from != owner() && from != address(this) && from != WATER_FUND_WALLET;
    }

    function applyFees(address from, uint256 amount) internal returns (uint256) {
        uint256 feeAmount = (amount * 4) / FEE_DENOMINATOR;
        
        _transfer(from, communityFund, feeAmount / 4);
        _transfer(from, address(this), feeAmount / 4);
        _transfer(from, marketingFund, feeAmount / 4);
        _burn(from, feeAmount / 4);
        
        return amount - feeAmount;
    }

    function _autoBurn() internal {
        uint256 burnInterval = 90 days;
        if (block.timestamp >= lastBurnTimestamp + burnInterval) {
            uint256 burnAmount = (totalSupply() * 2) / FEE_DENOMINATOR;
            
            if (balanceOf(address(this)) >= burnAmount) {
                lastBurnTimestamp = block.timestamp;
                _burn(address(this), burnAmount);
                emit AutoBurnExecuted(burnAmount);
            }
        }
    }

    function _checkFundingThreshold() internal {
        uint256 contractBalance = balanceOf(address(this));
        if (contractBalance == 0) return;
        
        uint256 currentValueInUSD = _getTokenValueInUSD(contractBalance);
        if (currentValueInUSD >= TARGET_PROJECT_USD) {
            _transfer(address(this), WATER_FUND_WALLET, contractBalance);
            emit TargetReached(contractBalance);
            emit FundsWithdrawnForWater(contractBalance);
        }
    }

    function _getTokenValueInUSD(uint256 tokenAmount) internal view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        uint8 priceDecimals = priceFeed.decimals();
        uint256 adjustedPrice = uint256(price) * (10 ** (18 - priceDecimals));
        return (tokenAmount * adjustedPrice) / 1e18;
    }

    // ====================== FUNCIONES DEL OWNER ======================
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function freezeAccount(address account) external onlyOwner {
        frozenAccounts[account] = true;
        emit TokensFrozen(account);
    }

    function unfreezeAccount(address account) external onlyOwner {
        frozenAccounts[account] = false;
        emit TokensUnfrozen(account);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    // ====================== COMPATIBILIDAD BEP-20 ======================
    function getOwner() external view returns (address) {
        return owner();
    }
}

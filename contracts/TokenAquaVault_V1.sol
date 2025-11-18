// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AQUAVAULT {
    string public name = "AQUAVAULT";
    string public symbol = "WRTN";
    uint8 public decimals = 18;
    uint256 public totalSupply = 100_000_000 * 10**uint256(decimals);
    address public owner;
    address public reserveWallet;
    uint256 public maxWalletLimit;
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowed;

    uint256 public constant FEE_PERCENT = 2;

    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el owner puede ejecutar esto");
        _;
    }

    constructor(address _reserveWallet) {
        owner = msg.sender;
        reserveWallet = _reserveWallet;
        maxWalletLimit = (totalSupply * 30) / 100;
        balances[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function allowance(address _owner, address spender) public view returns (uint256) {
        return allowed[_owner][spender];
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(allowed[from][msg.sender] >= value, "No autorizado");
        allowed[from][msg.sender] -= value;
        _transfer(from, to, value);
        return true;
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(to != address(0), "Direccion invalida");
        require(balances[from] >= value, "Fondos insuficientes");

        uint256 fee = (value * FEE_PERCENT) / 100;
        uint256 amountAfterFee = value - fee;

        balances[from] -= value;
        balances[to] += amountAfterFee;
        balances[reserveWallet] += fee;

        if (to != owner) {
            require(balances[to] <= maxWalletLimit, "Supera el limite permitido por wallet");
        }

        emit Transfer(from, to, amountAfterFee);
        emit Transfer(from, reserveWallet, fee);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Direccion invalida");
        totalSupply += amount;
        balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    function burn(uint256 amount) public onlyOwner {
        require(balances[msg.sender] >= amount, "Fondos insuficientes");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Direccion invalida");
        owner = newOwner;
    }

    function updateReserveWallet(address newWallet) public onlyOwner {
        require(newWallet != address(0), "Direccion invalida");
        reserveWallet = newWallet;
    }
}

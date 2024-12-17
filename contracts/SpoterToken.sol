// SPDX-License-Identifier: MIT
// File: @openzeppelin/contracts/interfaces/draft-IERC6093.sol

// OpenZeppelin Contracts (last updated v5.0.0) (interfaces/draft-IERC6093.sol)
pragma solidity ^0.8.20;

/**
 * @dev Standard ERC20 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC20 tokens.
 */
interface IERC20Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientBalance(
        address sender,
        uint256 balance,
        uint256 needed
    );

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC20InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `spender`’s `allowance`. Used in transfers.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     * @param allowance Amount of tokens a `spender` is allowed to operate with.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientAllowance(
        address spender,
        uint256 allowance,
        uint256 needed
    );

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC20InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `spender` to be approved. Used in approvals.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC20InvalidSpender(address spender);
}

/**
 * @dev Standard ERC721 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC721 tokens.
 */
interface IERC721Errors {
    /**
     * @dev Indicates that an address can't be an owner. For example, `address(0)` is a forbidden owner in EIP-20.
     * Used in balance queries.
     * @param owner Address of the current owner of a token.
     */
    error ERC721InvalidOwner(address owner);

    /**
     * @dev Indicates a `tokenId` whose `owner` is the zero address.
     * @param tokenId Identifier number of a token.
     */
    error ERC721NonexistentToken(uint256 tokenId);

    /**
     * @dev Indicates an error related to the ownership over a particular token. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param tokenId Identifier number of a token.
     * @param owner Address of the current owner of a token.
     */
    error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC721InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC721InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param tokenId Identifier number of a token.
     */
    error ERC721InsufficientApproval(address operator, uint256 tokenId);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC721InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC721InvalidOperator(address operator);
}

/**
 * @dev Standard ERC1155 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC1155 tokens.
 */
interface IERC1155Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     * @param tokenId Identifier number of a token.
     */
    error ERC1155InsufficientBalance(
        address sender,
        uint256 balance,
        uint256 needed,
        uint256 tokenId
    );

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC1155InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC1155InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param owner Address of the current owner of a token.
     */
    error ERC1155MissingApprovalForAll(address operator, address owner);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC1155InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC1155InvalidOperator(address operator);

    /**
     * @dev Indicates an array length mismatch between ids and values in a safeBatchTransferFrom operation.
     * Used in batch transfers.
     * @param idsLength Length of the array of token identifiers
     * @param valuesLength Length of the array of token amounts
     */
    error ERC1155InvalidArrayLength(uint256 idsLength, uint256 valuesLength);
}

// File: @openzeppelin/contracts/utils/Context.sol

// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)

pragma solidity ^0.8.20;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * The initial owner is set to the address provided by the deployer. This can
 * later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    error OwnableUnauthorizedAccount(address account);

    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    error OwnableInvalidOwner(address owner);

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol

// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 */
abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address account => uint256) private _balances;

    mapping(address account => mapping(address spender => uint256))
        private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `value`.
     */
    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(
        address owner,
        address spender
    ) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(
        address spender,
        uint256 value
    ) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `value`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `value`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

    /**
     * @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
     * (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
     * this function.
     *
     * Emits a {Transfer} event.
     */
    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            // Overflow check required: The rest of the code assumes that totalSupply never overflows
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                // Overflow not possible: value <= fromBalance <= totalSupply.
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
                _totalSupply -= value;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    /**
     * @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    /**
     * @dev Sets `value` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     *
     * Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    /**
     * @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
     *
     * By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
     * `_spendAllowance` during the `transferFrom` operation set the flag to false. This saves gas by not emitting any
     * `Approval` event during `transferFrom` operations.
     *
     * Anyone who wishes to continue emitting `Approval` events on the`transferFrom` operation can force the flag to
     * true using the following override:
     * ```
     * function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
     *     super._approve(owner, spender, value, true);
     * }
     * ```
     *
     * Requirements are the same as {_approve}.
     */
    function _approve(
        address owner,
        address spender,
        uint256 value,
        bool emitEvent
    ) internal virtual {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `value`.
     *
     * Does not update the allowance value in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Does not emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 value
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(
                    spender,
                    currentAllowance,
                    value
                );
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}

// File: contracts/NarrowToken.sol

pragma solidity ^0.8.20;

interface IUniswapV2Factory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

interface IUniswapV2Router02 {
    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

/// @dev Indicates a transfer operation failed
error TransferFailed();

/// @dev Indicates an invalid amount was provided
/// @param _amount The invalid amount that triggered the error
error AmountNotValid(uint256 _amount);

/// @dev Indicates that there are insufficient funds for the operation
error InsufficientFunds();

/// @dev Indicates that trading is not enabled yet
error TradingNotEnabledYet();

contract SpotterToken is ERC20, Ownable {
    /// @notice Address of the Uniswap V2 Router
    address public constant UNISWAP_V2_ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D; //Ethereum Mainnet

    /// @notice Address of the Wrapped Ether (WETH) token
    address private constant WETH_ADDRESS =
        0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2; //Ethereum Mainnet

    /// @dev Internal reference to the Uniswap V2 Factory contract
    IUniswapV2Factory private _helperFactory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f); //Ethereum Mainnet

    /// @dev Internal reference to the Uniswap V2 Router contract
    IUniswapV2Router02 private _helperRouter =
        IUniswapV2Router02(UNISWAP_V2_ROUTER);

    /// @dev Address of the admin wallet, used for receiving ETH from token swaps
    address private adminWallet;

    /// @dev Address of the stake holder, used for receiving claim token
    address private owner2;

    /// @dev Address of the stake holder, used for receiving claim token
    address private owner3;

    /// @dev Boolean to check whether the trading is enabled or not
    bool private tradingEnabled;

    /// @dev Base number used for tax calculations
    uint256 private constant BASE = 1000;

    /// @dev Tax rate for buy transactions
    uint256 private buyTax;

    /// @dev Tax rate for sell transactions
    uint256 private sellTax;

    /// @notice swapThreshold for automatic token swap
    uint256 public swapThreshold;

    /// @dev Total supply of token
    uint256 private constant INITIAL_SUPPLY = 10_000_000 ether;

    /// @dev Lock Timestamp for tokens
    uint256 public unlockTimestamp;

    /// @dev Mapping to keep track of addresses that are excluded from fees
    mapping(address => bool) private _isExcludedFromFees;

    /// @dev Mapping to keep track of addresses that are excluded from trading restrictions
    mapping(address => bool) private _isExcludedFromTrading;

    /// @dev Mapping to keep track of addresses that are claimed locked tokens
    mapping(address => bool) private _isClaimedToken;

    /// @notice Event emitted when the sell fee is changed
    /// @param oldFee The previous sell fee
    /// @param newFee The updated sell fee
    event SellFeeChanged(uint256 indexed oldFee, uint256 indexed newFee);

    /// @notice Event emitted when the buy fee is changed
    /// @param oldFee The previous buy fee
    /// @param newFee The updated buy fee
    event BuyFeeChanged(uint256 indexed oldFee, uint256 indexed newFee);

    /// @notice Event emitted when the maximum transaction amount is changed
    /// @param oldAmount The previous maximum transaction amount
    /// @param newAmount The updated maximum transaction amount
    event MaxTxAmountChanged(
        uint256 indexed oldAmount,
        uint256 indexed newAmount
    );

    /// @notice Event emitted when the token are lock in contract
    /// @param owner The owner wallet address
    /// @param amount The amount that store
    event TokensLocked(address indexed owner, uint256 indexed amount);

    /// @notice Event emitted when the admin wallet address is changed
    /// @param oldWallet The previous admin wallet address
    /// @param newWallet The updated admin wallet address
    event AdminWalletChanged(
        address indexed oldWallet,
        address indexed newWallet
    );

    receive() external payable {}

    modifier isExcludeTrading(address _addr) {
        require(
            tradingEnabled || _isExcludedFromTrading[_addr],
            "Trading not enabled"
        );
        _;
    }

    /// @notice Contract constructor
    /// @param _name Name of the ERC20 token
    /// @param _symbol Symbol of the ERC20 token
    /// @param _buyTax Buy tax rate
    /// @param _sellTax Sell tax rate
    /// @param _adminWallet Address of the admin wallet
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _buyTax,
        uint256 _sellTax,
        address _adminWallet,
        address _owner2,
        address _owner3
    ) ERC20(_name, _symbol) Ownable(_msgSender()) {
        _helperFactory.createPair(address(this), WETH_ADDRESS);
        _isExcludedFromFees[_msgSender()] = true;
        _isExcludedFromFees[address(0)] = true;
        _isExcludedFromFees[_adminWallet] = true;
        _isExcludedFromFees[address(this)] = true;
        _isExcludedFromFees[_owner2] = true;
        _isExcludedFromFees[_owner3] = true;
        _isExcludedFromTrading[address(this)] = true;
        _isExcludedFromTrading[address(0)] = true;
        _isExcludedFromTrading[_adminWallet] = true;
        _isExcludedFromTrading[_msgSender()] = true;
        _isExcludedFromTrading[UNISWAP_V2_ROUTER] = true;
        uint256 LOCKED_SUPPLY = (INITIAL_SUPPLY * 15) / 100;
        _mint(msg.sender, INITIAL_SUPPLY);
        _transfer(msg.sender, address(this), LOCKED_SUPPLY);
        unlockTimestamp = block.timestamp + 180 days;
        adminWallet = _adminWallet;
        owner2 = _owner2;
        owner3 = _owner3;
        buyTax = _buyTax;
        sellTax = _sellTax;
        swapThreshold = ((INITIAL_SUPPLY * 1) / 100); // 1% swapThreshold
        emit TokensLocked(_adminWallet, LOCKED_SUPPLY / 3);
        emit TokensLocked(owner2, LOCKED_SUPPLY / 3);
        emit TokensLocked(owner3, LOCKED_SUPPLY / 3);
    }

    /// @dev external function to allow owners to withdraw tokens
    function withdrawLockedTokens() external {
        require(block.timestamp >= unlockTimestamp, "Tokens are still locked");

        require(_isClaimedToken[msg.sender] == false, "Already Claimed Tokens");

        uint256 ownerAllocation = (INITIAL_SUPPLY * 15) / 100;

        _isClaimedToken[msg.sender] = true;

        if (msg.sender == owner()) {
            _transfer(address(this), owner(), ownerAllocation);
        } else if (msg.sender == owner2) {
            _transfer(address(this), owner2, ownerAllocation);
        } else if (msg.sender == owner3) {
            _transfer(address(this), owner3, ownerAllocation);
        } else {
            revert("Caller is not an owner");
        }
    }

    /// @notice Add liquidity to Uniswap pool
    /// @param _tokenAmt Amount of tokens to add to the pool
    /// @custom:modifier onlyOwner Restricts the function access to the contract owner.
    function addLiquidity(uint256 _tokenAmt) external payable onlyOwner {
        if (_tokenAmt == 0) revert AmountNotValid(_tokenAmt);
        if (_tokenAmt > balanceOf(_msgSender())) revert InsufficientFunds();
        if (allowance(address(this), UNISWAP_V2_ROUTER) == 0)
            IERC20(address(this)).approve(UNISWAP_V2_ROUTER, type(uint256).max);

        IERC20(address(this)).transferFrom(
            _msgSender(),
            address(this),
            _tokenAmt
        );

        uint256 amountGiven = msg.value;
        (, uint256 amountETH, ) = _helperRouter.addLiquidityETH{
            value: amountGiven
        }(address(this), _tokenAmt, 0, 0, _msgSender(), block.timestamp);
        uint256 remainingAmount = amountGiven - amountETH;
        if (remainingAmount > 0) {
            (bool success, ) = _msgSender().call{value: remainingAmount}("");
            if (!success) revert TransferFailed();
        }
    }

    /// @dev Internal function to calculate the amount of tokens to be transferred after tax
    /// @param _user The address of the user involved in the transfer
    /// @param _amount The amount of tokens to be transferred
    /// @param _taxPercentage The tax percentage to be applied
    /// @return transferedAmount The amount of tokens to be transferred after applying tax
    function _getTransferedTokenAmount(
        address _user,
        uint256 _amount,
        uint256 _taxPercentage
    ) internal view returns (uint256 transferedAmount) {
        return
            !_isExcludedFromFees[_user]
                ? _amount - _calFee(_amount, _taxPercentage)
                : _amount;
    }

    /// @dev Internal function to calculate the fee based on an amount and a percentage
    /// @param amount The amount on which the fee is to be calculated
    /// @param percentage The fee percentage
    /// @return The calculated fee amount
    function _calFee(
        uint256 amount,
        uint256 percentage
    ) internal pure returns (uint256) {
        require(amount >= 1000, "amount cant be less than 1000");
        return (amount * percentage) / 1000;
    }

    /// @dev Overrides the ERC20 _update function to include tax logic
    /// @param from Address sending the tokens
    /// @param to Address receiving the tokens
    /// @param value Amount of tokens being transferred
    function _update(
        address from,
        address to,
        uint256 value
    ) internal override isExcludeTrading(from) {
        if (!tradingEnabled && !_isExcludedFromFees[from])
            revert TradingNotEnabledYet();

        address pairAddr = _helperFactory.getPair(address(this), WETH_ADDRESS);

        uint256 taxAmount;

        if (to == pairAddr && !_isExcludedFromFees[from]) {
            taxAmount = (value * sellTax) / BASE;
            value = value - taxAmount;
        } else if (from == pairAddr && !_isExcludedFromFees[to]) {
            taxAmount = (value * buyTax) / BASE;
            value = value - taxAmount;
        }

        if (taxAmount > 0) {
            super._update(from, address(this), taxAmount);
            uint256 balance = IERC20(address(this)).balanceOf(address(this));
            if (to == pairAddr && balance >= swapThreshold) _swapTokensForETH();
        }

        super._update(from, to, value);
    }

    /// @dev Internal function to swap tokens for ETH
    function _swapTokensForETH() private {
        if (allowance(address(this), UNISWAP_V2_ROUTER) == 0)
            IERC20(address(this)).approve(UNISWAP_V2_ROUTER, type(uint256).max);
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = WETH_ADDRESS;
        uint256 amount = balanceOf(address(this));
        _helperRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount,
            0,
            path,
            adminWallet,
            block.timestamp
        );
    }

    /// @notice Change the sell tax fee
    /// @dev Emits the SellFeeChanged event
    /// @param _newFee The new sell tax fee
    /// @custom:modifier onlyOwner Restricts the function access to the contract owner.
    function changeSellFee(uint256 _newFee) external onlyOwner {
        require(_newFee <= 250, "Invalid Fee");
        emit SellFeeChanged(sellTax, _newFee);
        sellTax = _newFee;
    }

    /// @notice Change the buy tax fee
    /// @dev Emits the BuyFeeChanged event
    /// @param _newFee The new buy tax fee
    /// @custom:modifier onlyOwner Restricts the function access to the contract owner.
    function changeBuyFee(uint256 _newFee) external onlyOwner {
        require(_newFee <= 250, "Invalid Fee");
        emit BuyFeeChanged(buyTax, _newFee);
        buyTax = _newFee;
    }

    /// @notice Change the admin wallet address
    /// @dev Emits the AdminWalletChanged event
    /// @param _adminWallet The new admin wallet address to be set
    /// @custom:modifier onlyOwner Restricts the function access to the contract owner.
    function changeAdminWallet(address _adminWallet) external onlyOwner {
        require(_adminWallet != address(0), "Invalid Amount");
        emit AdminWalletChanged(adminWallet, _adminWallet);
        adminWallet = _adminWallet;
    }

    /// @notice Enable the trading of the token
    /// @custom:modifier onlyOwner Restricts the function access to the contract owner.
    function enableTrading() external onlyOwner {
        require(!tradingEnabled, "Trading enabled");
        tradingEnabled = true;
    }

    /// @notice set the user to be exclude from transaction fees
    /// @param _userAddr The address of the user to set
    /// @param _action A boolean for the user to set (True means exclude address from the tax, and False is the vise versa)
    /// @custom:modifier onlyOwner Restricts the function access to the contract owner.
    function updateExcludedFromFees(
        address _userAddr,
        bool _action
    ) external onlyOwner {
        require(_isExcludedFromFees[_userAddr] != _action, "In the same state");
        _isExcludedFromFees[_userAddr] = _action;
    }

    /// @notice set the user to be exclude from Presale
    /// @param _userAddr The address of the user to set
    /// @param _action A boolean for the user to set (True means exclude address from the Presale, and False is the vise versa)
    /// @custom:modifier onlyOwner Restricts the function access to the contract owner.
    function updateExcludePresaleAddress(
        address _userAddr,
        bool _action
    ) external onlyOwner {
        require(
            _isExcludedFromTrading[_userAddr] != _action,
            "In the same state"
        );
        _isExcludedFromTrading[_userAddr] = _action;
        _isExcludedFromFees[_userAddr] = _action;
    }

    /// @notice Retrieve the current sell tax rate
    /// @return The current sell tax rate
    function getSellTax() external view returns (uint256) {
        return sellTax;
    }

    /**
     * @notice Retrieves the total supply of the token
     * @return The total supply of the token
     */
    function totalSupply() public pure override returns (uint256) {
        return 10_000_000 ether;
    }

    /// @notice Retrieve the current buy tax rate
    /// @return The current buy tax rate
    function getBuyTax() external view returns (uint256) {
        return buyTax;
    }

    /// @notice Retrieve the current admin wallet
    /// @return The current admin wallet
    function getAdminWallet() external view returns (address) {
        return adminWallet;
    }

    /// @notice Retrieve the status of trading
    /// @return Boolean value that represents current status of trading
    function getTradingStatus() external view returns (bool) {
        return tradingEnabled;
    }

    /// @notice Checks if a user is excluded from transaction fees
    /// @param _addr The address of the user to check
    /// @return A boolean indicating whether the user is excluded from fees
    function isExcludedFromFees(address _addr) external view returns (bool) {
        return _isExcludedFromFees[_addr];
    }

    /// @notice Checks if a user is excluded from transaction Trading
    /// @param _addr The address of the user to check
    /// @return A boolean indicating whether the user is excluded from Trading
    function isExcludedFromTrading(address _addr) external view returns (bool) {
        return _isExcludedFromTrading[_addr];
    }

    /**
     * @notice Transfers all the ETH balance held by the contract to the owner's address
     * @custom:modifier onlyOwner Restricts the function access to the contract owner.
     */
    function swapContingency() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    /**
     * @notice Sweeps the specified external tokens held by the contract to the owner's address
     * @dev Only the contract owner can call this function
     * @param token The address of the external token to be swept
     * @custom:modifier onlyOwner Restricts the function access to the contract owner.
     */
    function swapExternalTokens(address token) external onlyOwner {
        IERC20 TOKEN = IERC20(token);
        TOKEN.transfer(owner(), TOKEN.balanceOf(address(this)));
    }

    /**
     * @dev Sets the swap threshold for automatic token swap
     * @param _tokenAmount The amount of tokens required for triggering the swap
     * @notice When the contract balance reaches or exceeds the swap threshold, it will automatically swap the tokens for ETH
     * @custom:modifier onlyOwner Restricts the function access to the contract owner.
     */
    function setSwapThreshold(uint256 _tokenAmount) external onlyOwner {
        swapThreshold = (_tokenAmount * 10 ** 18);
    }
}

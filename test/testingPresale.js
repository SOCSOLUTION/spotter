// SPDX-License-Identifier: MIT
const { expect } = require("chai");
const { parseUnits, formatEther, formatUnits } = require("ethers");
const { ethers } = require("hardhat");

describe("SpoterPreSaleContract", function () {
  let owner;
  let addr1;
  let addr2;
  let USDTToken;
  let spotterToken;
  let presaleContract;

  const initialUSDTBalance = parseUnits("1000", 6);
  const salePrice = parseUnits("0.0009", 6);

  it("should Deploy All Contracts", async function () {
    [owner, addr1, addr2, owerTwo, owerThree] = await ethers.getSigners();

    // Deploy USDT token (ERC20)
    const USDT = await ethers.getContractFactory("USDTToken");
    USDTToken = await USDT.deploy();
    console.log("USDT Token Token Contract...", USDTToken.target);

    // Deploy spotter Token (ERC20)
    const Token = await ethers.getContractFactory("SpotterToken");
    spotterToken = await Token.deploy(
      "SpotterToken",
      "SPOT",
      "5",
      "5",
      owner.address,
      owerTwo.address,
      owerThree.address
    );
    console.log("spotter Token Contract...", spotterToken.target);

    // Deploy Presale Upgrade (ERC20)
    const SpoterUpgradablePreSale = await ethers.getContractFactory(
      "SpoterUpgradablePreSale"
    );

    console.log("Deploying PreSale Contract...");

    presaleContract = await upgrades.deployProxy(
      SpoterUpgradablePreSale,
      [owner.address, USDTToken.target, spotterToken.target],
      { initializer: "initialize" }
    );
    await presaleContract.waitForDeployment();
    console.log(
      "Deploying presale Contract Contract...",
      presaleContract.target
    );

    // Transfer some spotterTokens to the presale contract
    const amountToSell = parseUnits("500000", 18); // 500,000 tokens (18 decimals)
    await spotterToken.transfer(presaleContract.target, amountToSell);
    await spotterToken.enableTrading();
    await spotterToken.updateExcludePresaleAddress(
      presaleContract.target,
      true
    );
    await presaleContract.startTheSale(true);

    // // Setup initial contract state (sale price, min/max limits)
    // await presaleContract.changeSalePrice(salePrice);
    // await presaleContract.changeMinAndMaxBuyLimit("100000000");
    expect(await spotterToken.balanceOf(presaleContract.target)).to.equal(
      amountToSell
    );
  });

  it("should allow a user to buy tokens with ETH", async function () {
    const amountToBuy = parseUnits("1112", 18); // 100 tokens
    console.log(amountToBuy?.toString(), "amountToBuy");
    const priceInETH = await presaleContract.sellTokenInETHPrice(
      amountToBuy,
      salePrice
    );

    const raisedAmountInUSDT = await presaleContract.sellTokenInUDSTPrice(
      amountToBuy,
      salePrice
    );
    // Address 1 sends ETH to purchase tokens
    await presaleContract
      .connect(addr1)
      .buyWithETH(amountToBuy, { value: priceInETH });

    let balancs = await spotterToken.balanceOf(addr1.address);

    console.log(balancs?.toString(), "balanc");
    // expect(await presaleContract.buyerTokens(addr1.address)).to.equal(
    //   amountToBuy
    // );
    // expect(await presaleContract.raisedAmount()).to.equal(raisedAmountInUSDT);
  });

  it("should allow a user to buy tokens with USDT", async function () {
    const amountToBuy = parseUnits("112", 18); // 100 tokens
    const transferToAddr1 = parseUnits("100", 6); // 100 tokens
    await USDTToken.transfer(addr2.address, transferToAddr1);

    expect(await USDTToken.balanceOf(addr2.address)).to.equal(transferToAddr1);

    let lastRaise = await presaleContract.raisedAmount();

    const raisedAmountInUSDT = await presaleContract.sellTokenInUDSTPrice(
      amountToBuy,
      salePrice
    );

    await USDTToken.connect(addr2).approve(
      presaleContract.target,
      raisedAmountInUSDT
    );

    await presaleContract.connect(addr2).buyWithUSDTToken(amountToBuy);
    expect(await presaleContract.buyerTokens(addr2.address)).to.equal(
      amountToBuy
    );

    expect(await presaleContract.raisedAmount()).to.equal(
      lastRaise + raisedAmountInUSDT
    );
  });

  // it("should allow the owner to change the sale price", async function () {
  //   const newPrice = parseUnits("0.2", 6);
  //   await presaleContract.changeSalePrice(newPrice);
  //   expect(await presaleContract.salePrice()).to.equal(newPrice);
  // });

  // it("should allow the owner to change the buy limits", async function () {
  //   const newMaxLimit = parseUnits("200", 6);
  //   await presaleContract.changeMinAndMaxBuyLimit(newMaxLimit);
  //   expect(await presaleContract.maximumBuyLimit()).to.equal(newMaxLimit);
  // });

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////// Failed Test Cases ///////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // it("should failed due to maxBuyLimit ", async function () {
  //   const amountToBuy = parseUnits("20000", 18);

  //   const priceInETH = await presaleContract.sellTokenInETHPrice(
  //     amountToBuy,
  //     salePrice
  //   );

  //   await expect(
  //     presaleContract
  //       .connect(addr1)
  //       .buyWithETH(amountToBuy, { value: priceInETH })
  //   ).to.be.revertedWithCustomError(presaleContract, "minimumAndMaximumLimit");
  // });

  // it("should revert if insufficient ETH is sent", async function () {
  //   const amountToBuy = parseUnits("100", 18); // 100 tokens
  //   const priceInETH = await presaleContract.sellTokenInETHPrice(
  //     amountToBuy,
  //     salePrice
  //   );

  //   await expect(
  //     presaleContract
  //       .connect(addr1)
  //       .buyWithETH(amountToBuy, { value: priceInETH - BigInt(1) }) // Insufficient ETH
  //   ).to.be.revertedWithCustomError(presaleContract, "pleaseSendTokenPrice");
  // });

  // it("should revert if the sale is not active", async function () {
  //   await presaleContract.startTheSale(false); // Deactivate sale

  //   const amountToBuy = parseUnits("100", 18);
  //   const priceInETH = await presaleContract.sellTokenInETHPrice(
  //     amountToBuy,
  //     salePrice
  //   );

  //   await expect(
  //     presaleContract
  //       .connect(addr1)
  //       .buyWithETH(amountToBuy, { value: priceInETH })
  //   ).to.be.revertedWithCustomError(presaleContract, "waitForSale");
  // });

  // it("should allow the owner to withdraw tokens", async function () {
  //   const withdrawAmount = parseUnits("100", 18);
  //   await presaleContract.withdrawTokens(withdrawAmount);
  // });

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////// Claim Tokens Test Cases ///////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // it("should allow the owner to withdraw tokens", async function () {
  //   await presaleContract.allowUserToClaim();
  //   expect(await presaleContract.isClaimAllowed()).to.equal(true);
  // });

  // it("should allow the owner to allow users for claim tokens", async function () {
  //   let buyTokens = await presaleContract.buyerTokens(addr1.address);
  //   await presaleContract.connect(addr1).claimTokens();
  //   // console.log(buyTokens,"buyTokens");
  //   expect(await spotterToken.balanceOf(addr1.address)).to.equal(
  //     "99500000000000000000"
  //   ); //0.5% BuyTax Amount Deduct
  //   expect(await presaleContract.buyerTokens(addr1.address)).to.equal(0);
  // });

  // it("should allow the user1 to claim tokens", async function () {
  //   await presaleContract.connect(addr2).claimTokens();
  //   let buyTokens = await presaleContract.buyerTokens(addr2.address);
  //   expect(await spotterToken.balanceOf(addr2.address)).to.equal(
  //     "99500000000000000000"
  //   );
  //   expect(await presaleContract.buyerTokens(addr2.address)).to.equal(0);
  // });

  // it("should revert the user1 already Claim tokens", async function () {
  //   await expect(
  //     presaleContract.connect(addr1).claimTokens()
  //   ).to.be.revertedWithCustomError(presaleContract, "alReadyClaimed");
  // });
});

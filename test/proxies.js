const { ethers } = require("hardhat");

describe("Proxies", function () {
  it("should be able to mint using the MinimalProxy and Module", async function () {
    const MinimalProxyFactory = await ethers.getContractFactory("MinimalProxyFactory");
    const minimalProxyCreator = await MinimalProxyFactory.deploy();

    const MintImplementationFactory = await ethers.getContractFactory("MintImplementation");
    const minterImplementation = await MintImplementationFactory.deploy();

    const minterCreateTx = await minimalProxyCreator.create(minterImplementation.address);
    const receipt = await minterCreateTx.wait();
    const event = receipt.events?.filter((x) => {return x.event == "MinimalProxyCreated"});
    const proxyAddress = event[0].args.proxy;

    const MintModuleFactory = await ethers.getContractFactory("MintModule");
    const minter = await MintModuleFactory.deploy();

    await minter.mint(proxyAddress, 1);
  });

  it("should be able to mint using the RouterProxy and implementation", async function () {
    const MintImplementationFactory = await ethers.getContractFactory("MintImplementation");
    const minterImplementation = await MintImplementationFactory.deploy();

    const RouterProxyFactory = await ethers.getContractFactory("RouterProxy");
    const routerProxy = await RouterProxyFactory.deploy(minterImplementation.address);

    const minter = MintImplementationFactory.attach(routerProxy.address);
    await minter.mint(1);
  });
});
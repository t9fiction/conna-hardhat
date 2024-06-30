import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const name = 'Token';
const symbol = 'TKN';
const supply: bigint = 10000n;
const address = '0x98586a788f437c678d64704e170CdBDCA2B6B36b';

const MyERC20TokenModule = buildModule("MyERC20TokenModule", (m) => {
  const tokenName = m.getParameter("unlockTime", name);
  const tokenSymbol = m.getParameter("symbol", symbol);
  const tokenSupply = m.getParameter("supply", supply);
  const tokenAddress = m.getParameter("address", address);

  const myToken = m.contract("MyERC20Token", [tokenName, tokenSymbol, tokenSupply, tokenAddress]);

  return { myToken };
});

export default MyERC20TokenModule;

#!/bin/bash

yarn init --yes
yarn add --dev hardhat

yarn add -D hardhat-deploy hardhat-deploy-ethers ethers chai chai-ethers mocha @types/chai @types/mocha @types/node typescript ts-node dotenv

yarn add --dev @openzeppelin/contracts

yarn add --dev solidity-coverage

yarn add --dev hardhat-gas-reporter

echo "import {HardhatUserConfig} from 'hardhat/types';
import 'hardhat-deploy';
import 'hardhat-deploy-ethers';
import 'solidity-coverage';
import 'hardhat-gas-reporter';

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.7',
  },
  namedAccounts: {
    deployer: 0,
  },
  paths: {
    sources: 'src',
  },
};
export default config;" >> hardhat.config.ts

echo '{
  "compilerOptions": {
    "target": "es5",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "moduleResolution": "node",
    "forceConsistentCasingInFileNames": true,
    "outDir": "dist"
  },
  "include": [
    "hardhat.config.ts",
    "./deploy",
    "./test",
    "./scripts",
  ]
}' >> tsconfig.json

mkdir src

mkdir deploy

mkdir test

mkdir scripts

cd test

mkdir utils

mkdir unit

echo 'import chaiModule from "chai";
import { chaiEthers } from "chai-ethers";
chaiModule.use(chaiEthers);
export = chaiModule;' >> chai-setup.ts

cd utils

echo 'import { Contract } from "ethers";
import { ethers } from "hardhat";

export async function setupUsers<
  T extends { [contractName: string]: Contract }
>(addresses: string[], contracts: T): Promise<({ address: string } & T)[]> {
  const users: ({ address: string } & T)[] = [];
  for (const address of addresses) {
    users.push(await setupUser(address, contracts));
  }
  return users;
}

export async function setupUser<T extends { [contractName: string]: Contract }>(
  address: string,
  contracts: T
): Promise<{ address: string } & T> {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const user: any = { address };
  for (const key of Object.keys(contracts)) {
    user[key] = contracts[key].connect(await ethers.getSigner(address));
  }
  return user as { address: string } & T;
}' >> index.ts

cd ..

cd ..

cd deploy

echo 'import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const deployTest: DeployFunction = async function (
  hre: HardhatRuntimeEnvironment
) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();
  await deploy("TestContract", {
    from: deployer,
    args: [],
    log: true,
  });
};
export default deployTest;
deployTest.tags = ["all"];' >> 000_Boilerplate.ts

cd ..

nvim .

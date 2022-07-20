# My Hardhat Script For New Projects

This is the script that I'm using when starting a new project.

This script will install all dependencies needed for a hardhat typescript project using Hardhat-Deploy plugin.

It will also install:

1. OpenZeppelin Contracts

2. Solidity Coverage

3. Hardhat Gas Reporter

## To Test Contracts

This project uses yarn instead of NPM. So write every command with yarn

To Test:

```bash
yarn hardhat test
```

To run some script:

```bash
yarn hardhat run scripts/deploy.ts
```

To run the deploy scripts:

```bash
yarn hardhat deploy
```

To run solidity coverage:

```bash
yarn hardhat coverage
```

## To Run The Script

You can either run the scirpt with bash command like this:

```bash
bash ~/hhProject.sh
```

You need to specify the path to the script in the command for me it's just ~/hhProject.sh

Or you can make the file executable like this:

```bash
chmod +x hhProject.sh
```

And then you can run it like this:

```bash
./hhProject.sh
```

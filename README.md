# <img src="xhj.svg" alt="Double" height="40px">

Published on : 
[GitHub](https://github.com/emojidao/double-npm/tree/master);
[Npm](https://www.npmjs.com/package/double-contracts);
[Docs](https://docs.double.one/concepts/overview);

**A library for secure smart contract development.** Build on a solid foundation of community-vetted code.

 * Implementations of standards like [ERC4907](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-4907.md) and [ERC5006](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-5006.md).

:mage: **Not sure how to get started?** Check out [Docs](https://docs.double.one/concepts/overview).

## Overview

### Installation

```console
$ npm install --save double-contracts
```


### Usage

Once installed, you can use the contracts in the library by importing them:

```solidity
pragma solidity ^0.8.0;

import "double-contracts/contracts/4907/ERC4907.sol";

contract ERC4907Demo is ERC4907 {

    constructor(string memory name_, string memory symbol_)
     ERC4907(name_,symbol_)
     {         
     }
    ...

} 
```

## Learn More

## Security

This project is maintained by [Double](https://Double.one), and developed following our high standards for code quality and security. Double Contracts is meant to provide tested and community-audited code, but please use common sense when doing anything that deals with real money! We take no responsibility for your implementation decisions and any security problems you might experience.

The core development principles and strategies that Double Contracts is based on include: security in depth, simple and modular code, clarity-driven naming conventions, comprehensive unit testing, pre-and-post-condition sanity checks, code consistency, and regular audits.

## Contribute

Double Contracts exists thanks to its contributors. There are many ways you can participate and help build high quality software.

## License

Double Contracts is released under the [MIT License](LICENSE).

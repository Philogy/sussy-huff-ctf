# Jessy's Sussy Huff

Welcome to this CTF challenge. I wrote a pretty efficient but simple on-chain order-book DEX using
Huff. If you're not familiar with Huff, Huff is a low-level EVM language whereby instructions are
written in the "word" mnemonic form, you can find the full list [here](https://evm.codes). Huff adds
some syntatic sugar like jump-labels and macros to improve the devs experience.

**Note:** This code has an explicitly added vulnerability, do not use in production!

## Goal

To solve this CTF you must steal the tokens from the DEX. To do this go to
[`./test/HackHere.t.sol`](test/HackHere.t.sol) and your logic to the `_executeSolution` method.
You'll know you've solved the challenge if the `testSolve` test passes. The vulnerable Huff contract
is [`src/Challenge.huff`](src/Challenge.huff).

## Setup

1. Install the Huff compiler using `curl -L get.huff.sh | bash`
2. Clone this repo using `git clone git@github.com:Philogy/jessys-sussy-huff.git`
3. Pull the dependencies using `git submodule update --init --recursive`
4. Run your exploit using `forge test -vvv --ffi --match-path test/HackHere.t.sol`

## Explanation
The DEX allows people to create orders trading ETH for MOCK tokens. Orders are created with
`addTo{Eth/Token}Order`. Orders are matched using the `matchEthOrder` function whereby the buyer,
seller and the price has to be passed in. The party who receives ETH needs to have sufficient tokens
deposited to fill the order otherwise the function will revert.

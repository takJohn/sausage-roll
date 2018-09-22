# Sausage Roll
_My midterm project for the "Decentralized Applications" course by Siraj Raval._

![screenshot](https://github.com/takJohn/decentralized-auction/blob/master/sausage-roll.png)

## Description

Based on the pig dice game, Sausage Roll is a 2 player game that pits you against players online where you can compete to win each others ethers. *(online element yet to be implemented)*

* Each player deposits 0.01 ether to play the game, the ethers collected forms the prize pool. *(currently uses the first two generated addresses from ganache to play the game)*
* If the player rolls a "one", they score nothing and it becomes the next player's turn.
* If the player rolls any other number, it is added to their turn total and the player's turn continues.
* If a player chooses to "hodl", their turn total is added to their score, and it becomes the next player's turn.
* The first player to score "one hundred" or more points wins the game and the ethers in the prize pool minus a small pecentage that gets added to the monthly prize. *(prize pool yet to be implemented)*
* The player can continue rolling after they've scored over "one hundred" - this will allow them to earn a higher score and a chance to win the monthly "highest score" prize. *(yet to be implemented)*
* Warning: going for the highest score will put the player at a greater risk of losing the game.

### Prerequisites

- Install [Node.js](https://nodejs.org/en/download/)
- Install [ganache](http://truffleframework.com/ganache/)

Issues with multiple events not registering with the browser when using ganache-cli on windows but seems to work fine on mac.

### To start playing
```
- Clone this repository
$ npm install
- Open ganache with the default rpc server address > http://127.0.0.1:7545
- If you're using a different address then remember to change the variable *web3Host* inside index.html
- Open index.html in a web browser. A smart contract will be automactically generated
- Play the game by clicking "Roll" to roll the dice and "Hodl" to hodl onto your current score.
```

## Acknowledgements

Thank you to everyone in the dapps channel on programming-wizards.slack.com

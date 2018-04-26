pragma solidity ^0.4.2;

// Sausage Roll Game based on the Pig Dice Game
contract SausageRoll {

    // Events
    event GameStart(string message);
    event GameEnd(string message, address winner, uint16 winScore);
    event DiceScore(uint16 rolledScore);
    event CurrentScore(uint16 currentScore);
    event HodlScore(uint16 totalScore);
    
    // Variables
    enum State {Waiting, Started, Finished}
    State public state;
    uint16 nonce = 0; // A nonce is used to help with the randomness
    uint16 public winningScore = 100;
    uint16 public currentScore;
    address public activePlayer;
    address[] players;
    mapping (address => uint16) public totalScore;
    
    
    // Checks what state the game is in
    modifier inState(State _state) {
        assert(state == _state);
        _; 
    }
    
    // Checks if the player is the active player
    modifier isActive {
        assert(activePlayer == msg.sender);
        _;
    }
 
    // Joining the game
    function joinGame() public payable inState(State.Waiting) {
        
        // Requires a deposit of 0.01 ether to enter the game
        assert(msg.value == 0.01 ether);
        players.push(msg.sender);
        
        // The game can start when 2 players have joined the game
        if(players.length == 2) {
            state = State.Started;
            activePlayer = players[0];
            emit GameStart("Lets Sausage Roll!");
        }

    }
    
    // Roll the dice
    function roll() public isActive inState(State.Started) {
        
        // Randomly generate a number between one to six
        uint16 rolledScore = uint16(keccak256(blockhash(block.number-1), nonce)) % 6 + 1;
        nonce++;
        
        emit DiceScore(rolledScore);
        
        // Rolled score gets added to the current score provided it's not a 1
        if (rolledScore != 1) {
            updateCurrentScore(rolledScore);
        } else {
            switchPlayer();
            currentScore = 0;
            emit CurrentScore(currentScore);
        }
    }

    // Hodl the current turn score
    function hodl() public isActive inState(State.Started) {
        
        totalScore[msg.sender] += currentScore;
        
        // Player wins if they scored more than the winning score
        if (totalScore[msg.sender] >= winningScore) {
            msg.sender.transfer(address(this).balance);
            state = State.Finished;
            currentScore = 0;
            emit GameEnd("Winner!", msg.sender, totalScore[msg.sender]);
            
        } else {
            // Switching players
            currentScore = 0; // Resets current score
            switchPlayer();
        }
        
        emit HodlScore(totalScore[msg.sender]);
        emit CurrentScore(currentScore);
    }
    
    // Switch players
    function switchPlayer() private {
        activePlayer == players[0] ? activePlayer = players[1] : activePlayer = players[0];
    }

    // Updates player current score
    function updateCurrentScore(uint16 _currentScore) private {
        currentScore += _currentScore;
        emit CurrentScore(currentScore);
    }

}

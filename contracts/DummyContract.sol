pragma solidity ^0.6.2;

contract DummyContract {
    event RedIncrementation(uint256 counterValue, address txSender);
    event BlueIncrementation(uint256 counterValue, address txSender);

    uint256 constant MAX_TEAM_SIZE = 10;

    uint256 public redCounter;
    uint256 public blueCounter;

    address public lastTxSender;

    mapping(address => uint256) public incrementations;

    uint256 public blueTeamMembersCount;
    mapping(address => bool) public blueTeamMembers;

    uint256 public redTeamMembersCount;
    mapping(address => bool) public redTeamMembers;

    function joinRedTeam() public {
        require(
            !redTeamMembers[msg.sender] && !blueTeamMembers[msg.sender],
            "DummyContract: team membership detected"
        );

        require(
            redTeamMembersCount <= MAX_TEAM_SIZE,
            "DummyContract: no spaces available"
        );
        redTeamMembersCount++;
        redTeamMembers[msg.sender] = true;
    }

    function joinBlueTeam() public {
        require(
            !redTeamMembers[msg.sender] && !blueTeamMembers[msg.sender],
            "DummyContract: team membership detected"
        );

        require(
            blueTeamMembersCount <= MAX_TEAM_SIZE,
            "DummyContract: no spaces available"
        );
        blueTeamMembersCount++;
        blueTeamMembers[msg.sender] = true;
    }

    function increment() public {
        require(
            redTeamMembers[msg.sender] || blueTeamMembers[msg.sender],
            "DummyContract: no team membership detected"
        );

        lastTxSender = msg.sender;

        if (redTeamMembers[msg.sender]) {
            incrementations[msg.sender]++;
            emit RedIncrementation(redCounter++, msg.sender);
        } else {
            incrementations[msg.sender]++;
            emit BlueIncrementation(blueCounter++, msg.sender);
        }
    }

    function getWinningTeam() public view returns (string memory _winner) {
        if (redCounter > blueCounter) {
            _winner = "red";
        } else if (redCounter < blueCounter) {
            _winner = "blue";
        } else {
            _winner = "none";
        }
    }
}

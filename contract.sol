pragma solidity >=0.4.22 <0.6.0;

contract PaymentSystem{
    address admin;
    constructor()  public{
        admin = msg.sender;
        countOfAccounts = 0;
    }
    uint countOfAccounts;
    
    struct Account {
        uint accountId; 
        address owner;
        string fullNameOfOwner;
        int balance;
    }
    
    mapping(uint=>Account) public Accounts;
    
    function CreateAcc(int _balance, address _owner, string memory _fullNameOfOwner) public{
        if(msg.sender==admin){
            Accounts[countOfAccounts].balance = _balance;
            Accounts[countOfAccounts].owner = _owner;
            Accounts[countOfAccounts].fullNameOfOwner = _fullNameOfOwner;
            Accounts[countOfAccounts].accountId = countOfAccounts;
            countOfAccounts++;
        }
    }
    
    function ChangeAcc(uint AccountId, int changingValue) public{
        if(msg.sender==admin){
            Accounts[AccountId].balance += changingValue;
        }
    }
    
    function Transfer (uint AccountIdFrom, uint AccountIdTo, int Value) public{
        
            Accounts[AccountIdFrom].balance -= Value;
            Accounts[AccountIdTo].balance += Value;
        }
    
}pragma solidity >=0.4.22 <0.6.0;

contract PaymentSystem{
    address admin;
    constructor()  public{
        admin = msg.sender;
        countOfAccounts = 0;
    }
    uint countOfAccounts;
    
    struct Account {
        uint accountId; 
        address owner;
        string fullNameOfOwner;
        int balance;
    }
    
    mapping(uint=>Account) public Accounts;
    
    function CreateAcc(int _balance, address _owner, string memory _fullNameOfOwner) public{
        if(msg.sender==admin){
            Accounts[countOfAccounts].balance = _balance;
            Accounts[countOfAccounts].owner = _owner;
            Accounts[countOfAccounts].fullNameOfOwner = _fullNameOfOwner;
            Accounts[countOfAccounts].accountId = countOfAccounts;
            countOfAccounts++;
        }
    }
    
    function ChangeAcc(uint AccountId, int changingValue) public{
        if(msg.sender==admin){
            Accounts[AccountId].balance += changingValue;
        }
    }
    
    function Transfer (uint AccountIdFrom, uint AccountIdTo, int Value) public{
        
            Accounts[AccountIdFrom].balance -= Value;
            Accounts[AccountIdTo].balance += Value;
        }
    
}

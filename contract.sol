pragma solidity >=0.4.22 <0.6.0;

contract PaymentSystem{
    address admin; // адрес администратора
    constructor()  public{ // конструктор контракта 
        admin = msg.sender;
        countOfAccounts = 0; // число счетов при создании контракта 0
    }
    uint public countOfAccounts;
    
    struct Account {
        uint accountId; 
        address owner;
        string fullNameOfOwner;
        int balance;
    }
    
    mapping(uint=>Account) public Accounts; // маппинг всех счетов, счет по id
    
    function CreateAcc(int _balance, address _owner, string memory _fullNameOfOwner) public{ //создание счета
        if(msg.sender==admin){
            Accounts[countOfAccounts].balance = _balance;
            Accounts[countOfAccounts].owner = _owner;
            Accounts[countOfAccounts].fullNameOfOwner = _fullNameOfOwner;
            Accounts[countOfAccounts].accountId = countOfAccounts;
            countOfAccounts++;
        }
    }
    
    function ChangeAcc(uint AccountId, int changingValue) public{ // изменение баланса счета
    if(msg.sender==admin){
            Accounts[AccountId].balance += changingValue;
        }
    }
    
    function Transfer (uint AccountIdFrom, uint AccountIdTo, int Value) public{ // перевод с счета на счет
        
            Accounts[AccountIdFrom].balance -= Value;
            Accounts[AccountIdTo].balance += Value;
        }
    
}

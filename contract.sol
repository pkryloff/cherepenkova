pragma solidity >=0.4.22 <0.6.0;

contract PaymentSystem{
    address admin; // адрес администратора
    constructor()  public{ // конструктор контракта 
        admin = msg.sender;
        countOfAccounts = 0; // число счетов при создании контракта 0
        overdraftLimit = 0;
    }
    
     modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    uint public countOfAccounts;
    
    int overdraftLimit;
    
    struct Account {
        uint accountId; 
        address owner;
        string fullNameOfOwner;
        int balance; //реальный остаток
        int overdraft;
        bool isBanned; //забанен ли профиль, по умолчанию false, админ может заблокировать
        bool isDebtor; //по умолчанию false; true, если не погасил овердрафт до конца дня 
    }
    
    mapping(uint=>Account) public Accounts; // маппинг всех счетов, счет по id
    
    function SetOverdraftLimit(int newLimit) public{
        overdraftLimit = newLimit;
    }
    
    function makeUserDebtor(uint AccountId, bool flag) onlyAdmin  public{
        Accounts[AccountId].isDebtor = flag;
    }
    function makeUserBanned(uint AccountId, bool flag) onlyAdmin  public{
        Accounts[AccountId].isBanned = flag;
    }
    
    function CreateAcc(int _balance, address _owner, string memory _fullNameOfOwner) onlyAdmin public{ //создание счета
            Accounts[countOfAccounts].balance = _balance;
            Accounts[countOfAccounts].owner = _owner;
            Accounts[countOfAccounts].fullNameOfOwner = _fullNameOfOwner;
            Accounts[countOfAccounts].accountId = countOfAccounts;
            Accounts[countOfAccounts].overdraft = 0;
            countOfAccounts++;
    
    }
    
    function ChangeAcc(uint AccountId, int changingValue) onlyAdmin public{ // изменение баланса счета
            Accounts[AccountId].balance += changingValue;
    }
    
    function Transfer (uint AccountIdFrom, uint AccountIdTo, int value) public returns(bool){ // перевод со счета на счет
            if(Accounts[AccountIdFrom].owner == msg.sender){
               if(Accounts[AccountIdFrom].balance >= value)
               {
                  Accounts[AccountIdFrom].balance -= value;
                  Accounts[AccountIdTo].balance += value; 
               }
               else{
                   if((Accounts[AccountIdFrom].balance + overdraftLimit - Accounts[AccountIdFrom].overdraft) >= value)
                   {
                        Accounts[AccountIdFrom].overdraft += (Accounts[AccountIdFrom].balance - value)*(-1);
                        Accounts[AccountIdFrom].balance -= value;
                        Accounts[AccountIdTo].balance += value;
                   }
               }
            }
            else
                return false;
        }
    function repayOverdraft(uint AccountId, int value) public{
        Accounts[AccountId].overdraft -= value;
    }
}

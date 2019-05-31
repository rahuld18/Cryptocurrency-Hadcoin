pragma solidity ^0.4.11;

contract hadcoin_ico {
    
    
    //Introducing the maximum number of hadcoin available for sealed
    uint public max_hadcoins = 1000000;
    
    //introducing the usd to hadcoin conversion rate
     uint public usd_to_hadcoin = 1000;
        
            
    //introducing the total number of hadcoin that have been bought by the investor
    uint public total_hadcoin_bought = 0;
 
 //mapping from the investor address to its equity in hadcoins and usd
    mapping(address => uint) equity_hadcoins;
    mapping(address => uint) equity_usd;

  //checking if an investor  can buy hadcoins
  modifier can_buy_hadcoin(uint usd_invested){
      require(usd_invested * usd_to_hadcoin + total_hadcoin_bought <= max_hadcoins);
      _;
  }
  
  //getting the equity in hadcoins of an investor
  function equity_in_hadcoin(address investor) external constant returns (uint) {
      return equity_hadcoins[investor];
  }
  
  
  //getting the equity in usd of an investor
  function equity_in_usd(address investor) external constant returns ( uint ) {
      return equity_usd[investor];
  }
  
  //buying hadcoins
  
  function buy_hadcoins(address investor,uint usd_invested) external
  can_buy_hadcoin(usd_invested){
      
      uint hadcoin_bought =usd_invested*usd_to_hadcoin;
      equity_hadcoins[investor]+=hadcoin_bought;
      equity_usd[investor]=equity_hadcoins[investor]/1000;
      total_hadcoin_bought+=hadcoin_bought;
  }
   
   
   
   
  //selling hadcoins
  
  function sell_hadcoins(address investor,uint hadcoin_sold) external {
      
     
      equity_hadcoins[investor]-=hadcoin_sold;
      equity_usd[investor]=equity_hadcoins[investor]/1000;
      total_hadcoin_bought -=hadcoin_sold;
  }
    
}
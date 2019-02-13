pragma solidity 0.4.24;
pragma experimental ABIEncoderV2;

contract rent{
    //address public id ;
    
    struct Landlord{
        bool paidStatus;
        uint lockInPeriod;
        string fittings;
        string name;
        string userAddress;
        uint noticePeriod;
    }
     mapping(address => Landlord) public details;
     
     function userSignUp ( bool ps, uint lip, string f, string name, string ua, uint np) public{
      address  id= msg.sender;
        Landlord tmp;
        tmp.paidStatus = ps;
        tmp.lockInPeriod = lip;
        tmp.fittings =f ;
        tmp.name = name;
        tmp.userAddress = ua;
        tmp.noticePeriod = np;
        details[id] = tmp;
    
    }
   function getDetails(address _id) public returns(Landlord){
        return(details[_id]);
    }
    function getName(address _id) public returns(string){
        return details[_id].name;
    }
    struct fixtures{
        uint fans;
        uint lights;
        uint acs;
        uint tvs;
        uint sofas;
        uint refrigerators;
        uint waterheaters;
        uint roomheaters;
        bool paidStatus;
        uint lockInPeriod;
        string fittings;
        string name;
        string userAddress;
        uint noticePeriod;
        
    }
    mapping(uint => fixtures) public fix;
    mapping(address => fix) public moredetails;
    
}
pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract tenant{
    
    //enum Paytype {Prepaid, Postpaid}
    //Paytype public payType;
    
    struct agreement{
        
        uint securityDeposit;
        string paymentType;
        uint lockInPeriod;     // In days
        bool maintainCharges; //true if landlord
        bool govtTaxes;       // true if landlord
        address tenantAddress;
        bool noticePeriod;
        address landlordAddress;
        uint noticeTimeStamp;
        string propertyAddresss; //physical address
        string status; // occupied/v01acated/terminated/NP

    }
    
    mapping (address => agreement) public agrement;
    
    function signAgreement(address _tenant, address _landlord, uint _sd , string _pt, uint _lp, bool _mc, bool _gt, bool _np, string _pa) public {
        
        agreement memory tmp;
        tmp.securityDeposit = _sd;
        tmp.paymentType = _pt;
        tmp.lockInPeriod = _lp;
        tmp.maintainCharges = _mc;
        tmp.govtTaxes = _gt;
        tmp.noticePeriod = _np;
        tmp.propertyAddresss = _pa;
        tmp.tenantAddress = _tenant;
        tmp.landlordAddress = _landlord;
        tmp.status = "occupied";  // occupied/vacated/terminated/NP
        agrement[_tenant]=tmp;
        
    }
    
    function getAgreementDetails(address _tAddress) public view returns(agreement){
        return (agrement[_tAddress]);
    }
    
    function getPaymentDetails(address _tAddress) public view returns(string){
        return (agrement[_tAddress].paymentType);
    }
    
    function giveNotice(address _tAddress) public returns(string){
       // keccak256(a) == keccak256(b)
        require(keccak256(agrement[_tAddress].status) == keccak256("occupied"));
        agrement[_tAddress].noticePeriod = true;
        agrement[_tAddress].noticeTimeStamp = now + 2 minutes;
        agrement[_tAddress].status = "NP";
        return "Notice period given";
    }
    function vacate(address _tAddress) public returns(string){
        if(withDrawSD(_tAddress) == true){
            agrement[_tAddress].status = "vacated";
            return "eligible for securityDeposit refund";
        }
        else{
            agrement[_tAddress].status ="vacated";
            return "Not eligible for securityDeposit refund";
        }
        
    }
    function withDrawSD(address _tAddress) public view returns(bool){
        if(agrement[_tAddress].noticePeriod == true && agrement[_tAddress].noticeTimeStamp < now){
            return true;
        }
        
        else{
            return false;
        }
    }
    
    function lockInPeriodf(address _tAddress) public view returns(uint){
        return now + 1 minutes;
    }

}
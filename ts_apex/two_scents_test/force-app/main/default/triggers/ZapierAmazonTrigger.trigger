trigger ZapierAmazonTrigger on SOBJECT (before insert) {

}


/*

/*
Steps

New object created by zapier from amazon data
    declare order object
    declare account object
    declare contact object
    //check how updating existing is handled in apex, if it's creating copies or I have to pass by reference or whatever

search existing "order" objects to check if one matches with order
    if so, 
        update it with order data from and amazon if needed
        save order to transfer later
    if not,
        create it with the order data from amazon
        save order to transfer later

search existing account objects to check if one matches with info from order
    search by email
    if so, 
        update it with order data from amazon if needed
        save order to transfer later
    if not, 
        create it with the order data from amazon
        save order to transfer later

search existing contact objects to check if one matches with info from order
    search by email, then if matches check name 
    OR there may be a way to see what is already linked in apex
    if so, 
        update it with order data from amazon if needed
        save order to transfer later
    if not, 
        create it with the order data from amazon
        save order to transfer later

Once the above is done

    link the order to the account
    link the contact to the account
    link the order to the contact 
    search each field for matching product objects
        --we probably shouldn't create new ones if they don't already exist
        when one is found, link it to 
            --the order
            --the account 
            --the contacts
        do this for every product field in the order

*/
/*
trigger CreateEvent on Trip__c(after insert){
   List<Event> eventList = new List<Event>();
   for(Trip__c tripObj : Trigger.new){
      Event event = new Event();
      event.whatid  = tripObj.Account__c;
      event.Subject = tripObj.Name;
      event.OwnerId = tripObj.CreatedById;
      eventList.add(event);
   }
   if(eventList.size()>0){
      upsert eventList;
   }
}

//trigger when a new ZapierAmazon custom object is created
trigger ZapierAmazonTrigger on ZapierAmazon__c (after insert){
    List<Event> eventList = new List<Event>();
    for(ZapierAmazon__c ZapierAmazonObj : Trigger.new){






        try{
                Account newAccount = new Account();
                newAccount.name = accountName;
                insert newAccount;  
                return newAccount;
            }
        Catch(DMLException de){

                return null;

                }






            Event event = new Event();
            event.whatid  = tripObj.Account__c;
            event.Subject = tripObj.Name;
            event.OwnerId = tripObj.CreatedById;
            eventList.add(event);
        }
        if(eventList.size()>0){
            upsert eventList;
        }
    }

trigger SetAccountField on ShipTo__c (before insert, before update) {
2
    for (ShipTo__c shipto : Trigger.new) {
3
        String accid = shipto.Customer_Code__c;
4
        List<Account> account = [SELECT Id FROM Account WHERE Customer_Code__c = :accid];
5
        if(account != null && account.size()>0)
6
             shipto.Account__c = account[0].Id;
7
    }
8
}



public class AccountHandler{

public static Account insertNewAccount(String accountName){

    try{
            Account newAccount = new Account();
            newAccount.name = accountName;
            insert newAccount;  
            return newAccount;
       }
    Catch(DMLException de){
    
            return null;
    
           }
    }
}


*/
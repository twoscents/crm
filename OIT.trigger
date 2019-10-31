trigger OIT on OrderItem ( after insert ) {

   for(OrderItem orderItem : Trigger.new){

        String marketplace;
        String sku = orderItem.SKU__c;
        String name = orderItem.Name__c;

        List<Order> orderList = [SELECT Id, 
                        AccountId,
                        Marketplace__c
                        FROM Order WHERE (Id = :OrderItem.OrderId)];

        if( (orderList != null) && (orderList.size() > 0) ){

            marketplace = orderList[0].Marketplace__c;

            List<Account> accountList = [SELECT Id, 
                            SKUs_Ordered__c,
	                        Items_Ordered__c,
                            Marketplace__c
                            FROM Account WHERE (Id = :orderList[0].AccountId)];


            if( (accountList != null) && (accountList.size() > 0) ){

                Account account = accountList[0];

                //account.Marketplace__c = marketplace;

                if(account.Marketplace__c == null){
                    account.Marketplace__c = marketplace;
                }
                else if(marketplace != null){
                    if(!account.Marketplace__c.contains(marketplace)){
                        account.Marketplace__c += '\n' + marketplace;
                    }
                }

                if(account.SKUs_Ordered__c == null){
                    account.SKUs_Ordered__c = sku;
                }
                else if(marketplace != null){
                    if(!account.SKUs_Ordered__c.contains(sku)){
                        account.SKUs_Ordered__c += '\n' + sku;
                    }
                }

                if(account.Items_Ordered__c == null){
                    account.Items_Ordered__c = name;
                }
                else if(marketplace != null){
                    if(!account.Items_Ordered__c.contains(name)){
                        account.Items_Ordered__c += '\n' + name;
                    }
                }

                update account;

                List<Contact> contactList = [SELECT Id, 
                                AccountId,
                                SKUs_Ordered__c,
                                Items_Ordered__c,
                                Marketplace__c
                                FROM Contact WHERE (AccountId = :account.Id)];


                if( (contactList != null) && (contactList.size() > 0) ){

                    for(Contact contact : contactList){
                        //contact.Marketplace__c = marketplace;
                        if(contact.Marketplace__c == null){
                            contact.Marketplace__c = marketplace;
                        }
                        else if(marketplace != null){
                            if(!contact.Marketplace__c.contains(marketplace)){
                                contact.Marketplace__c += '\n' + marketplace;
                            }
                        }

                        if(contact.SKUs_Ordered__c == null){
                            contact.SKUs_Ordered__c = sku;
                        }
                        else if(marketplace != null){
                            if(!contact.SKUs_Ordered__c.contains(sku)){
                                contact.SKUs_Ordered__c += '\n' + sku;
                            }
                        }

                        if(contact.Items_Ordered__c == null){
                            contact.Items_Ordered__c = name;
                        }
                        else if(marketplace != null){
                            if(!contact.Items_Ordered__c.contains(name)){
                                contact.Items_Ordered__c += '\n' + name;
                            }
                        }

                        update contact;
                    }
                }
            }
        }
    }
}

trigger ssOIT on ShipstationOrderItemImport__c ( after insert ) {
    
    for(ShipstationOrderItemImport__c orderItemImport : Trigger.new){

        String pricebookname;

        String sku_as_id = orderItemImport.SKU__c;
        String shipstation_ordernumber_as_id = orderItemImport.shipstation_ordernumber_as_id__c;
        
        //Order order;
        Id orderId;
        Id productId;
        Id pricebookId;        
        Id pricebookentryId;

        List<Order> orderList = [SELECT Id, 
                        AccountId,
                        EffectiveDate,
                        Pricebook2Id,
                        Status,
                        shipstation_ordernumber_as_id__c,
                        Marketplace__c
                        FROM Order WHERE (shipstation_ordernumber_as_id__c LIKE :shipstation_ordernumber_as_id)];

        List<Product2> productList = [SELECT Id, sku_as_id__c FROM Product2 WHERE (sku_as_id__c LIKE :sku_as_id )];

        if( (orderList != null) && (orderList.size() > 0) ){

            Order order = orderList[0];

            // assign the marketplace to the order

            // if it has no marketplace, just set it to that
            if(order.Marketplace__c == null){
                order.Marketplace__c = orderItemImport.Marketplace__c;
            }
            // if its existing and it doesn't already contain this information then add it to the marketplace field
            else if( order.Marketplace__c.contains(orderItemImport.Marketplace__c) ){
                order.Marketplace__c += '\n' + orderItemImport.Marketplace__c;
            }

            update order;

            orderId = order.Id;
            if( order.PriceBook2Id != null ){         
            
                pricebookId = order.PriceBook2Id;
            }

            else if( pricebookname != null ){
                List<Pricebook2> pricebookList = [SELECT Id, Name FROM Pricebook2 WHERE (Name LIKE :pricebookname)];

                if( (pricebookList != null) && (pricebookList.size() > 0) ){

                    pricebookId = pricebookList[0].Id;
                }
            }
            else{
                PriceBook2 standard = [ SELECT Id, isStandard FROM Pricebook2 WHERE ( isStandard = true )];
                pricebookId = standard.Id;
            }
        }

        if( (productList != null) && (productList.size() > 0) ){
            productId = productList[0].Id;
        }

        List<PriceBookEntry> pricebookentryList = [SELECT Id, Pricebook2Id, sku_as_id__c FROM PricebookEntry WHERE (Pricebook2Id = :pricebookId) AND (sku_as_id__c LIKE :sku_as_id)];

        if( (pricebookentryList != null) && (pricebookentryList.size() > 0) ){
            pricebookentryId = pricebookentryList[0].Id;
        }       

        if(orderId == null) { System.Debug('orderid is null'); }
        if(productId == null) { System.Debug('productid is null'); }
        if(pricebookId == null) { System.Debug('pricebookid is null'); } 
        if(pricebookentryId == null) {System.Debug('pricebookentryid is null'); }

        if( (orderId != null) && (productId != null) && (pricebookId != null) && (pricebookentryId != null) ){

            List<OrderItem> orderitemList = [SELECT Id, ordernumber_sku_as_id__c FROM OrderItem WHERE (ordernumber_sku_as_id__c LIKE :orderItemImport.ordernumber_sku_as_id__c)];
            
            if( (orderitemList != null) && (orderitemList.size() > 0) ){
                
                OrderItem existingItem = orderitemList[0];

                // default fields
                // can't write to the next three
                //existingItem.OrderId = orderId;
                //existingItem.Product2Id = productId; 
                //existingItem.PricebookEntryId = pricebookentryId; 
                existingItem.Quantity = orderItemImport.Quantity__c;
                existingItem.UnitPrice = orderItemImport.Unit_Price__c;

                // custom fields
                existingItem.Fulfillment_SKU__c = orderItemImport.Fulfillment_SKU__c;
                existingItem.Image_URL__c = orderItemImport.Image_URL__c;
                existingItem.Name__c = orderItemImport.Name__c;
                existingItem.SKU__c = orderItemImport.SKU__c;
                existingItem.UPC__c = orderItemImport.UPC__c;
                existingItem.Weight_Units__c = orderItemImport.Weight_Units__c;
                existingItem.Product_ID__c = orderItemImport.Product_ID__c;
                existingItem.Quantity__c = orderItemImport.Quantity__c;
                existingItem.Shipping_Amount__c = orderItemImport.Shipping_Amount__c;
                existingItem.Tax_Amount__c = orderItemImport.Tax_Amount__c;
                existingItem.Unit_Price__c = orderItemImport.Unit_Price__c;
                existingItem.Weight_Value__c = orderItemImport.Weight_Value__c;
                existingItem.ordernumber_sku_as_id__c = orderItemImport.ordernumber_sku_as_id__c;

                update existingItem;

            }       
            else{
                OrderItem newItem = new OrderItem(

                    //default fields
                    OrderId = orderId,
                    Product2Id = productId, 
                    PricebookEntryId = pricebookentryId, 
                    Quantity = orderItemImport.Quantity__c,
                    UnitPrice = orderItemImport.Unit_Price__c,

                    //custom fields
                    Fulfillment_SKU__c = orderItemImport.Fulfillment_SKU__c,
                    Image_URL__c = orderItemImport.Image_URL__c,
                    Name__c = orderItemImport.Name__c,
                    SKU__c = orderItemImport.SKU__c,
                    UPC__c = orderItemImport.UPC__c,
                    Weight_Units__c = orderItemImport.Weight_Units__c,
                    Product_ID__c = orderItemImport.Product_ID__c,
                    Quantity__c = orderItemImport.Quantity__c,
                    Shipping_Amount__c = orderItemImport.Shipping_Amount__c,
                    Tax_Amount__c = orderItemImport.Tax_Amount__c,
                    Unit_Price__c = orderItemImport.Unit_Price__c,
                    Weight_Value__c = orderItemImport.Weight_Value__c,
                    ordernumber_sku_as_id__c = orderItemImport.ordernumber_sku_as_id__c
                );

                insert newItem;
            }
        }

    }

}
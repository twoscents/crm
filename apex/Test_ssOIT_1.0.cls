@isTest
//(seeAllData = true)

private class Test_ssOIT {
    @isTest static void Test_ssOIT() {

        // variables so I can use them in the creation of multiple test objects
        String test_fulfillmentSKU = 'test_sku_1234';
        String test_imageURL = 'www.testwebsite.com/testimage.jpeg.exe';
        String test_name = 'testssorderitem';
        String test_SKU = 'test_sku_1234';
        String test_UPC = '123456789-0';
        String test_weightUnits = 'lbs';
        Integer test_productID = 1234567890;
        Integer test_quantity = 1;
        Decimal test_shippingAmount = 10.99;
        Decimal test_taxAmount = 1.20;
        Decimal test_unitPrice = 100.23;
        Decimal test_weightValue = 3.4;

        String test_marketplace = 'testmarket';
        String test_shipstation_ordernumber_as_id = 'order_num_test_1234';
        String test_ordernumber_sku_as_id = 'order_num_test_1234-test_sku_1234';

        String test_email_as_id = 'test@test.com';
        Date test_date = system.today();


        System.Debug(LoggingLevel.ERROR,'YOOO LETS SEE IF WE CAN FIND WHERE THIS PIECE OF SHIT PRINTS THIS SHIT AYYLMAO');

/*
"ID"
"01s4T000001qIGbQAM"
"01s4T000001qIGcQAM"
"01s4T000001rjyyQAA"

        Pricebook2 standardPricebook = [SELECT IsStandard FROM Pricebook2 WHERE Id = '01s4T000001rjyyQAA'];

        standardPricebook = [SELECT IsStandard FROM Pricebook2 WHERE Id = :standardPricebook.Id];

        */

        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );

        //Pricebook2 standardPricebook = [select id from Pricebook2 where isStandard=true];
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;

        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard FROM Pricebook2 WHERE Id = :standardPricebook.Id];

        // This should return true now
        system.assertEquals(true, standardPricebook.IsStandard, 'The Standard Pricebook should now return IsStandard = true');





        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Test Product',
            sku_as_id__c = test_SKU,
            IsActive = true
        );

        insert testProduct;

        // Re-Query the product
        testProduct = [SELECT Id, sku_as_id__c FROM Product2 WHERE (sku_as_id__c = :test_SKU) ];

        // Create the PricebookEntry
        PricebookEntry testPricebookEntry = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            sku_as_id__c = test_SKU,
            UnitPrice = 100,
            IsActive = true,
            UseStandardPrice = false

        );

        insert testPricebookEntry;


        // Re-Query the PBE
        testPricebookEntry = [SELECT Id, Pricebook2.IsStandard, sku_as_id__c FROM PricebookEntry WHERE (sku_as_id__c = :test_SKU) ];
        
        // Should also return true
        system.assertEquals(true, testPricebookEntry.Pricebook2.IsStandard, 'The Standard Pricebook should return true from the PBE as well.');

        // Create the account 
        Account testAccount = new Account(
            Name = 'test_Account',
            //IsActive = true,
            email_as_id__c = test_email_as_id
        );

        insert testAccount;

        
        testAccount = [SELECT Id, email_as_id__c FROM Account WHERE (email_as_id__c = :test_email_as_id) ];


        // Create the Order
        Order testOrder = new Order(
            AccountId = testAccount.Id,
            EffectiveDate = test_date,
            Pricebook2Id = standardPricebook.Id,
            Status = 'Draft',
            //IsActive = true,
            shipstation_ordernumber_as_id__c = test_shipstation_ordernumber_as_id
        );

        insert testOrder;

        testOrder = [SELECT Id, 
                        AccountId,
                        EffectiveDate,
                        Pricebook2Id,
                        Status,
                        shipstation_ordernumber_as_id__c,
                        Marketplace__c
                        FROM Order WHERE (shipstation_ordernumber_as_id__c LIKE :test_shipstation_ordernumber_as_id)];

        // Create the ShipstationOrderItemImport__c
        ShipstationOrderItemImport__c test_SSOIT = new ShipstationOrderItemImport__c(

            Fulfillment_SKU__c = test_fulfillmentSKU,
            Image_URL__c = test_imageURL,
            Name__c = test_name,
            SKU__c = test_SKU,
            UPC__c = test_UPC,
            Weight_Units__c = test_weightUnits,
            Product_ID__c = test_productID,
            Quantity__c = test_quantity,
            Shipping_Amount__c = test_shippingAmount,
            Tax_Amount__c = test_taxAmount,
            Unit_Price__c = test_unitPrice,
            Weight_Value__c = test_weightValue,
            Marketplace__c = test_marketplace,
            shipstation_ordernumber_as_id__c = test_shipstation_ordernumber_as_id,
            ordernumber_sku_as_id__c = test_ordernumber_sku_as_id
        );

System.Debug(LoggingLevel.ERROR,'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ before insert');
System.Debug(LoggingLevel.ERROR,'testOrder.Id');
System.Debug(LoggingLevel.ERROR,testOrder.Id);
System.Debug(LoggingLevel.ERROR,'testOrder.AccountId');
System.Debug(LoggingLevel.ERROR,testOrder.AccountId);
System.Debug(LoggingLevel.ERROR,'testOrder.EffectiveDate');
System.Debug(LoggingLevel.ERROR,testOrder.EffectiveDate);
System.Debug(LoggingLevel.ERROR,'testOrder.Pricebook2Id');
System.Debug(LoggingLevel.ERROR,testOrder.Pricebook2Id);
System.Debug(LoggingLevel.ERROR,'testOrder.Status');
System.Debug(LoggingLevel.ERROR,testOrder.Status);
System.Debug(LoggingLevel.ERROR,'testOrder.shipstation_ordernumber_as_id__c');
System.Debug(LoggingLevel.ERROR,testOrder.shipstation_ordernumber_as_id__c);
System.Debug(LoggingLevel.ERROR,'testOrder.Marketplace__c');
System.Debug(LoggingLevel.ERROR,testOrder.Marketplace__c);


        // Insert the test ShipstationOrderItemImport__c
        Test.startTest();
        Database.SaveResult result = Database.insert(test_SSOIT, false);
        //Test.stopTest();




System.Debug(LoggingLevel.ERROR,':test_ordernumber_sku_as_id');
System.Debug(LoggingLevel.ERROR,test_ordernumber_sku_as_id);

        // query for the orderitem that should have been created by the trigger
        //OrderItem testOrderItem = [SELECT Id, ordernumber_sku_as_id__c FROM OrderItem WHERE (ordernumber_sku_as_id__c LIKE :test_ordernumber_sku_as_id)];
        //OrderItem testOrderItem = [SELECT Id FROM OrderItem WHERE (ordernumber_sku_as_id__c LIKE :test_SSOIT.ordernumber_sku_as_id__c)];









        OrderItem testOrderItem = [SELECT Id, 
                            OrderId, 
                            Product2Id, 
                            PricebookEntryId,

                            Quantity,
                            UnitPrice,

                            Fulfillment_SKU__c, 
                            Image_URL__c,
                            Name__c, 
                            SKU__c, 
                            UPC__c, 
                            Weight_Units__c, 
                            Product_ID__c, 
                            Quantity__c, 
                            Shipping_Amount__c, 
                            Tax_Amount__c, 
                            Unit_Price__c, 
                            Weight_Value__c, 
                            ordernumber_sku_as_id__c
                            FROM OrderItem WHERE (ordernumber_sku_as_id__c LIKE :test_ordernumber_sku_as_id)];

        System.assert(result.isSuccess());

        //customfields
        System.assertEquals(test_fulfillmentSKU, test_SSOIT.Fulfillment_SKU__c);
        System.assertEquals(test_imageURL, test_SSOIT.Image_URL__c);
        System.assertEquals(test_name, test_SSOIT.Name__c);
        System.assertEquals(test_SKU, test_SSOIT.SKU__c);
        System.assertEquals(test_UPC, test_SSOIT.UPC__c);
        System.assertEquals(test_weightUnits, test_SSOIT.Weight_Units__c);
        System.assertEquals(test_productID, test_SSOIT.Product_ID__c);
        System.assertEquals(test_quantity, test_SSOIT.Quantity__c);
        System.assertEquals(test_shippingAmount, test_SSOIT.Shipping_Amount__c);
        System.assertEquals(test_taxAmount, test_SSOIT.Tax_Amount__c);
        System.assertEquals(test_unitPrice, test_SSOIT.Unit_Price__c);
        System.assertEquals(test_weightValue, test_SSOIT.Weight_Value__c);
        System.assertEquals(test_marketplace, test_SSOIT.Marketplace__c);
        System.assertEquals(test_shipstation_ordernumber_as_id, test_SSOIT.shipstation_ordernumber_as_id__c);
        System.assertEquals(test_ordernumber_sku_as_id, test_SSOIT.ordernumber_sku_as_id__c);

        //assert that the orderitem was made
        System.assert(testOrderItem!=null);

        //defaultIdfields
        System.assertEquals(testOrder.Id, testOrderItem.OrderId);
        System.assertEquals(testProduct.Id, testOrderItem.Product2Id);
        System.assertEquals(testPricebookEntry.Id, testOrderItem.PricebookEntryId);

        //otherdefaultfields
        System.assertEquals(test_quantity, testOrderItem.Quantity);
        System.assertEquals(test_unitPrice, testOrderItem.UnitPrice);

        //customfields
        System.assertEquals(test_fulfillmentSKU, testOrderItem.Fulfillment_SKU__c);
        System.assertEquals(test_imageURL, testOrderItem.Image_URL__c);
        System.assertEquals(test_name, testOrderItem.Name__c);
        System.assertEquals(test_SKU, testOrderItem.SKU__c);
        System.assertEquals(test_UPC, testOrderItem.UPC__c);
        System.assertEquals(test_weightUnits, testOrderItem.Weight_Units__c);
        System.assertEquals(test_productID, testOrderItem.Product_ID__c);
        System.assertEquals(test_quantity, testOrderItem.Quantity__c);
        System.assertEquals(test_shippingAmount, testOrderItem.Shipping_Amount__c);
        System.assertEquals(test_taxAmount, testOrderItem.Tax_Amount__c);
        System.assertEquals(test_unitPrice, testOrderItem.Unit_Price__c);
        System.assertEquals(test_weightValue, testOrderItem.Weight_Value__c);
        //System.assertEquals(test_marketplace, testOrderItem.Marketplace__c);
        //System.assertEquals(test_shipstation_ordernumber_as_id, testOrderItem.shipstation_ordernumber_as_id__c);
        System.assertEquals(test_ordernumber_sku_as_id, testOrderItem.ordernumber_sku_as_id__c);

System.Debug(LoggingLevel.ERROR,'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ after insert, before requery');
System.Debug(LoggingLevel.ERROR,'testOrder.Id');
System.Debug(LoggingLevel.ERROR,testOrder.Id);
System.Debug(LoggingLevel.ERROR,'testOrder.AccountId');
System.Debug(LoggingLevel.ERROR,testOrder.AccountId);
System.Debug(LoggingLevel.ERROR,'testOrder.EffectiveDate');
System.Debug(LoggingLevel.ERROR,testOrder.EffectiveDate);
System.Debug(LoggingLevel.ERROR,'testOrder.Pricebook2Id');
System.Debug(LoggingLevel.ERROR,testOrder.Pricebook2Id);
System.Debug(LoggingLevel.ERROR,'testOrder.Status');
System.Debug(LoggingLevel.ERROR,testOrder.Status);
System.Debug(LoggingLevel.ERROR,'testOrder.shipstation_ordernumber_as_id__c');
System.Debug(LoggingLevel.ERROR,testOrder.shipstation_ordernumber_as_id__c);
System.Debug(LoggingLevel.ERROR,'testOrder.Marketplace__c');
System.Debug(LoggingLevel.ERROR,testOrder.Marketplace__c);


        testOrder = [SELECT Id, 
                        AccountId,
                        EffectiveDate,
                        Pricebook2Id,
                        Status,
                        shipstation_ordernumber_as_id__c,
                        Marketplace__c
                        FROM Order WHERE (shipstation_ordernumber_as_id__c LIKE :test_shipstation_ordernumber_as_id)];

System.Debug(LoggingLevel.ERROR,'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ after requery');
System.Debug(LoggingLevel.ERROR,'testOrder.Id');
System.Debug(LoggingLevel.ERROR,testOrder.Id);
System.Debug(LoggingLevel.ERROR,'testOrder.AccountId');
System.Debug(LoggingLevel.ERROR,testOrder.AccountId);
System.Debug(LoggingLevel.ERROR,'testOrder.EffectiveDate');
System.Debug(LoggingLevel.ERROR,testOrder.EffectiveDate);
System.Debug(LoggingLevel.ERROR,'testOrder.Pricebook2Id');
System.Debug(LoggingLevel.ERROR,testOrder.Pricebook2Id);
System.Debug(LoggingLevel.ERROR,'testOrder.Status');
System.Debug(LoggingLevel.ERROR,testOrder.Status);
System.Debug(LoggingLevel.ERROR,'testOrder.shipstation_ordernumber_as_id__c');
System.Debug(LoggingLevel.ERROR,testOrder.shipstation_ordernumber_as_id__c);
System.Debug(LoggingLevel.ERROR,'testOrder.Marketplace__c');
System.Debug(LoggingLevel.ERROR,testOrder.Marketplace__c);


System.Debug(LoggingLevel.ERROR,'testOrder.Marketplace__c');
System.Debug(LoggingLevel.ERROR,testOrder.Marketplace__c);

System.Debug(LoggingLevel.ERROR,'test_marketplace');
System.Debug(LoggingLevel.ERROR,test_marketplace);


        



        // checking that the marketplace got assigned to the order
        System.assertEquals(test_marketplace, testOrder.Marketplace__c);
        //confirmed this actually works through logs but for some reason the test process cant see the changes
        //done in the trigger



        // Create the second ShipstationOrderItemImport__c
        ShipstationOrderItemImport__c test_SSOIT2 = new ShipstationOrderItemImport__c(

            Fulfillment_SKU__c = test_fulfillmentSKU,
            Image_URL__c = test_imageURL,
            Name__c = test_name,
            SKU__c = test_SKU,
            UPC__c = test_UPC,
            Weight_Units__c = test_weightUnits,
            Product_ID__c = test_productID,
            Quantity__c = test_quantity,
            Shipping_Amount__c = test_shippingAmount,
            Tax_Amount__c = test_taxAmount,
            Unit_Price__c = test_unitPrice,
            Weight_Value__c = test_weightValue,
            Marketplace__c = test_marketplace,
            shipstation_ordernumber_as_id__c = test_shipstation_ordernumber_as_id,
            ordernumber_sku_as_id__c = test_ordernumber_sku_as_id
        );


                OrderItem testOrderItem2 = new OrderItem(

                    //default fields
                    //only set these
                    OrderId = testOrder.Id,
                    Product2Id = testProduct.ID, 
                    PricebookEntryId = testPricebookEntry.Id,









                    //custom fields
                    /*
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
                    //Marketplace__c = orderItemImport.Marketplace__c,
                    //shipstation_ordernumber_as_id__c = orderItemImport.shipstation_ordernumber_as_id__c,
                    
                    
                    */

                    //and this one so it can find it; the rest will be set by the trigger

                    ordernumber_sku_as_id__c = test_ordernumber_sku_as_id

                    //no wait thast stupid lmao we only want the ones that it will set
                    //no actually we do want this

                );









        //Test.startTest();
        result = Database.insert(test_SSOIT2, false);
        //Test.stopTest();

        // already has an existing OrderItem from above lol
        // no wait that's stupid







        testOrderItem2 = [SELECT Id, 
                            OrderId, 
                            Product2Id, 
                            PricebookEntryId,

                            Quantity,
                            UnitPrice,

                            Fulfillment_SKU__c, 
                            Image_URL__c,
                            Name__c, 
                            SKU__c, 
                            UPC__c, 
                            Weight_Units__c, 
                            Product_ID__c, 
                            Quantity__c, 
                            Shipping_Amount__c, 
                            Tax_Amount__c, 
                            Unit_Price__c, 
                            Weight_Value__c, 
                            ordernumber_sku_as_id__c
                            FROM OrderItem WHERE (ordernumber_sku_as_id__c LIKE :test_ordernumber_sku_as_id)];

        System.assert(result.isSuccess());

        //customfields
        System.assertEquals(test_fulfillmentSKU, test_SSOIT2.Fulfillment_SKU__c);
        System.assertEquals(test_imageURL, test_SSOIT2.Image_URL__c);
        System.assertEquals(test_name, test_SSOIT2.Name__c);
        System.assertEquals(test_SKU, test_SSOIT2.SKU__c);
        System.assertEquals(test_UPC, test_SSOIT2.UPC__c);
        System.assertEquals(test_weightUnits, test_SSOIT2.Weight_Units__c);
        System.assertEquals(test_productID, test_SSOIT2.Product_ID__c);
        System.assertEquals(test_quantity, test_SSOIT2.Quantity__c);
        System.assertEquals(test_shippingAmount, test_SSOIT2.Shipping_Amount__c);
        System.assertEquals(test_taxAmount, test_SSOIT2.Tax_Amount__c);
        System.assertEquals(test_unitPrice, test_SSOIT2.Unit_Price__c);
        System.assertEquals(test_weightValue, test_SSOIT2.Weight_Value__c);
        System.assertEquals(test_marketplace, test_SSOIT2.Marketplace__c);
        System.assertEquals(test_shipstation_ordernumber_as_id, test_SSOIT2.shipstation_ordernumber_as_id__c);
        System.assertEquals(test_ordernumber_sku_as_id, test_SSOIT2.ordernumber_sku_as_id__c);

        //assert that the orderitem was made
        System.assert(testOrderItem2!=null);

        //defaultIdfields
        System.assertEquals(testOrder.Id, testOrderItem2.OrderId);
        System.assertEquals(testProduct.Id, testOrderItem2.Product2Id);
        System.assertEquals(testPricebookEntry.Id, testOrderItem2.PricebookEntryId);

        //otherdefaultfields
        System.assertEquals(test_quantity, testOrderItem2.Quantity);
        System.assertEquals(test_unitPrice, testOrderItem2.UnitPrice);

        //customfields
        System.assertEquals(test_fulfillmentSKU, testOrderItem2.Fulfillment_SKU__c);
        System.assertEquals(test_imageURL, testOrderItem2.Image_URL__c);
        System.assertEquals(test_name, testOrderItem2.Name__c);
        System.assertEquals(test_SKU, testOrderItem2.SKU__c);
        System.assertEquals(test_UPC, testOrderItem2.UPC__c);
        System.assertEquals(test_weightUnits, testOrderItem2.Weight_Units__c);
        System.assertEquals(test_productID, testOrderItem2.Product_ID__c);
        System.assertEquals(test_quantity, testOrderItem2.Quantity__c);
        System.assertEquals(test_shippingAmount, testOrderItem2.Shipping_Amount__c);
        System.assertEquals(test_taxAmount, testOrderItem2.Tax_Amount__c);
        System.assertEquals(test_unitPrice, testOrderItem2.Unit_Price__c);
        System.assertEquals(test_weightValue, testOrderItem2.Weight_Value__c);
        //System.assertEquals(test_marketplace, testOrderItem2.Marketplace__c);
        //System.assertEquals(test_shipstation_ordernumber_as_id, testOrderItem2.shipstation_ordernumber_as_id__c);
        System.assertEquals(test_ordernumber_sku_as_id, testOrderItem2.ordernumber_sku_as_id__c);






        // now with a matching existing OrderItem
/*
        ShipstationOrderItemImport__c test_SSOIT = new ShipstationOrderItemImport__c(

            Fulfillment_SKU__c = test_fulfillmentSKU,
            Image_URL__c = test_imageURL,
            Name__c = test_name,
            SKU__c = test_SKU,
            UPC__c = test_UPC,
            Weight_Units__c = test_weightUnits,
            Product_ID__c = test_productID,
            Quantity__c = test_quantity,
            Shipping_Amount__c = test_shippingAmount,
            Tax_Amount__c = test_taxAmount,
            Unit_Price__c = test_unitPrice,
            Weight_Value__c = test_weightValue,
            Marketplace__c = test_marketplace,
            shipstation_ordernumber_as_id__c = test_shipstation_ordernumber_as_id,
            ordernumber_sku_as_id__c = test_ordernumber_sku_as_id
        );

                OrderItem newOrderItem = new OrderItem(

                    //default fields
                    OrderId = testOrder.Id,
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
                    //Marketplace__c = orderItemImport.Marketplace__c,
                    //shipstation_ordernumber_as_id__c = orderItemImport.shipstation_ordernumber_as_id__c,
                    ordernumber_sku_as_id__c = orderItemImport.ordernumber_sku_as_id__c
                );

*/


Test.stopTest();






























































    }
}
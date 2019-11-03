@isTest
//(seeAllData = true)

private class Test_OIT {
    @isTest static void Test_OIT() {

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

        // Create and insert the account 
        Account testAccount = new Account(
            Name = 'test_Account',
            email_as_id__c = test_email_as_id,
            Marketplace__c = 'testplace',
            SKUs_Ordered__c ='skippity',
            Items_Ordered__c = 'bippity'
        );

        insert testAccount;

        testAccount = [SELECT Id, Name, email_as_id__c, Marketplace__c, SKUs_Ordered__c, Items_Ordered__c FROM Account WHERE (Name = 'test_Account') ]; 

        // Create and insert the contacts 
        Contact testContact = new Contact(
            LastName = 'test_Contact',
            AccountId = testAccount.Id,
            email_as_id__c = test_email_as_id,
            Marketplace__c = 'testplace',
            SKUs_Ordered__c ='skippity',
            Items_Ordered__c = 'bippity'
        );

        insert testContact;

        // Create and insert the contacts 
        Contact testContact2 = new Contact(
            LastName = 'test_Contact2',
            AccountId = testAccount.Id,
            email_as_id__c = test_email_as_id,
            Marketplace__c = 'testplace',
            SKUs_Ordered__c ='skippity',
            Items_Ordered__c = 'bippity'
        );

        insert testContact2;
        
        testContact = [SELECT Id, LastName, AccountId, email_as_id__c, Marketplace__c FROM Contact WHERE (LastName = 'test_Contact') ];
        testContact2 = [SELECT Id, LastName, AccountId, email_as_id__c, Marketplace__c FROM Contact WHERE (LastName = 'test_Contact2') ];

        // Create the Order
        Order testOrder = new Order(
            AccountId = testAccount.Id,
            EffectiveDate = test_date,
            Pricebook2Id = standardPricebook.Id,
            Status = 'Draft',
            Marketplace__c = test_marketplace,
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

        OrderItem testOrderItem = new OrderItem(

            //default fields
            OrderId = testOrder.Id,
            Product2Id = testProduct.ID, 
            PricebookEntryId = testPricebookEntry.Id,

            Quantity = test_quantity,
            UnitPrice = test_unitPrice,

            //custom fields
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
            ordernumber_sku_as_id__c = test_ordernumber_sku_as_id
        );

        Test.startTest();
        Database.SaveResult result = Database.insert(testOrderItem, false);
        //Test.stopTest();

        testAccount = [SELECT Id, Name, email_as_id__c, Marketplace__c, SKUs_Ordered__c, Items_Ordered__c FROM Account WHERE (Name = 'test_Account') ];

        testContact = [SELECT Id, LastName, AccountId, email_as_id__c, Marketplace__c, SKUs_Ordered__c, Items_Ordered__c FROM Contact WHERE (LastName = 'test_Contact') ];
        testContact2 = [SELECT Id, LastName, AccountId, email_as_id__c, Marketplace__c, SKUs_Ordered__c, Items_Ordered__c FROM Contact WHERE (LastName = 'test_Contact2') ];

        System.assert(result.isSuccess());

        System.assert(testAccount.Marketplace__c.contains('testplace'));
        System.assert(testAccount.SKUs_Ordered__c.contains('skippity'));
        System.assert(testAccount.Items_Ordered__c.contains('bippity'));
        System.assert(testAccount.Marketplace__c.contains(test_marketplace));
        System.assert(testAccount.SKUs_Ordered__c.contains(test_SKU));
        System.assert(testAccount.Items_Ordered__c.contains(test_name));

        System.assert(testContact.Marketplace__c.contains('testplace'));
        System.assert(testContact.SKUs_Ordered__c.contains('skippity'));
        System.assert(testContact.Items_Ordered__c.contains('bippity'));
        System.assert(testContact.Marketplace__c.contains(test_marketplace));
        System.assert(testContact.SKUs_Ordered__c.contains(test_SKU));
        System.assert(testContact.Items_Ordered__c.contains(test_name));

        System.assert(testContact2.Marketplace__c.contains('testplace'));
        System.assert(testContact2.SKUs_Ordered__c.contains('skippity'));
        System.assert(testContact2.Items_Ordered__c.contains('bippity'));
        System.assert(testContact2.Marketplace__c.contains(test_marketplace));
        System.assert(testContact2.SKUs_Ordered__c.contains(test_SKU));
        System.assert(testContact2.Items_Ordered__c.contains(test_name));

        Test.stopTest();

    }
}
public with sharing class ZapierAmazonOrder {
    public ZapierAmazonOrder() {

    }
}
/*
PaymentMethodDetails_PaymentMethodDetail
				
IsReplacementOrder				
IsBusinessOrder					
OrderType						
EarliestShipDate				
LatestShipDate					
SellerOrderId					
id								
PaymentMethod					
FulfillmentChannel				
IsPremiumOrder					
	ShippingAddress_City						
	ShippingAddress_Name						
	ShippingAddress_CountryCode					
	ShippingAddress_isAddressSharingConfidential  			//this created issues
	ShippingAddress_StateOrRegion				
	ShippingAddress_AddressLine1				
	ShippingAddress_PostalCode					
BuyerName						
LastUpdateDate					
PurchaseDate					
ShipmentServiceLevelCategory	
	OrderTotal_CurrencyCode				
	OrderTotal_Amount						
BuyerEmail						
AmazonOrderId					
SalesChannel					
NumberOfItemsUnshipped			
ShipServiceLevel				
OrderStatus						
NumberOfItemsShipped			
IsPrime		


MarketplaceId										//this is going to be the same every time but well still track it in the case of having multiple amazon accounts or switching to a different one at some point
					
OrderItems_0_										//same with this one
			OrderItems_0_OrderItem		 			//this is a blank field that doesn't do anything
			OrderItems_0_ASIN						
			OrderItems_0_SerialNumberRequired		//don't think we need this one
			OrderItems_0_SellerSKU					
			OrderItems_0_OrderItemId					
			OrderItems_0_Title						
			OrderItems_0_IsGift						//probably don't need to track this but I guess might as well		
			OrderItems_0_PromotionDiscountTax_CurrencyCode				//these all caused issue but also don't seem important to salesforce	
			OrderItems_0_PromotionDiscountTax_Amount					//these all caused issue but also don't seem important to salesforce				
			OrderItems_0_TaxCollection_Model							//these all caused issue but also don't seem important to salesforce
			OrderItems_0_TaxCollection_ResponsibleParty					//these all caused issue but also don't seem important to salesforce
			OrderItems_0_PromotionDiscount_CurrencyCode			//if the above caused issues then these are probably likely to as well, so lets just disregard		
			OrderItems_0_PromotionDiscount_Amount				//if the above caused issues then these are probably likely to as well, so lets just disregard			
			OrderItems_0_ItemPrice_CurrencyCode					//if the above caused issues then these are probably likely to as well, so lets just disregard
			OrderItems_0_ItemPrice_Amount						//if the above caused issues then these are probably likely to as well, so lets just disregard	
			OrderItems_0_ProductInfo_NumberOfItems					
			OrderItems_0_QuantityShipped					
			OrderItems_0_IsTransparency					//probably don't need this	
			OrderItems_0_QuantityOrdered					
			OrderItems_0_ItemTax_CurrencyCode					//we can probably just exclude this and go into the actual order if it's necessary
			OrderItems_0_ItemTax_Amount							//we can probably just exclude this and go into the actual order if it's necessary   
				

*/

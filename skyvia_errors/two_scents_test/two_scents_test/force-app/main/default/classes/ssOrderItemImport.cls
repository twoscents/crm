public with sharing class ssOrderItemImport {

    private String fulfillmentSKU;
    private String imageURL;
    private String name;
    private String SKU;
    private String UPC;
    private String weightUnits;
    private Integer productID;
    private Integer quantity;
    private Decimal shippingAmount;
    private Decimal taxAmount;
    private Decimal unitPrice;
    private Decimal WeightValue;

    private String marketplace;
    private String shipstation_ordernumber_as_id;
    private String ordernumber_sku_as_id;

    public ssOrderItemImport(){}

    public ssOrderItemImport( ShipstationOrderItemImport__c orderItem )
    {
        this.fulfillmentSKU = orderItem.Fulfillment_SKU__c;
        this.imageURL = orderItem.Image_URL__c;
        this.name = orderItem.Name__c;
        this.SKU = orderItem.SKU__c;
        this.UPC = orderItem.UPC__c;
        this.weightUnits = orderItem.Weight_Units__c;
        this.productID = orderItem.Product_ID__c;
        this.quantity = orderItem.Quantity__c;
        this.shippingAmount = orderItem.Shipping_Amount__c;
        this.taxAmount = orderItem.Tax_Amount__c;
        this.unitPrice = orderItem.Unit_Price__c;
        this.WeightValue = orderItem.Weight_Value__c;
        this.marketplace = orderItem.Marketplace__c;
        this.shipstation_ordernumber_as_id = orderItem.shipstation_ordernumber_as_id__c;
        this.ordernumber_sku_as_id = orderItem.ordernumber_sku_as_id__c;
    }

	public String getFulfillmentSKU() {
		return this.fulfillmentSKU;
	}

	public void setFulfillmentSKU(String fulfillmentSKU) {
		this.fulfillmentSKU = fulfillmentSKU;
	}

	public String getImageURL() {
		return this.imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSKU() {
		return this.SKU;
	}

	public void setSKU(String SKU) {
		this.SKU = SKU;
	}

	public String getUPC() {
		return this.UPC;
	}

	public void setUPC(String UPC) {
		this.UPC = UPC;
	}

	public String getWeightUnits() {
		return this.weightUnits;
	}

	public void setWeightUnits(String weightUnits) {
		this.weightUnits = weightUnits;
	}

	public Integer getProductID() {
		return this.productID;
	}

	public void setProductID(Integer productID) {
		this.productID = productID;
	}

	public Integer getQuantity() {
		return this.quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Decimal getShippingAmount() {
		return this.shippingAmount;
	}

	public void setShippingAmount(Decimal shippingAmount) {
		this.shippingAmount = shippingAmount;
	}

	public Decimal getTaxAmount() {
		return this.taxAmount;
	}

	public void setTaxAmount(Decimal taxAmount) {
		this.taxAmount = taxAmount;
	}

	public Decimal getUnitPrice() {
		return this.unitPrice;
	}

	public void setUnitPrice(Decimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Decimal getWeightValue() {
		return this.WeightValue;
	}

	public void setWeightValue(Decimal WeightValue) {
		this.WeightValue = WeightValue;
	}

	public String getMarketplace() {
		return this.marketplace;
	}

	public void setMarketplace(String marketplace) {
		this.marketplace = marketplace;
	}

	public String getShipstation_ordernumber_as_id() {
		return this.shipstation_ordernumber_as_id;
	}

	public void setShipstation_ordernumber_as_id(String shipstation_ordernumber_as_id) {
		this.shipstation_ordernumber_as_id = shipstation_ordernumber_as_id;
	}

	public String getOrdernumber_sku_as_id() {
		return this.ordernumber_sku_as_id;
	}

	public void setOrdernumber_sku_as_id(String ordernumber_sku_as_id) {
		this.ordernumber_sku_as_id = ordernumber_sku_as_id;
	}

}

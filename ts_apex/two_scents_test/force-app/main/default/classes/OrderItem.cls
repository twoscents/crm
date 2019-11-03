public with sharing class OrderItem {

    private Boolean serialNumberRequired;
    private Boolean isGift;
    private Boolean isTransparency;

    private Integer productInfo_NumberOfItems;
    private Integer quantityShipped;
    private Integer quantityOrdered;

    private String ASIN;
    private String sellerSKU;
    private String orderItemId;
    private String title;

	/*
    public OrderItem(
        serialNumberRequired,
        isGift,
        isTransparency,

        productInfo_NumberOfItems,
        quantityShipped,
        quantityOrdered,

        ASIN,
        sellerSKU,
        orderItemId,
        title                   
    ){
        this.serialNumberRequired = serialNumberRequired;
        this.isGift = isGift;
        this.isTransparency = isTransparency;

        this.productInfo_NumberOfItems = productInfo_NumberOfItems;
        this.quantityShipped = quantityShipped;
        this.quantityOrdered = quantityOrdered;

        this.ASIN = ASIN;
        this.sellerSKU = sellerSKU;
        this.orderItemId = orderItemId;
        this.title = title;
    }
	*/



	public Boolean getSerialNumberRequired() {
		return this.serialNumberRequired;
	}

	public void setIsSerialNumberRequired(Boolean serialNumberRequired) {
		this.serialNumberRequired = serialNumberRequired;
	}

	public Boolean getIsGift() {
		return this.isGift;
	}

	public void setIsGift(Boolean isGift) {
		this.isGift = isGift;
	}

	public Boolean getIsTransparency() {
		return this.isTransparency;
	}

	public void setIsTransparency(Boolean isTransparency) {
		this.isTransparency = isTransparency;
	}

	public Integer getProductInfo_NumberOfItems() {
		return this.productInfo_NumberOfItems;
	}

	public void setProductInfo_NumberOfItems(Integer productInfo_NumberOfItems) {
		this.productInfo_NumberOfItems = productInfo_NumberOfItems;
	}

	public Integer getQuantityShipped() {
		return this.quantityShipped;
	}

	public void setQuantityShipped(Integer quantityShipped) {
		this.quantityShipped = quantityShipped;
	}

	public Integer getQuantityOrdered() {
		return this.quantityOrdered;
	}

	public void setQuantityOrdered(Integer quantityOrdered) {
		this.quantityOrdered = quantityOrdered;
	}

	public String getASIN() {
		return this.ASIN;
	}

	public void setASIN(String ASIN) {
		this.aSIN = aSIN;
	}

	public String getSellerSKU() {
		return this.sellerSKU;
	}

	public void setSellerSKU(String sellerSKU) {
		this.sellerSKU = sellerSKU;
	}

	public String getOrderItemId() {
		return this.orderItemId;
	}

	public void setOrderItemId(String orderItemId) {
		this.orderItemId = orderItemId;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}

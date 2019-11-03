public with sharing class Address {

    private String city;
    private String name;
    private String countryCode;
    private String stateOrRegion;
    private String addressLine1;
    private String addressLine2;
    private String postalCode;

    public Address(
        String city,
        String name,
        String countryCode,
        String stateOrRegion,
        String addressLine1,
        String addressLine2,
        String postalCode
    ) {
        this.city = city;
        this.name = name;
        this.countryCode = countryCode;
        this.stateOrRegion = stateOrRegion;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.postalCode = postalCode;
    }

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCountryCode() {
		return this.countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getStateOrRegion() {
		return this.stateOrRegion;
	}

	public void setStateOrRegion(String stateOrRegion) {
		this.stateOrRegion = stateOrRegion;
	}

	public String getAddressLine1() {
		return this.addressLine1;
	}

	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}

	public String getAddressLine2() {
		return this.addressLine2;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	public String getPostalCode() {
		return this.postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}





}

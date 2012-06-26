package com.stingapp.vidcon.sponsors;

public class Sponsor {
	private String name;
	private String twitter;
	private String image_description;
	private String description;

	
	public Sponsor(String name, String twitter, String image_description,
			String description, String image, String webSite) {
		super();
		this.name = name;
		this.twitter = twitter;
		this.image_description = image_description;
		this.description = description;
		this.image = image;
		this.webSite = webSite;
	}
	public String getName() {
		return name;
	}
	public String getTwitter() {
		return twitter;
	}
	public String getImage_description() {
		return image_description;
	}
	public String getDescription() {
		return description;
	}
	public String getImage() {
		return image;
	}
	public String getWebSite() {
		return webSite;
	}
	private String image; 
	private String webSite;
	
}

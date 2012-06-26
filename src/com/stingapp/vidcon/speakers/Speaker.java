package com.stingapp.vidcon.speakers;

import com.stingapp.vidcon.R;

import android.content.Context;
import android.graphics.drawable.Drawable;

public class Speaker {
	private String name;
	private String twitter;
	private String description;
	private String image;
	private Drawable picture;
	public Speaker(String name, String twitter, String description, String image) {
		this.name = name;
		this.twitter = twitter;
		this.description = description;
		this.image = image;
	}
	public Drawable getPicture(Context context) {
		if (picture == null) {
			picture = context.getResources().getDrawable(R.drawable.guests_icon);
		}
		return picture;
	}
	public String getPictureName() {
		return image;
	}
	public String getName() {
		return name;
	}
	public String getTwitter() {
		return twitter;
	}
	public String getDescription() {
		return description;
	}
}

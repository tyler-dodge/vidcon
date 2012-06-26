package com.stingapp.vidcon.sponsors;

import java.io.IOException;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.res.Resources;

import com.stingapp.vidcon.JsonReader;
import com.stingapp.vidcon.speakers.Speaker;

public class SponsorList extends JsonReader<Sponsor>  {

	public SponsorList(Resources resources, int id) throws IOException {
		super(resources, id);
	}
	
	private String getString(JSONObject object, String name) {
		String returnName = null;
		if (object.has(name)) {
			try {
				returnName = object.getString(name);
			} catch (JSONException exc) {
				returnName = "";
			}
		} else {
			returnName = "";
		}
		return returnName;
	}
	@Override
	public Sponsor convertJSON(JSONObject object) {
		String name = getString(object, "name");
		String twitter = getString(object, "twitter");
		String image_description = getString(object, "image-description");
		String description = getString(object, "description");
		String image = getString(object, "image"); 
		String webSite = getString(object, "website");
		return new Sponsor(name, twitter, image_description, description, image, webSite);
	}
}

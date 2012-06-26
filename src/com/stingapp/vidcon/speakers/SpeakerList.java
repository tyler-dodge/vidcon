package com.stingapp.vidcon.speakers;
import java.io.IOException;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.res.Resources;

import com.stingapp.vidcon.*;
public class SpeakerList extends JsonReader<Speaker>  {

	public SpeakerList(Resources resources, int id) throws IOException {
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
	public Speaker convertJSON(JSONObject object) {
		String name = getString(object, "name");
		String twitter = getString(object, "twitter");
		String description = getString(object, "description");
		String image = getString(object, "image"); 
		return new Speaker(name, twitter, description, image);
	}
}

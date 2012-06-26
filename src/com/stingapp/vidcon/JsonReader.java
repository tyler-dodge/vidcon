package com.stingapp.vidcon;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import android.content.res.Resources;

public abstract class JsonReader <T> {
	private JSONTokener json;
	private ArrayList<T> data = new ArrayList<T>();
	public JsonReader(Resources resources, int id) throws IOException {
		InputStream stream = resources.openRawResource(id);
		final char[] buffer = new char[0x10000];
		StringBuilder out = new StringBuilder();
		Reader in = new InputStreamReader(stream, "UTF-8");
		try {
		  int read;
		  do {
		    read = in.read(buffer, 0, buffer.length);
		    if (read>0) {
		      out.append(buffer, 0, read);
		    }
		  } while (read>=0);
		} finally {
		  in.close();
		}
		json = new JSONTokener(out.toString());
	}
	public T getObjectAtIndex(int index) {
		if (index>=data.size()) {
			int count = index-data.size() + 1;
			for (int i=0;i<count;i++) {
				try {
					data.add(convertJSON((JSONObject)json.nextValue()));
				} catch (JSONException e) {
					
				}
			}
			return data.get(data.size()-1);
		} else {
			return data.get(index);
		}
	}
	public abstract T convertJSON(JSONObject object);
}

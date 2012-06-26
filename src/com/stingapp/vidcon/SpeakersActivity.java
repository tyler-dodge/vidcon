package com.stingapp.vidcon;

import android.app.Activity;
import android.app.ListActivity;
import android.os.Bundle;
import com.stingapp.vidcon.speakers.*;
public class SpeakersActivity extends ListActivity {
	private SpeakerListAdapter adapter;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.speakers);
		adapter = new SpeakerListAdapter(this);
		this.setListAdapter(adapter);
	}
}

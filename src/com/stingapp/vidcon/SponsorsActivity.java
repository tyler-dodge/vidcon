package com.stingapp.vidcon;

import com.stingapp.vidcon.sponsors.SponsorListAdapter;

import android.app.ListActivity;
import android.os.Bundle;

public class SponsorsActivity extends ListActivity {
	private SponsorListAdapter adapter;
 	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sponsors);
		adapter = new SponsorListAdapter(this);
		setListAdapter(adapter);
	}
		
}

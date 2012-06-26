package com.stingapp.vidcon.businessCard;

import android.content.Context;
import android.widget.ArrayAdapter;

public class SavedBusinessCardsListAdapter extends ArrayAdapter<BusinessCard> {
	private Context context;
	public SavedBusinessCardsListAdapter(Context context, int textViewResourceId) {
		super(context, textViewResourceId);
		this.context = context;
	}

}

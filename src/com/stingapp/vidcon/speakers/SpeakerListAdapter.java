package com.stingapp.vidcon.speakers;

import java.io.IOException;

import org.json.JSONArray;

import com.stingapp.vidcon.R;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class SpeakerListAdapter extends BaseAdapter {
	private Context context;
	private SpeakerList list;
	public SpeakerListAdapter(Context context) {
		try {
			list = new SpeakerList(context.getResources(), R.raw.guests);
		} catch (IOException exc) {
			
		}
		this.context = context;
	}
	public View	getView(int position, View convertView, ViewGroup parent) {
		View newView = convertView;
		if (newView == null) {
			LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        	newView = inflater.inflate(R.layout.speaker_cell,null);
		}
		TextView name = (TextView) newView.findViewById(R.id.speakerName);
		name.setText(((Speaker)getItem(position)).getName());
		return newView;
	}
	public int getCount() {
		// TODO Auto-generated method stub
		return 178;
	}
	public Object getItem(int arg0) {
		return list.getObjectAtIndex(arg0);
	}
	public long getItemId(int arg0) {
		// TODO Auto-generated method stub
		return arg0;
	}
}
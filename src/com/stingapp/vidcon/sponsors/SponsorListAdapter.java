package com.stingapp.vidcon.sponsors;

import java.io.IOException;

import com.stingapp.vidcon.R;
import com.stingapp.vidcon.speakers.Speaker;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class SponsorListAdapter extends BaseAdapter {
	private Context context;
	private SponsorList list;
	public SponsorListAdapter(Context context) {
		super();
		this.context = context;
		try {
			this.list = new SponsorList(context.getResources(), R.raw.sponsors);
		} catch (IOException e) {
			
		}
	}
	public int getCount() {
		return 19;
	}
	public Object getItem(int arg0) {
		return list.getObjectAtIndex(arg0);
	}
	public long getItemId(int arg0) {
		return arg0;
	}
	public View getView(int position, View convertView, ViewGroup viewGroup) {
		View newView = convertView;
		if (newView == null) {
			LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        
			newView = inflater.inflate(R.layout.speaker_cell,null);
		}
		TextView name = (TextView) newView.findViewById(R.id.speakerName);
		name.setText(((Sponsor)getItem(position)).getName());
		return newView;
	}

}

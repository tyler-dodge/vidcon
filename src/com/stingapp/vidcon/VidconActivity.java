package com.stingapp.vidcon;


import android.app.TabActivity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.widget.TabHost;
import android.widget.TabHost.TabSpec;
public class VidconActivity extends TabActivity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        int id = this.getResources().getIdentifier("com.stingapp.vidcon:raw/guests.json", null, null);
        setContentView(R.layout.main);
        TabHost tabHost = getTabHost();
        
        // Tab for Photos
        TabSpec photospec = tabHost.newTabSpec("Speakers");
        // setting Title and Icon for the Tab
        photospec.setIndicator("Speakers", getResources().getDrawable(R.drawable.guests_icon));
        Intent photosIntent = new Intent(this, SpeakersActivity.class);
        photospec.setContent(photosIntent);
 
        // Tab for Songs
        TabSpec songspec = tabHost.newTabSpec("Business Card");
        songspec.setIndicator("Business Card", getResources().getDrawable(R.drawable.business_card_icon));
        Intent songsIntent = new Intent(this, BusinessCardActivity.class);
        songspec.setContent(songsIntent);
 
        // Tab for Videos
        TabSpec videospec = tabHost.newTabSpec("Sponsors");
        videospec.setIndicator("Sponsors", getResources().getDrawable(R.drawable.sponsors_icon));
        Intent videosIntent = new Intent(this, SponsorsActivity.class);
        videospec.setContent(videosIntent);
 
        // Adding all TabSpec to TabHost
        tabHost.addTab(photospec); // Adding photos tab
        tabHost.addTab(songspec); // Adding songs tab
        tabHost.addTab(videospec); // Adding videos tab
    }
}
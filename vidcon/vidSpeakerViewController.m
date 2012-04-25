//
//  vidSpeakerViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 4/13/12.
//  Copyright (c) 2012 Sting Apps. All rights reserved.
//

#import "vidSpeakerViewController.h"
#import "vidSpeakerCell.h"

@interface vidSpeakerViewController ()

@end

@implementation vidSpeakerViewController
@synthesize model = _model;

-(vidSpeakerModel *)model
{
    if (!_model)
        _model = [[vidSpeakerModel alloc] initWithJsonFile:@""];
    return _model;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.model.speakerCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpeakerCell";
    vidSpeakerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    vidSpeaker * speaker =[self.model speakerAtIndexPath:indexPath];
    cell.nameLabel.text = speaker.name;
    cell.descriptionLabel.text = speaker.shortDescription;
    cell.imageView.image = speaker.image;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:1.0 animations:^{
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    }];
}

@end

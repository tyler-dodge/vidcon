//
//  vidSpeakerViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 4/13/12.
//  Copyright (c) 2012 Sting Apps. All rights reserved.
//

#import "vidSpeakerViewController.h"
#import "vidSpeakerCell.h"
#import "vidSelectedSpeakerViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface vidSpeakerViewController () <UISearchDisplayDelegate>
@property (strong, nonatomic) vidSpeaker * selectedSpeaker;
@end

@implementation vidSpeakerViewController
@synthesize model = _model;
@synthesize speakerSearchController = _speakerSearchController;
@synthesize selectedSpeaker = _selectedSpeaker;
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
    [self setSpeakerSearchController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        // Return the number of sections.
        return [self.model numberOfSections];
    } else {
        return self.model.searchResults.count > 0 ? 1 : 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        // Return the number of rows in the section.
        return [self.model speakersInSection:section];
    } else {
        return self.model.searchResults.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpeakerCell";
    static NSString *CellIdentifierAlt = @"SpeakerCellALT";
    vidSpeakerCell *speakerCell = nil;
    
    vidSpeaker * speaker = nil;
    if (tableView==self.tableView) {
        speaker=[self.model speakerAtIndexPath:indexPath];
    } else {
        speaker = [self.model.searchResults objectAtIndex:[indexPath indexAtPosition:1]];
    }
    
    if (speaker.index % 2 == 0) {
        speakerCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    } else {
        speakerCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierAlt];
    }
    speakerCell.picture.clipsToBounds = YES;
    //speakerCell.imageView.layer.masksToBounds= YES;
    if (tableView==self.tableView) {
        speakerCell.backgroundImage.hidden=NO;
    } else {
        speakerCell.backgroundImage.hidden=YES;
    }
    speakerCell.nameLabel.text = speaker.name;
    speakerCell.picture.image = speaker.image;
    speakerCell.picture.layer.borderColor = [UIColor blackColor].CGColor;
    speakerCell.picture.layer.borderWidth = 1;
    speakerCell.picture.layer.masksToBounds = YES;
    return speakerCell;
}

#pragma mark - Table view delegate
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return 77;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        self.selectedSpeaker = [self.model speakerAtIndexPath:indexPath];
        [UIView animateWithDuration:1.0 animations:^{
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.  width, cell.frame.size.height);
        }];
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        self.selectedSpeaker = [self.model speakerAtIndexPath:indexPath];
    } else if ([indexPath indexAtPosition:1] < self.model.searchResults.count) {
        self.selectedSpeaker = [self.model.searchResults objectAtIndex:[indexPath indexAtPosition:1]];
    }
    return indexPath;
}

-(void)setSpeakerSearchController:(UISearchDisplayController *)speakerSearchController
{
    _speakerSearchController = speakerSearchController;
    _speakerSearchController.searchResultsDataSource = self;
    _speakerSearchController.delegate = self;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return [[NSArray alloc] initWithObjects:
                @"{search}",
                @"A",@"B",@"C",
                @"D",@"E",@"F",
                @"G",@"H",@"I",
                @"J",@"K",@"L",
                @"M",@"N",@"O",
                @"P",@"Q",@"R",
                @"S",@"T",@"U",
                @"V",@"W",@"X",
                @"Y",@"Z",nil];
    } else {
        return nil;
    }
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0) {
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
    return index - 1;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[vidSelectedSpeakerViewController class]]) {
        vidSelectedSpeakerViewController * selected = segue.destinationViewController;
        selected.speaker = self.selectedSpeaker;
    }
}

-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    [self.model startSearch];
}
-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [self.model endSearch];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSInteger count = self.model.searchResults.count;
    [self.model updateSearch:searchString];
    return count != self.model.searchResults.count;
}
-(void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    [self.model startSearch];
}
@end

//
//  vidSponsorViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 5/30/12.
//
//

#import "vidSponsorViewController.h"
#import "vidSponsor.h"
#import "vidSponsorCell.h"
#import "vidSelectedSponsorViewController.h"
#define YOUTUBE_IDENTIFIER @"youtube"
#define MAKER_IDENTIFIER @"maker"
#define PLATINUM_IDENTIFIER @"platinum"
#define GOLD_IDENTIFIER @"gold"
#define NORMAL_IDENTIFIER @"normal"

@interface vidSponsorViewController ()
@property (weak, nonatomic) vidSponsor * selectedSponsor;
@end

@implementation vidSponsorViewController
@synthesize DiamondSponsors = _DiamondSponsors;
@synthesize PlatinumSponsors = _PlatinumSponsors;
@synthesize GoldSponsors = _GoldSponsors;
@synthesize NormalSponsors = _NormalSponsors;
@synthesize selectedSponsor = _selectedSponsor;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    vidSponsor * sponsor = nil;
    switch ([indexPath indexAtPosition:0]) {
        case YOUTUBE_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:YOUTUBE_IDENTIFIER];
            sponsor = [self.DiamondSponsors objectAtIndex:0];
            break;
        case MAKER_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:MAKER_IDENTIFIER];
            sponsor = [self.DiamondSponsors objectAtIndex:0];
            break;
        case PLATINUM_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:PLATINUM_IDENTIFIER];
            sponsor = [self.PlatinumSponsors objectAtIndex:[indexPath indexAtPosition:1]];
            break;
        case GOLD_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:GOLD_IDENTIFIER];
            sponsor = [self.GoldSponsors objectAtIndex:[indexPath indexAtPosition:1]];
            break;
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:NORMAL_IDENTIFIER];
            sponsor = [self.NormalSponsors objectAtIndex:[indexPath indexAtPosition:1]];
            break;
    }
    if ([indexPath indexAtPosition:0] != YOUTUBE_SECTION && [indexPath indexAtPosition:0] != MAKER_SECTION) {
        vidSponsorCell * sponsorCell = (vidSponsorCell *)cell;
        sponsorCell.picture.image = sponsor.picture;
        sponsorCell.name.text = sponsor.name;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case YOUTUBE_SECTION:
        case MAKER_SECTION:
            return 1;
            break;
        case PLATINUM_SECTION:
            return self.PlatinumSponsors.count;
            break;
        case GOLD_SECTION:
            return self.GoldSponsors.count;
            break;
        default:
            return self.NormalSponsors.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 5;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath indexAtPosition:0]) {
        case YOUTUBE_SECTION:
            self.selectedSponsor = [self.DiamondSponsors objectAtIndex:1];
            break;
        case MAKER_SECTION:
            self.selectedSponsor = [self.DiamondSponsors objectAtIndex:0];
            break;
        case PLATINUM_SECTION:
            self.selectedSponsor = [self.PlatinumSponsors objectAtIndex:[indexPath indexAtPosition:1]];
            break;
        case GOLD_SECTION:
            self.selectedSponsor = [self.GoldSponsors objectAtIndex:[indexPath indexAtPosition:1]];
            break;
        case NORMAL_SECTION:
            self.selectedSponsor = [self.NormalSponsors objectAtIndex:[indexPath indexAtPosition:1]];
            break;
    }
    return indexPath;
}
-(void)viewDidLoad
{
    NSError * error;
    NSArray * listOfSpeakerDictonaries = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sponsors" ofType:@"json"]] options:0 error:&error];
    NSMutableArray * diamond = [[NSMutableArray alloc] init];
    NSMutableArray * platinum = [[NSMutableArray alloc] init];
    NSMutableArray * gold = [[NSMutableArray alloc] init];
    NSMutableArray * normal = [[NSMutableArray alloc] init];
    for (NSDictionary * dictionary in listOfSpeakerDictonaries) {
        vidSponsor * sponsor = [[vidSponsor alloc] initWithJsonDictionary:dictionary];
        switch (sponsor.speakerType) {
            case YOUTUBE_SECTION:
            case MAKER_SECTION:
                [diamond addObject:sponsor];
                break;
            case PLATINUM_SECTION:
                [platinum addObject:sponsor];
                break;
            case GOLD_SECTION:
                [gold addObject:sponsor];
                break;
            case NORMAL_SECTION:
                [normal addObject:sponsor];
                break;
        }
    }
    self.DiamondSponsors = diamond;
    self.PlatinumSponsors = platinum;
    self.GoldSponsors = gold;
    self.NormalSponsors = normal;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[vidSelectedSponsorViewController class]]) {
        vidSelectedSponsorViewController * controller = (vidSelectedSponsorViewController *)segue.destinationViewController;
        controller.sponsor = self.selectedSponsor;
    }
}
@end

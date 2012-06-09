//
//  vidSponsorViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 5/30/12.
//
//

#import "vidSponsorViewController.h"
#define YOUTUBE_IDENTIFIER @"youtube"
#define MAKER_IDENTIFIER @"maker"
#define PLATINUM_IDENTIFIER @"platinum"
#define GOLD_IDENTIFIER @"gold"
#define YOUTUBE_SECTION 0
#define MAKER_SECTION 1
#define PLATINUM_SECTION 2
#define GOLD_SECTION 3

@interface vidSponsorViewController ()

@end

@implementation vidSponsorViewController
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    switch ([indexPath indexAtPosition:0]) {
        case YOUTUBE_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:YOUTUBE_IDENTIFIER];
            break;
        case MAKER_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:MAKER_IDENTIFIER];
            break;
        case PLATINUM_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:PLATINUM_IDENTIFIER];
            break;
        case GOLD_SECTION:
            cell = [tableView dequeueReusableCellWithIdentifier:GOLD_IDENTIFIER];
            break;
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:PLATINUM_IDENTIFIER];
            break;
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
            return 3;
            break;
        case GOLD_SECTION:
            return 3;
            break;
        default:
            return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 4;
}
-(void)viewDidLoad
{
}
@end

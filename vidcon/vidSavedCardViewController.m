//
//  vidSavedCardViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/15/12.
//
//

#import "vidSavedCardViewController.h"
#import "vidBusinessCard.h"
#import "vidSelectedSpeakerViewController.h"
@interface vidSavedCardViewController ()
@property (strong, nonatomic) vidBusinessCard * selectedCard;
@end

@implementation vidSavedCardViewController

@synthesize selectedCard = _selectedCard;
@synthesize cards = _cards;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BusinessCardOwner";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    vidBusinessCard * card = [[vidBusinessCard alloc] initWithJsonDictionary:[self.cards objectAtIndex:[indexPath indexAtPosition:1]]];
    cell.detailTextLabel.text = card.twitter;
    cell.textLabel.text = card.name;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.	
    return YES;
}
*/
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCard = [[vidBusinessCard alloc] initWithJsonDictionary:[self.cards objectAtIndex:[indexPath indexAtPosition:1]]];
    return indexPath;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[vidSelectedSpeakerViewController class]]) {
        vidSelectedSpeakerViewController * selected = (vidSelectedSpeakerViewController *)segue.destinationViewController;
        selected.speaker = [self.selectedCard toVidSpeaker];
    }
}

@end

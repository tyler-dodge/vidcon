//
//  vidMapViewController.h
//  vidcon
//
//  Created by Tyler Dodge on 6/13/12.
//
//

#import <UIKit/UIKit.h>

@interface vidMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *mapView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImage * image;
@property (strong, nonatomic) NSString * mapName;
@end

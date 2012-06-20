//
//  vidFaqController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/12/12.
//
//

#import "vidFaqController.h"

@interface vidFaqController ()

@end

@implementation vidFaqController
@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id webView = self.webView;
    [webView loadHTMLString:@"<html><head><style>h1 { \
                         display:block; \
     font-size: 16px; \
     font-weight: bold; \
     border-bottom: 1px solid #666; \
                         padding: 10px; \
     padding-bottom: 1px; \
     margin-bottom: 20px; \
     } \
      \
     q { \
         font-weight: bold; \
     display: block; \
         border-left: 5px solid #AAA; \
         padding-left: 15px; \
         margin-bottom: 5px; \
     color: #333; \
     } \
     \
     ans { \
     display: block; \
         margin-bottom: 20px; \
         margin-left: 6px;    \
     }\
     \
     body { \
         font-family: Helvetica; \
         line-height: 22px;   \
     color: #232323;         \
     }​</style></head><body><h1>FAQ<br /> \
     Your Questions answered (before you’ve even asked them)...</h1>  <q>I am a person with needs, and chief among them is wifi. Help Me! </q><ans>There is free wifi at the Anaheim Convention Center, but it is not very good. It’s quite possible that our insatiable desires may not be met by it. For this, we apologize. However, unlike last year, your mobile phone should work wherever you are.</ans><q>When the heck am I supposed to eat? </q><ans>This year we decided not to have special times for things as boring as eating food. However, we would like to encourage you to, like, eat, because otherwise you might die. There are lots of places to eat around, both quick and slow, fancy and sloppy, cheap and expensive. There’s even a couple of eateries within the venue. So get some energy bars and enjoy yourself.  </ans><q>I want to share my VidCon experience with the world, how will I get it seen? </q><ans>Please-o-please tag all of your videos, facebooks, tweets, pins, instagrams, plus ones, etc with “VidCon.”  </ans><q>How can I sneak my friend/self into VidCon? </q><ans>We must politely ask that you not sneak anyone in to VidCon, because that would make you a bad person. Everyone at this conference paid to get in. So sneaking in would be, like, really tacky and stuff. Also, it is very hard to do and when we catch you it will be really uncomfortable for you (who will feel bad) and for us (who will also feel bad.)  </ans><q>So, this is freaking awesome, will you do it again next year? </q><ans>Yes indeed. Follow us on Twitter or YouTube to make sure you don’t miss out on the early bird tickets.  </ans><q>What do I do if I want to do two things at once? </q><ans>Time turner...obviously.  </ans><q>Who are the folks in the different colored VidCon tshirts? </q><ans>Aha — you’ve spotted the Mods and Admins. In the red shirts are this year’s team of volunteers who are on hand to answer questions and point you in the right direction. In the blue are the staff members who have worked to make VidCon happen. And they have walkie-talkies. Respect.</body></html>"  baseURL:[NSURL URLWithString:@""]];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

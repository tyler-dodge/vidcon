
//
//  vidDosAndDontsViewController.m
//  vidcon
//
//  Created by Tyler Dodge on 6/14/12.
//
//

#import "vidDosAndDontsViewController.h"

@interface vidDosAndDontsViewController ()

@end

@implementation vidDosAndDontsViewController
@synthesize webView = _webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadHTMLString:@"<html><head><style>h1 { \
                         display:block; \
     font-size: 18px; \
     font-weight: bold; \
     border-bottom: 1px solid #666; \
                         padding: 10px; \
     padding-bottom: 1px; \
     margin-bottom: 10px; \
     } \
     do { \
         margin-left: -9px; \
         border-bottom: 2px solid green; \
         font-weight: bold; \
     color: #333; \
     } \
     do-block { \
         margin-left: 10px; \
     display:block; \
         margin-bottom: 15px; \
     } \
     dont { \
         margin-left: -9px; \
         border-bottom: 2px solid red; \
         font-weight: bold; \
     color: #333; \
     } \
     dont-block { \
         margin-left: 10px; \
     display:block; \
         margin-bottom: 15px; \
     } \
     body { \
         font-family: Helvetica; \
         line-height: 22px;   \
     color: #232323;    \
     }​</style></head><body><h1>Do’s and Don’ts of VidCon</h1> \
     <p> \
     <do-block><do>DO</do> engage with your fellow fans and creators in meaningful and respectful ways, but remember that everyone else is, like, totally just a person. And, in fact, making videos for YouTube can actually be a very introspective activity. Lots of video creators are absolutely terrified of public speaking and crowds. But they come to VidCon and they face those fears because it's all worth it for one weekend of awesome. So be friendly, but be respectful.</do-block><dont-block><dont>DON'T</dont> forget that all of us love online video, and we're all here to see each other and have a good time. If you must SQUEE, please SQUEE (we have a hard time avoiding the urge sometimes as well), but not in anyone's face.  </dont-block><do-block><do>DO</do> walk up to people you have never seen before in real life and engage them in conversation.</do-block><dont-block><dont>DON'T</dont> walk up to people you have never seen before in real life and engage them in matrimony.  </dont-block><do-block><do>DO</do> take this opportunity to realize that, OMG, we're all just people coming together to bask in the glory of a thing that we created together entirely because we thought it was awesome.</do-block><dont-block><dont>DON'T</dont> hump Hank. Also, don't ask Hank to hump you... he is married, and his wife is at the conference. Hank will hump things when AND ONLY WHEN he feels like it.  </dont-block><do-block><do>DO</do> be conscious that, while 90% of the guests at this hotel are here for VidCon, some of them are just normal people who would rather not be woken up at 3 AM by someone sprinting down the hallway screaming “SHANAYNAY WINS EVERY RACE!”</do-block><dont-block><dont>DON'T</dont> (please please) put us in a position where we will have to throw you out of the conference, no one wants that. Things to avoid at all costs include: Lighting things on fire, terrorism, creepsterosity, pantslessness, ferocious idiocy, or doing anything illegal.  </dont-block><do-block><do>DO</do> let us know if you witness pantslessness, creepsterosity, pantslessness, ferocious idiocy, or anything illegal. Or really, just if you feel like anything is odd, there will be staff (Admins) and volunteers (Mods) all over the place. \
     </p>​</body></html>" baseURL:[NSURL URLWithString:@""]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end

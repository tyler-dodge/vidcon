/*
 vidAppDelegate.h
 
 This file is part of vidcon.
 Copyright (C) 2012 Sting Apps.
 
 vidcon is free software; you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by the
 Free Software Foundation; either version 3 of the License, or (at your
 option) any later version.
 
 vidcon is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along
 with vidcon.  If not, see <http://www.gnu.org/licenses/>.
 */

#import <UIKit/UIKit.h>
@class vidAppDelegate;
@protocol vidNewsDelegate
@optional
-(void)vidAppDelegate:(vidAppDelegate *)delegate;
@end
@interface vidAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) dispatch_queue_t parseQueue;
@property (weak, atomic) id<vidNewsDelegate> newsDelegate;
@property (strong, nonatomic) UIWindow *window;
@property (atomic) BOOL shouldReloadNews;
@end

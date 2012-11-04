//
//  AppDelegate.h
//  SRPG
//
//  Created by masa on 12/03/13.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@class SRFieldScene;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    SRFieldScene *fieldScene;
}

@property (nonatomic, retain) UIWindow *window;

@end

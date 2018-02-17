//
//  AppDelegate.h
//  incorrect
//
//  Created by Administrator on 12. 12. 27..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "LoadLayer.h"

extern NSString *const FBSessionStateChangedNotification;

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate, FBLoginViewDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    UITextField *TextField;
    UIAlertView *Alert;
    LoadLayer *loadLayer;
    NSString *sver;
    dispatch_queue_t queue;
    
}

@property (nonatomic, retain) UIWindow *window;
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end

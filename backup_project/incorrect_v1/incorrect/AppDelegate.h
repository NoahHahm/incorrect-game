//
//  AppDelegate.h
//  incorrect
//
//  Created by Administrator on 12. 12. 27..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    UITextField *TextField;
    UIAlertView *Alert;
}

@property (nonatomic, retain) UIWindow *window;

@end

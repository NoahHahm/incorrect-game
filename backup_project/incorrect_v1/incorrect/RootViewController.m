//
//  RootViewController.m
//  incorrect
//
//  Created by Administrator on 12. 12. 27..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

//
// RootViewController + iAd
// If you want to support iAd, use this class as the controller of your iAd
//

#import "cocos2d.h"

#import "RootViewController.h"
#import "GameConfig.h"

@implementation RootViewController

// Override to allow orientations other than the default portrait orientation
//valid for iOS 4 and 5, IMPORTANT, for iOS6 also modify supportedInterfaceOrientations
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
    //
	// There are 2 ways to support auto-rotation:
	//  - The OpenGL / cocos2d way
	//     - Faster, but doesn't rotate the UIKit objects
	//  - The ViewController way
	//    - A bit slower, but the UiKit objects are placed in the right place
	//
	
#if GAME_AUTOROTATION==kGameAutorotationNone
	//
	// EAGLView won't be autorotated.
	// Since this method should return YES in at least 1 orientation, 
	// we return YES only in the Portrait orientation
	//
	//return ( interfaceOrientation == UIInterfaceOrientationPortrait );
    return ( interfaceOrientation == UIInterfaceOrientationPortrait );
	
#elif GAME_AUTOROTATION==kGameAutorotationCCDirector
	//
	// EAGLView will be rotated by cocos2d
	//
	// Sample: Autorotate only in landscape mode
	//
	if( interfaceOrientation == UIInterfaceOrientationLandscapeLeft ) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeLeft];
	} else if( interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeLeft];
	}
	
	// Since this method should return YES in at least 1 orientation, 
	// we return YES only in the Portrait orientation
	return ( interfaceOrientation == UIInterfaceOrientationPortrait );
	
#elif GAME_AUTOROTATION == kGameAutorotationUIViewController
	//
	// EAGLView will be rotated by the UIViewController
	//
	// Sample: Autorotate only in portrait mode
	//
	// return YES for the supported orientations
	
	return UIInterfaceOrientationIsLandscape(interfaceOrientation)  
;
    
#else
#error Unknown value in GAME_AUTOROTATION
	
#endif // GAME_AUTOROTATION
	
	// Shold not happen
	return NO;
}

// these methods are needed for iOS 6
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

-(NSUInteger)supportedInterfaceOrientations{
    //Modify for supported orientations, put your masks here, trying to mimic behavior of shouldAutorotate..
    #if GAME_AUTOROTATION==kGameAutorotationNone
	    return UIInterfaceOrientationMaskPortrait;
    #elif GAME_AUTOROTATION==kGameAutorotationCCDirector
    	NSAssert(NO, @"RootviewController: kGameAutorotation isn't supported on iOS6");
	    return UIInterfaceOrientationMaskLandscape;
    #elif GAME_AUTOROTATION == kGameAutorotationUIViewController
    	return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    	//for both landscape orientations return UIInterfaceOrientationLandscape
    #else 
    #error Unknown value in GAME_AUTOROTATION
	
	#endif // GAME_AUTOROTATION
}

#if GAME_AUTOROTATION==kGameAutorotationUIViewController
- (BOOL)shouldAutorotate {
    return NO;
}
#else 
- (BOOL)shouldAutorotate {
    return NO;
}
#endif

//__IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
#else //deprecated in iOS6, so call only < 6. 
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#endif //__IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
#endif 

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}
@end

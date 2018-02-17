//
//  AppDelegate.m
//  incorrect
//
//  Created by Administrator on 12. 12. 27..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "MainLayer.h"
#import "RootViewController.h"
#import "ServiceApi.h"
#import "ImageDownCore.h"
#import "GameScreenLayer.h"
#import "Singleton.h"
#import "SqlLiteCore.h"

NSString *const FBSessionStateChangedNotification = @"com.itholicer.incorrect:FBSessionStateChangedNotification";

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBSession.activeSession handleOpenURL:url];
}


- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[appDelegate openSessionWithAllowLoginUI:YES];
    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	    
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
    
	// Sets landscape mode
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
    
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
    
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
    //Required in iOS6, recommended in 4 and 5
    [window setRootViewController:viewController];
        
	// make the View Controller a child of the main window, needed for iOS 4 and 5
	[window addSubview:viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
    
    loadLayer = [[LoadLayer alloc] init];
    
    //[[CCDirector sharedDirector] runWithScene:[CCInfoLayer scene]];
    // 업데이트 체크
    [self Update];
        
    FBSession* session = [[FBSession alloc] init];
    [FBSession setActiveSession: session];
        
}

- (void) getCoordinate {
    SqlLiteCore *db = [[SqlLiteCore alloc] init];
    BOOL clearresult = [db clearDB];
    if (clearresult == true) {
        BOOL result = [db insertData:[ServiceApi getCoordinate]];
        if (result == true) {
            NSLog(@"갱신 성공");
        }
    }
}

- (void) getlistManage {
    [GameScreenLayer setIndexArray:[ServiceApi getlistManageId]];
}

- (void) setFirstUser {
    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    if (username == nil) {
        
        TextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, 260, 40)];
        TextField.backgroundColor = [UIColor whiteColor];
        
        Alert = [[UIAlertView alloc] initWithTitle:@"이름을 입력해주세요!"
                                           message:@"최초 사용자 이름을 입력하세요.\n\n\n"
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"확인", nil];
        [Alert addSubview:TextField];
        [Alert show];
        
    }
}

- (void)loadingSceneProc {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
	EAGLContext *k_context = [[[EAGLContext alloc]
                               initWithAPI :kEAGLRenderingAPIOpenGLES1
                               sharegroup:[[[[CCDirector sharedDirector] openGLView] context] sharegroup]] autorelease];
	[EAGLContext setCurrentContext:k_context];

    
    NSString *ver = [[NSUserDefaults standardUserDefaults] valueForKey:@"version"];
    
    
    //좌표 데이터 갱싱
    [self getCoordinate];
    
    //초기사용자 이미지 다운
    [self initImageDown];
    
    //번호 넣기
    [self getlistManage];
    
    //유저 랭크 정보
    [MainLayer setUserDictionary:[ServiceApi GetUserRankList]];
    
    sver = [ServiceApi getVerCheck];
    NSMutableArray *arr = [ServiceApi updateData:ver];
    
    if (ver != nil) {
        if (![sver isEqualToString:ver]) {
            
            //업데이트 진행
            NSLog(@"틀렸습니다. 현재버전 : %@ / 서버 버전 : %@", ver, sver);
            
            ImageDownCore *core = [[ImageDownCore alloc] init];
            
            NSData *imgData;
            for(BasicAppInfo *info in arr) {
                
                imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Hd_url]];
                [core saveData:imgData :[NSString stringWithFormat:@"%@-hd", info.Manage_id]];
                
                imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Url]];
                [core saveData:imgData :[NSString stringWithFormat:@"%@", info.Manage_id]];
                
                imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Falult_hd_url]];
                [core saveData:imgData :[NSString stringWithFormat:@"%@_f-hd", info.Manage_id]];
                
                imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Falult_url]];
                [core saveData:imgData :[NSString stringWithFormat:@"%@_f", info.Manage_id]];
            }
            [[NSUserDefaults standardUserDefaults] setObject:[ServiceApi getVerCheck] forKey:@"version"];
        }
    }
    [self performSelectorOnMainThread:@selector(MainThread) withObject:nil waitUntilDone:YES];
	[pool release];
}

- (void) MainThread {
    loadLayer.view.hidden = true;
    [[CCDirector sharedDirector] runWithScene:[MainLayer scene]];
    [self setFirstUser];
}
- (void) Update {
    [[[CCDirector sharedDirector] openGLView] insertSubview:loadLayer.view atIndex:0];
    NSThread* thread = [[[NSThread alloc] initWithTarget:self selector:@selector(loadingSceneProc) object:nil] autorelease];
	[thread start];  
}

- (void) initImageDown {
    
    ImageDownCore *core = [[ImageDownCore alloc] init];
    
    BOOL init = [[NSUserDefaults standardUserDefaults] valueForKey:@"init"];
    NSString *ver = [[NSUserDefaults standardUserDefaults] valueForKey:@"version"];
    
    if (init == false && ver == nil) {
        
        
        NSMutableArray *arr = [ServiceApi getParserInitDataParser];
        
        NSData *imgData;
        
        for(BasicAppInfo *info in arr) {
            NSLog(@"[DEBUG : init Image DownLoading...]");
            
            imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Hd_url]];
            [core saveData:imgData :[NSString stringWithFormat:@"%@-hd", info.Manage_id]];
            
            //imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Url]];
            //[core saveData:imgData :[NSString stringWithFormat:@"%@", info.Manage_id]];
            
            imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Falult_hd_url]];
            [core saveData:imgData :[NSString stringWithFormat:@"%@_f-hd", info.Manage_id]];
            
            //imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.Falult_url]];
            //[core saveData:imgData :[NSString stringWithFormat:@"%@_f", info.Manage_id]];
        }
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"init"];
        [[NSUserDefaults standardUserDefaults] setObject:[ServiceApi getVerCheck] forKey:@"version"];
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (TextField.text.length <= 0) {
            [alertView show];
        }
        else {
            bool result = [ServiceApi SetSignUser:TextField.text];
            if (result == true) {
                [[NSUserDefaults standardUserDefaults] setValue:TextField.text forKey:@"username"];
            }
            else {
                [alertView setTitle:@"사용자가 이미 존재합니다.!"];
                [alertView show];
            }
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
    
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	[director end];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
    NSLog(@"dealloc");
	[super dealloc];
}

@end

//
//  HelloWorldLayer.m
//  brain
//
//  Created by Administrator on 12. 9. 24..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//


// Import the interfaces
#import "indexLayer.h"
#import "GameLayer.h"
#import "GameScore.h"
#import "SimpleAudioEngine.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FontManager.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#define ADMOB_PUBLISHER_ID @"a1508bd4bf79ae0"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation indexLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	indexLayer *layer = [indexLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        

        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray	*language = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [language objectAtIndex:0];
        if([currentLanguage isEqualToString:@"ko"] || [currentLanguage isEqualToString:@"en"])
            fontName = [NSString stringWithString:@"BareunDotum"];
        else
            fontName = [NSString stringWithString:@"Marker Felt"];

        sqllite *db = [[sqllite alloc] init];
        [db createSQL];
        [db addsql:0];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        PlayBackState = [[MPMusicPlayerController iPodMusicPlayer] playbackState];
        if(PlayBackState != MPMusicPlaybackStatePlaying)
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Loop_music.wav" loop:YES];            
        }
        
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 520, 320, 50)];
            WallPaper = [CCSprite spriteWithFile:@"Speech_index.png" rect:CGRectMake(0, 0, 640, 1136)];
            Switch = [[UISwitch alloc] initWithFrame: CGRectMake(size.width-80, size.height-515, 0, 0)];
            
        } else {
            bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 430, 320, 50)];
            WallPaper = [CCSprite spriteWithFile:@"Speech_index.png" rect:CGRectMake(0, 0, 320, 480)];
            Switch = [[UISwitch alloc] initWithFrame: CGRectMake(size.width-80, size.height-475, 0, 0)];

        }
        UIViewController *controller = [[UIViewController alloc] init];
        
        
        bannerView.adUnitID = ADMOB_PUBLISHER_ID;
        bannerView.rootViewController = controller;
        
        [bannerView loadRequest:[GADRequest request]];
        [controller.view addSubview:bannerView];
        
        [[[CCDirector sharedDirector] openGLView] insertSubview:controller.view atIndex:0];
     
        
        WallPaper.anchorPoint = ccp(0,0);
        [self addChild: WallPaper];
        
        CCSprite *_Green_btn_Nomal = [CCSprite spriteWithFile:@"Green-Hover.png" rect:CGRectMake(0, 0, 135, 70)];
        CCSprite *_Green_btn_Select = [CCSprite spriteWithFile:@"Green-Active.png" rect:CGRectMake(0, 0, 135, 70)];
        CCSprite *_Pinky_btn_Nomal = [CCSprite spriteWithFile:@"Pinky-Hover.png" rect:CGRectMake(0, 0, 135, 70)];
        CCSprite *_Pinky_btn_Select = [CCSprite spriteWithFile:@"Pinky-Active.png" rect:CGRectMake(0, 0, 135, 70)];
        CCSprite *_icon_Spiker = [CCSprite spriteWithFile:@"Sound.png" rect:CGRectMake(0, 0, 50, 41)];
        CCSprite *_index_btn = [CCSprite spriteWithFile:@"index_btn_muji.png" rect:CGRectMake(0, 0, 251, 218)];
        _icon_Spiker.position = ccp(size.width-115, size.height/2+220);
        [self addChild:_icon_Spiker];
        
        _index_btn.position = ccp(size.width/2, size.height/2+50);
        [self addChild:_index_btn];
        
        
        CCLabelTTF *_index_label_01 = [CCLabelTTF labelWithString:NSLocalizedString(@"산수", @"산수") fontName:fontName fontSize:50];
        
        CCLabelTTF *_index_label_02 = [CCLabelTTF labelWithString:NSLocalizedString(@"암산왕", @"암산왕") fontName:fontName fontSize:45];
        
        _index_label_01.position =ccp(size.width/2, size.height/2+100);
        _index_label_02.position =ccp(size.width/2, size.height/2+20);
        _index_label_02.color = ccc3(254,255,189);
        
        [self addChild:_index_label_01];
        [self addChild:_index_label_02];
        
        [Switch setOn:YES animated:YES];
        [[[CCDirector sharedDirector] view] addSubview:Switch];
      
        
        CCLabelTTF *_Start_label = [CCLabelTTF labelWithString:NSLocalizedString(@"게임시작", @"게임시작") fontName:fontName fontSize:23];
        
        CCLabelTTF *_Score_label = [CCLabelTTF labelWithString:NSLocalizedString(@"점수확인", @"점수확인") fontName:fontName fontSize:23];
        
        
        CCMenuItem *_Start = [CCMenuItemSprite itemWithNormalSprite:_Green_btn_Nomal selectedSprite:_Green_btn_Select block:^(id sender) {
                [bannerView removeFromSuperview];
                [Switch removeFromSuperview];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0f scene:[GameLayer scene]]];
        }];        
        
        CCMenuItem *_Score = [CCMenuItemSprite itemWithNormalSprite:_Pinky_btn_Nomal selectedSprite:_Pinky_btn_Select block:^(id sender) {
            [bannerView removeFromSuperview];
            [Switch removeFromSuperview];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0f scene:[GameScore scene]]];
            
            
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:_Start, _Score, nil];
        [menu alignItemsHorizontally];
        menu.position = ccp(size.width/2,size.height/2-170);
        //NSLog(@"%f %f", menu.position.x/3, menu.position.y/3);
		[self addChild: menu];      
    
        
        
		_Start_label.position =  ccp(size.width/2-70 ,size.height/2-170);
		_Score_label.position =  ccp(size.width/2+70 ,size.height/2-170);
		
		[self addChild:_Start_label];
		[self addChild:_Score_label];
        
        [self schedule:@selector(update:)];


	}
	return self;
}
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *Touch = [touches anyObject];
    CGPoint tempPoint = [Touch locationInView:[Touch view]];
    NSLog(@"%lf %lf", tempPoint.x, tempPoint.y);
}
- (void) dealloc
{
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) GameLayer {
    [[CCDirector sharedDirector] runWithScene: [GameLayer scene]];    
}
- (void)update:(ccTime)dt
{
    if(PlayBackState != MPMusicPlaybackStatePlaying)
    {
        if (![Switch isOn])
        {
            if (SoundState == 1)[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            SoundState = 0;
        }
        else {
            if (SoundState == 0)[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Loop_music.wav" loop:YES];
            SoundState = 1;
        }        
    }   
}
-(void)gameLogic:(ccTime)dt
{
    
}
@end

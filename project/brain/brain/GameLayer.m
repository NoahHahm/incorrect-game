//
//  GameLayer.m
//  brain
//
//  Created by Administrator on 12. 9. 24..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "Question.h"
#import "GameEnd.h"
#import "lib/GlobalVar.h"
#import <UIKit/UIKit.h>
#import "SimpleAudioEngine.h"


#define ADMOB_PUBLISHER_ID @"a1508bd4bf79ae0"
@implementation GameLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init]) ) {
        
        UIViewController *controller = [[UIViewController alloc] init];
        
    
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray	*language = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [language objectAtIndex:0];
        if([currentLanguage isEqualToString:@"ko"] || [currentLanguage isEqualToString:@"en"])
            fontName = [NSString stringWithString:@"BareunDotum"];
        else
            fontName = [NSString stringWithString:@"Marker Felt"];
        
        //초기화
        Correct_Count = 0;
        Correct_Str = @"";
        G_Var = [GlobalVar sharedInstance];
        QS = [[Question alloc] init];
        G_Var.Correct_Count = 0;
        
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            _Game_WallPaper = [CCSprite spriteWithFile:@"wallpaper_1.png" rect:CGRectMake(0, 0, 640, 1136)];
            bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 53, 320, 50)];
        } else {
            _Game_WallPaper = [CCSprite spriteWithFile:@"wallpaper_1.png" rect:CGRectMake(0, 0, 320, 480)];
            bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
            
        }
        
        
        bannerView.adUnitID = ADMOB_PUBLISHER_ID;
        bannerView.rootViewController = controller;
        
        [bannerView loadRequest:[GADRequest request]];
        [controller.view addSubview:bannerView];
        
        [[[CCDirector sharedDirector] openGLView] insertSubview:controller.view atIndex:0];
        
        
        //배경화면
        _Game_WallPaper.anchorPoint = ccp(0,0);
        [self addChild:_Game_WallPaper];
        
        //프로그래스바
        UIView *view = [[CCDirector sharedDirector] view];
        Progress_Time = [[UIProgressView alloc] initWithFrame: CGRectMake(14.0, 45.0, 290.0, 25.0)];
        [view addSubview: Progress_Time];
        [Progress_Time setProgress:1.0];
        GameTimer = [NSTimer scheduledTimerWithTimeInterval:0.6f target:self selector:@selector(Time_Progress) userInfo:nil repeats:YES];
        [Progress_Time setAlpha:0.7f];
        Progress_Time.progressTintColor = [UIColor redColor];
        
        //문제 보드
        CCSprite *_QuestionBoard = [CCSprite spriteWithFile:@"QuestionBoard.png" rect:CGRectMake(0, 0, 289, 62)];
        _QuestionBoard.position = ccp(size.width/2,size.height/2+150);
        [self addChild:_QuestionBoard];
        
        //맞은 갯수 correct
        _Correct_Count = [CCLabelTTF labelWithString:NSLocalizedString(@"맞은 갯수 : 0개", @"맞은갯수") fontName:fontName fontSize:20];
        _Correct_Count.position = ccp(size.width/2,size.height/2+30);
        _Correct_Count.color = ccc3(20,50,94);
        [self addChild:_Correct_Count];
                
        
        //키패드 및 라벨
        _Correct_label = [CCLabelTTF labelWithString:Correct_Str fontName:fontName fontSize:20];
        _Correct_label.position = ccp(size.width/2-70,size.height/2+78);
        _Correct_label.color = ccc3(20,50,94);
        [self addChild:_Correct_label];
        [self keyPad];
        
        
        //정답확인
        [self _btn_submit_display];
        [self schedule:@selector(gameLogic:)];
        [self schedule:@selector(update:)];
        
        _Excellent = [CCSprite spriteWithFile:@"Excellent.png" rect:CGRectMake(0, 0, 132, 29)];
        _Excellent.position = ccp(size.width/2-100,size.height/2+40);
        
        _Bad = [CCSprite spriteWithFile:@"Bad.png" rect:CGRectMake(0, 0, 132, 29)];
        _Bad.position = ccp(size.width/2+100,size.height/2+40);
        
        [self addChild:_Excellent];
        [self addChild:_Bad];
        
        _Excellent_Hide = CCHide.action;
        _Bad_Hide = CCHide.action;
        [_Excellent runAction:_Excellent_Hide];
        [_Bad runAction:_Bad_Hide];
        
        
        //정답확인 라벨
        CCLabelTTF *_Submit_label = [CCLabelTTF labelWithString:NSLocalizedString(@"확인", @"확인") fontName:fontName fontSize:20];
        _Submit_label.position = ccp(size.width/2+85,size.height/2+85);
        _Submit_label.color = ccc3(20,50,94);
        [self addChild:_Submit_label];
        
	}
	return self;
}
- (void) _btn_submit {
    
    NSLog(@"버그1");
    
    if (Correct_Str == nil) Correct_Str = @"";
    
    NSLog(@"버그2");
    if (QS._Result == [Correct_Str intValue])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Excellent.mp3"];
        NSLog(@"버그3");
        action = [CCBlink actionWithDuration:1.0f blinks:2];
        _Excellent_Hide = CCHide.action;
        [_Excellent runAction:[CCSequence actions:action,_Excellent_Hide, nil]];
        
        
        
        NSLog(@"버그4");
        if (Correct_Count <= 4) [QS _Stage1];
        else if (Correct_Count >= 5 && Correct_Count <=8) [QS _Stage2];
        else if (Correct_Count >= 9 && Correct_Count <=14) [QS _Stage3];
        else if (Correct_Count >= 15) [QS _Stage4];
        
        NSLog(@"버그5");
        Correct_Count++;
        G_Var.Correct_Count = Correct_Count;
        [_Question_label setString:QS._Question_str];
        
        NSLog(@"버그6");
        NSString *str = [NSString stringWithFormat:NSLocalizedString(@"맞은 갯수 : %d개", @"맞은갯수"), Correct_Count];
        [_Correct_Count setString:str];
        
    }
    else {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Bad.mp3"];
        action = [CCBlink actionWithDuration:1.0f blinks:2];
        _Bad_Hide = CCHide.action;
        [_Bad runAction:[CCSequence actions:action,_Bad_Hide, nil]];        
    }
    Correct_Str = @"";
    [_Correct_label setString:Correct_Str];
    NSLog(@"%@ - [%d] %d/%d", QS._Question_str, Correct_Count, QS._Result, [Correct_Str intValue]);
    
}
- (void) _btn_submit_display {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    [QS _Stage1];
    
    _Question_label = [CCLabelTTF labelWithString:QS._Question_str fontName:fontName fontSize:20];
    _Question_label.position = ccp(size.width/2,size.height/2+155);
    _Question_label.color = ccc3(20,50,94);
    [self addChild:_Question_label];
    
    CCMenuItemImage *_submit = [CCMenuItemImage itemWithNormalImage:@"btn_submit_hover.png" selectedImage:@"btn_submit_active.png" target:self selector:@selector(_btn_submit)];
    
    CCMenu *menu = [CCMenu menuWithItems:_submit, nil];
    [menu alignItemsHorizontally];
    menu.position = ccp(size.width/2+85,size.height/2+80);
    [self addChild: menu];

}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
- (void) Time_Progress {
    Progress_Time.progress -= 0.01f;
    NSLog(@"%f", Progress_Time.progress);
    if ([Progress_Time progress] <= 0.0f)
    {
        [bannerView removeFromSuperview];
        [GameTimer invalidate];
        [Progress_Time removeFromSuperview];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.4f scene:[GameEnd scene]]];
    }
}
- (void) Write : (NSInteger) btn_Count { 
    NSInteger len = [Correct_Str length];
    Correct_Str = [Correct_Str stringByAppendingString:[NSString stringWithFormat:@"%d", btn_Count]];
    if(btn_Count == 10 && len > 0) Correct_Str = [Correct_Str substringWithRange:NSMakeRange(0, len-1)];
    else if (btn_Count == 10 && len < 1) Correct_Str = @"";
    [_Correct_label setString:Correct_Str];
}
- (void) keyPad {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
   
    CCMenuItemImage *_keypad_1 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:1];
    }];
        
    CCMenuItemImage *_keypad_2 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:2];
    }];
    
    CCMenuItemImage *_keypad_3 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:3];
    }];
    
    CCMenu *idx_keypad_1 = [CCMenu menuWithItems:_keypad_1,_keypad_2,_keypad_3, nil];
    [idx_keypad_1 alignItemsHorizontally];
    idx_keypad_1.position = ccp(size.width/2,size.height/2-30);
    [self addChild: idx_keypad_1];
    
    
    CCMenuItemImage *_keypad_4 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:4];        
    }];
    
    CCMenuItemImage *_keypad_5 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:5];
    }];
    
    CCMenuItemImage *_keypad_6 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:6];
    }];
    
    CCMenu *idx_keypad_2 = [CCMenu menuWithItems:_keypad_4,_keypad_5,_keypad_6, nil];
    [idx_keypad_2 alignItemsHorizontally];
    idx_keypad_2.position = ccp(size.width/2,size.height/2-90);
    [self addChild: idx_keypad_2];
    
    
    CCMenuItemImage *_keypad_7 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:7];
    }];
    
    CCMenuItemImage *_keypad_8 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:8];        
    }];
    
    CCMenuItemImage *_keypad_9 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:9];
    }];
    
    CCMenu *idx_keypad_3 = [CCMenu menuWithItems:_keypad_7,_keypad_8,_keypad_9, nil];
    [idx_keypad_3 alignItemsHorizontally];
    idx_keypad_3.position = ccp(size.width/2,size.height/2-150);
    [self addChild: idx_keypad_3];
    
    
    CCMenuItemImage *_keypad_0 = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:0];
    }];
    
    CCMenuItemImage *_keypad_x = [CCMenuItemImage itemWithNormalImage:@"keypad_orange_hovor.png" selectedImage:@"keypad_orange_active.png" block:^(id sender) {
        [self Write:10];
    }];
    
    CCMenu *idx_keypad_4 = [CCMenu menuWithItems:_keypad_0,_keypad_x, nil];
    [idx_keypad_4 alignItemsHorizontally];
    idx_keypad_4.position = ccp(size.width/2,size.height/2-210);
    [self addChild: idx_keypad_4];
    
    
    
    
    //키패드 라벨
    
    CCLabelTTF *key1 = [CCLabelTTF labelWithString:@"1" fontName:fontName fontSize:23];
    key1.position = ccp(size.width/2-77, size.height/2-30);
    
    CCLabelTTF *key2 = [CCLabelTTF labelWithString:@"2" fontName:fontName fontSize:23];
    key2.position = ccp(size.width/2, size.height/2-30);
    CCLabelTTF *key3 = [CCLabelTTF labelWithString:@"3" fontName:fontName fontSize:23];
    key3.position = ccp(size.width/2+77, size.height/2-30);
    
    CCLabelTTF *key4 = [CCLabelTTF labelWithString:@"4" fontName:fontName fontSize:23];
    key4.position = ccp(size.width/2-77, size.height/2-90);
    CCLabelTTF *key5 = [CCLabelTTF labelWithString:@"5" fontName:fontName fontSize:23];
    key5.position = ccp(size.width/2, size.height/2-90);
    CCLabelTTF *key6 = [CCLabelTTF labelWithString:@"6" fontName:fontName fontSize:23];
    key6.position = ccp(size.width/2+77, size.height/2-90);
    
    CCLabelTTF *key7 = [CCLabelTTF labelWithString:@"7" fontName:fontName fontSize:23];
    key7.position = ccp(size.width/2-77, size.height/2-150);
    CCLabelTTF *key8 = [CCLabelTTF labelWithString:@"8" fontName:fontName fontSize:23];
    key8.position = ccp(size.width/2, size.height/2-150);
    CCLabelTTF *key9 = [CCLabelTTF labelWithString:@"9" fontName:fontName fontSize:23];
    key9.position = ccp(size.width/2+77, size.height/2-150);    
    
    CCLabelTTF *key10 = [CCLabelTTF labelWithString:@"0" fontName:fontName fontSize:23];
    key10.position = ccp(size.width/2-38, size.height/2-210);
    CCLabelTTF *key11 = [CCLabelTTF labelWithString:NSLocalizedString(@"삭제", @"삭제") fontName:fontName fontSize:23];
    key11.position = ccp(size.width/2+38, size.height/2-210);
    
    
    [self addChild:key1];
    [self addChild:key2];
    [self addChild:key3];
    [self addChild:key4];
    [self addChild:key5];
    [self addChild:key6];
    [self addChild:key7];
    [self addChild:key8];
    [self addChild:key9];
    [self addChild:key10];
    [self addChild:key11];
}

-(void)gameLogic:(ccTime)dt
{
    NSInteger len = [Correct_Str length];
    
    if (len > 6) Correct_Str = [Correct_Str substringWithRange:NSMakeRange(0, len-1)];
    [_Correct_label setString:Correct_Str];
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
@end

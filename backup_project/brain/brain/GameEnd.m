//
//  GameEnd.m
//  brain
//
//  Created by Administrator on 12. 9. 28..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "GameEnd.h"
#import "indexLayer.h"
#import "GameLayer.h"
#import "lib/sqllite.h"

#define ADMOB_PUBLISHER_ID @"a1508bd4bf79ae0"

@implementation GameEnd
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameEnd *layer = [GameEnd node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if((self=[super init])) {
        
        UIViewController *controller = [[UIViewController alloc] init];
        

        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        GlobalVar *G_Var = [GlobalVar sharedInstance];
        sqllite *db = [[sqllite alloc] init];
        
        Correct_Count = G_Var.Correct_Count;
        Correct_Str = G_Var.Correct_Str;
        [db addsql:Correct_Count];
        
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            
            bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 520, 320, 50)];
            
            WallPaper = [CCSprite spriteWithFile:@"end_wallpaper.png" rect:CGRectMake(0, 0, 640, 1136)];
            
        } else {
            bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 430, 320, 50)];
            
            WallPaper = [CCSprite spriteWithFile:@"end_wallpaper.png" rect:CGRectMake(0, 0, 320, 480)];
            
        }
        
        
        bannerView.adUnitID = ADMOB_PUBLISHER_ID;
        bannerView.rootViewController = controller;
        
        [bannerView loadRequest:[GADRequest request]];
        [controller.view addSubview:bannerView];
        
        [[[CCDirector sharedDirector] openGLView] insertSubview:controller.view atIndex:0];
        
        //배경화면
        WallPaper.anchorPoint = ccp(0,0);
        [self addChild:WallPaper];
        
        //결과 배경 이미지
        CCSprite *img_result = [CCSprite spriteWithFile:@"ete_result.png" rect:CGRectMake(0, 0, 151, 150)];
        img_result.position = ccp(size.width/2,size.height/2);
        [self addChild:img_result];
        
        CCSprite *img_Check = [CCSprite spriteWithFile:@"btn_result.png" rect:CGRectMake(0, 0, 120, 20)];
        
        CCMenuItem *_btn_Check = [CCMenuItemSprite itemWithNormalSprite:img_Check selectedSprite:nil block:^(id sender) {
            [bannerView removeFromSuperview];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipAngular transitionWithDuration:0.1f scene:[indexLayer scene]]];
        }];
        
        CCMenu *btn_check = [CCMenu menuWithItems:_btn_Check, nil];
        btn_check.position = ccp(size.width/2,size.height/2-50);
        [self addChild:btn_check];
        
        CCLabelTTF *_Check_label = [CCLabelTTF labelWithString:NSLocalizedString(@"확인", @"확인")  fontName:@"Helvetica" fontSize:15];
        _Check_label.position = ccp(size.width/2,size.height/2-50);
        _Check_label.color = ccc3(255,255,255);
        [self addChild:_Check_label];
        
        
        CCLabelTTF *_Result_label = [CCLabelTTF labelWithString:NSLocalizedString(@"게임결과", @"게임결과") fontName:@"Helvetica" fontSize:15];
        _Result_label.position = ccp(size.width/2,size.height/2+63);
        _Result_label.color = ccc3(255,255,255);
        [self addChild:_Result_label];
        
        CCLabelTTF *_Result_Count_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", Correct_Count] fontName:@"Helvetica" fontSize:15];
        _Result_Count_label.position = ccp(size.width/2,size.height/2+5);
        _Result_Count_label.color = ccc3(0,255,0);
        [self addChild:_Result_Count_label];
        
        
        CCLabelTTF *_Result_Count_Check_label = [CCLabelTTF labelWithString:NSLocalizedString(@"맞은갯수", @"맞은갯수") fontName:@"Helvetica" fontSize:15];
        _Result_Count_Check_label.position = ccp(size.width/2,size.height/2+25);
        _Result_Count_Check_label.color = ccc3(255,252, 0);
        [self addChild:_Result_Count_Check_label];
        
        
        
	}
	return self;
}
- (void) dealloc
{
	[super dealloc];
}
@end

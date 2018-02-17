//
//  GameLayer.h
//  brain
//
//  Created by Administrator on 12. 9. 24..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <UIKit/UIKit.h>
#import "Question.h"
#import <MediaPlayer/MediaPlayer.h>
#import "lib/GlobalVar.h"
#import "GADBannerView.h"

@class Question;

@interface GameLayer : CCLayer <UITextFieldDelegate>
{
    GADBannerView *bannerView;
    CCSprite *_Game_WallPaper;
    
    UIProgressView *Progress_Time;
    NSTimer *GameTimer;
    CCLabelTTF *_Question_label;
    CCLabelTTF *_Correct_label;
    CCLabelTTF *_Correct_Count;
    
    Question *QS;
    
    CCSprite *_Excellent;
    CCSprite *_Bad;
    id action;
    CCHide *_Excellent_Hide;
    CCHide *_Bad_Hide;
    
    
    UISwitch *Switch;
    NSInteger SoundState;
    MPMusicPlaybackState PlayBackState;

    NSInteger Correct_Count;
    NSString *Correct_Str;
    GlobalVar *G_Var;
    
    NSString *fontName;
}
+(CCScene *) scene;
@end

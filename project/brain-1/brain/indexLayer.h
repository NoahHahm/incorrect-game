//
//  HelloWorldLayer.h
//  brain
//
//  Created by Administrator on 12. 9. 24..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//


#import <GameKit/GameKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "lib/sqllite.h"
#import "GADBannerView.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface indexLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    GADBannerView *bannerView;
    UISwitch *Switch;
    NSInteger SoundState;
    MPMusicPlaybackState PlayBackState;
    NSString *fontName;
    CCSprite *WallPaper;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

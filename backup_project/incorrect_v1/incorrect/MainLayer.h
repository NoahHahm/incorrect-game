//
//  MainLayer.h
//  incorrect
//
//  Created by Administrator on 13. 1. 20..
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "RankViewController.h"

@interface MainLayer : CCLayer
{
    RankViewController *rankViewController;
}
+(CCScene *) scene;
+ (void) Music : (bool) isMusicState;
@end

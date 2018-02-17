//
//  GameEnd.h
//  brain
//
//  Created by Administrator on 12. 9. 28..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GADBannerView.h"

@interface GameScore : CCLayer {
    GADBannerView *bannerView;
    NSInteger Correct_Count;
    NSString *Correct_Str;
    CCSprite *WallPaper;
}
+(CCScene *) scene;
@end

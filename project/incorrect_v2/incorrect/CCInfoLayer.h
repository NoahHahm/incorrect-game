//
//  CCInfoLayer.h
//  incorrect
//
//  Created by administrator on 13. 9. 14..
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "ServiceApi.h"
#import <FacebookSDK/FacebookSDK.h>


@protocol CCInfoLayerProtocol <NSObject>
- (void) InfoLayerDelegate;
@end


@interface CCInfoLayer : CCLayer <FBWebDialogsDelegate>
{
    
}
+ (void) setCulturalAssetsInfo : (CulturalAssetsInfo *) info;
+ (void) setDelegate : (id) data;
+ (CCScene *) scene;
@end

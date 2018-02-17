//
//  Gameinfo.h
//  incorrect
//
//  Created by Administrator on 13. 1. 4..
//
//

#import <Foundation/Foundation.h>

@interface Gameinfo : NSObject
{
    NSInteger ResultScore;
}
- (NSInteger) GetScore:(NSInteger) Score ComboScore:(NSInteger)ComboScore;
@end

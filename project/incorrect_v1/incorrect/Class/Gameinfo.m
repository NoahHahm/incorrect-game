//
//  Gameinfo.m
//  incorrect
//
//  Created by Administrator on 13. 1. 4..
//
//

#import "Gameinfo.h"

@implementation Gameinfo
-(id) init
{
	if( (self=[super init])) {
        ResultScore = 0;
	}
	return self;
}
- (NSInteger) GetScore:(NSInteger) Score ComboScore:(NSInteger)ComboScore {
    
    if(ResultScore > 0) ResultScore = ResultScore + Score * ComboScore;
    else ResultScore = Score * ComboScore;
    
    return ResultScore;
}
@end

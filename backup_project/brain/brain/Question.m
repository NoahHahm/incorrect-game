//
//  Question.m
//  brain
//
//  Created by Administrator on 12. 9. 25..
//
//

#import "Question.h"

@implementation Question
@synthesize _Question_str, _Result;
- (id)init
{
    self = [super init];
    if(self) {
        _Question_str = @"";
        _Result = 0;
    }    
    return self;
}
- (void) _Stage1
{    
    NSInteger Rand = arc4random()%2;
    if (Rand == 0) Rand = 2;
    
    _Count1 = (arc4random()%9);
    _Count2 = (arc4random()%9);
        
    switch (Rand) {
        case 1:
            _Question_str = [NSString stringWithFormat:@"%d + %d", _Count1, _Count2];
            _Result = _Count1 + _Count2;
            break;
        case 2:
            while(_Count1 < _Count2) {
                _Count1 = (arc4random()%9);
                if(_Count1 > _Count2) break;
            }
            _Question_str = [NSString stringWithFormat:@"%d - %d", _Count1, _Count2];
            _Result = _Count1 - _Count2;
            break;
    }
}
- (void) _Stage2
{
    NSInteger Rand = arc4random()%3;
    if (Rand == 0) Rand = 3;
    
    _Count1 = (arc4random()%99);
    _Count2 = (arc4random()%9);
    
    switch (Rand) {
        case 1:
            _Question_str = [NSString stringWithFormat:@"%d + %d", _Count1, _Count2];
            _Result = _Count1 + _Count2;
            break;
        case 2:
            _Question_str = [NSString stringWithFormat:@"%d X %d", _Count1, _Count2];
            _Result = _Count1 * _Count2;
            break;
        case 3:
            while(_Count1 < _Count2) {
                _Count1 = (arc4random()%9);
                if(_Count1 > _Count2) break;
            }
            _Question_str = [NSString stringWithFormat:@"%d - %d", _Count1, _Count2];
            _Result = _Count1 - _Count2;
            break;
    }
}
- (void) _Stage3
{
    NSInteger Rand = arc4random()%2;
    if (Rand == 0) Rand = 2;
    
    _Count1 = (arc4random()%9);
    _Count2 = (arc4random()%9);
    _Count3 = (arc4random()%9);
    
    switch (Rand) {
        case 1:
            _Question_str = [NSString stringWithFormat:@"%d + %d + %d", _Count1, _Count2, _Count3];
            _Result = _Count1 + _Count2 + _Count3;
            break;
        case 2:
            _Question_str = [NSString stringWithFormat:@"%d X %d X %d", _Count1, _Count2, _Count3];
            _Result = _Count1 * _Count2 * _Count3;
            break;
    }
}
- (void) _Stage4
{
    NSInteger Rand = arc4random()%2;
    if (Rand == 0) Rand = 2;
    
    _Count1 = (arc4random()%99);
    _Count2 = (arc4random()%9);
    _Count3 = (arc4random()%9);
    
    if(_Count1 == 0) _Count1 = (arc4random()%9);
    else if(_Count2 == 0) _Count1 = (arc4random()%9);
    
    switch (Rand) {
        case 1:
            _Question_str = [NSString stringWithFormat:@"%d X %d + %d", _Count1, _Count2, _Count3];
            _Result = _Count1 * _Count2 + _Count3;
            break;
        case 2:
            _Question_str = [NSString stringWithFormat:@"%d + %d - %d", _Count1, _Count2, _Count3];
            _Result = _Count1 + _Count2 - _Count3;
            break;
    }
}
@end

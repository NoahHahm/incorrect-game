//
//  ImageTouchCore.m
//  incorrect
//
//  Created by Administrator on 12. 12. 29..
//
//

#import "ImageTouchCore.h"
#import "SqlLiteCore.h"

@implementation ImageTouchCore

-(id) init
{
	if( (self=[super init])) {
        arrs = [[NSMutableArray alloc] init];
        dbcore = [[SqlLiteCore alloc] init];
	}
	return self;
}

- (NSMutableArray *) DeletePosition : (NSInteger) idx x : (NSInteger) x  y : (NSInteger) y position : (NSMutableArray *) position {
    for(List *temp in position) {
        //가로 세로 에 대한 처리
        if (((temp.Y <= y && temp.Y+15 >= y) || (temp.Y >= y && temp.Y-15 <= y)) && ((temp.X <= x && temp.X+15 >= x) || (temp.X >= x && temp.X-15 <= x))) {
            [position removeObject:temp];
            return position;
        }
    }
    return position;
}

- (BOOL) Coordinate : (NSInteger) idx x : (NSInteger) x  y : (NSInteger) y position : (NSMutableArray *) position {

    
    //List *item = [[List alloc] init];
    //[arr1 addObject:item];
    //[arr1 addObject:item];
    //[(List*)[arr1 objectAtIndex:0]].idx = 1;
    /*
    List *temp = [arr1 objectAtIndex:0];
    temp.idx = 1;
    temp.X = 96;
    temp.Y = 226;
    
    
    temp = [arr1 objectAtIndex:1];
    temp.idx = 2;
    temp.X = 96;
    temp.Y = 226;
    */
    
    //좌표 검사
    //arrs = [dbcore GetSafetyMark:idx];
    
    for(List *temp in position) {
        //가로 세로 에 대한 처리
        if (((temp.Y <= y && temp.Y+15 >= y) || (temp.Y >= y && temp.Y-15 <= y)) && ((temp.X <= x && temp.X+15 >= x) || (temp.X >= x && temp.X-15 <= x))) {
            return true;
        }
    }
    
    return false;
    
    
}
@end

@implementation List
@synthesize idx, X, Y;
-(id) init
{
	if((self=[super init])) {
        self.idx = 0;
        self.X = 0;
        self.Y = 0;
	}
	return self;
}
@end

//
//  ImageTouchCore.h
//  incorrect
//
//  Created by Administrator on 12. 12. 29..
//
//

#import <Foundation/Foundation.h>
#import "SqlLiteCore.h"

@interface ImageTouchCore : NSObject
{
    SqlLiteCore *dbcore;
    NSMutableArray *arrs;
}
- (NSMutableArray *) DeletePosition : (NSInteger) idx x : (NSInteger) x  y : (NSInteger) y position : (NSMutableArray *) position;
- (BOOL) Coordinate : (NSInteger) idx x : (NSInteger) x  y : (NSInteger) y position : (NSMutableArray *) position;
@end

@interface List : NSObject
@property NSInteger idx;
@property NSInteger X;
@property NSInteger Y;
@end
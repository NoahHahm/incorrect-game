//
//  SqlLiteCore.h
//  incorrect
//
//  Created by Administrator on 12. 12. 29..
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqlLiteCore : NSObject
{
    sqlite3 *database;
}
- (NSMutableArray *) GetSafetyMark : (NSInteger) idx;
@end

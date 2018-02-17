//
//  sqllite.h
//  poop
//
//  Created by Administrator on 12. 9. 4..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <sqlite3.h>

@interface sqllite : CCLayer {
    sqlite3 *database;    
}
- (void) addsql : (NSInteger) count;
- (void) createSQL;
- (NSMutableArray *) getAllinfo;
@end

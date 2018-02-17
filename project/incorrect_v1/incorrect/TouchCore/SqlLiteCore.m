//
//  SqlLiteCore.m
//  incorrect
//
//  Created by Administrator on 12. 12. 29..
//
//

#import "SqlLiteCore.h"
#import "ImageTouchCore.h"

@implementation SqlLiteCore

- (NSMutableArray *) GetSafetyMark : (NSInteger) idx {

    NSMutableArray *DB = [[NSMutableArray alloc] init];
    
    @try {
        //NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Coordinate.sqlite"];
        //BOOL success = [fileMgr fileExistsAtPath:dbPath];
                
        if (!(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK))
        {
            NSLog(@"An error Opening Database, normally handle error here.");
        }
        
        NSString *query_sql = [NSString stringWithFormat:@"SELECT * FROM Coordinate WHERE picseqno = %d", idx];
        const char *sql = [query_sql UTF8String];
    
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK)
        {
            NSLog(@"Error, failed to prepare statement, normally handle error here.");
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            List *item = [[List alloc] init];
            item.idx = sqlite3_column_int(statement, 1);
            item.X = sqlite3_column_int(statement, 2);
            item.Y = sqlite3_column_int(statement, 3);
            
            [DB addObject:item];
        }
        
        if (sqlite3_finalize(statement) != SQLITE_OK)
        {
            NSLog(@"Failed to finalize data statement, normally error hanling here.");
        }
        
        if (sqlite3_close(database) != SQLITE_OK)
        {
            NSLog(@"Failed to Close database, normally error handling here.");
        }
         
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occurred : %@", [exception reason]);
        return nil;
    }
    
    return DB;
}
@end

//
//  sqllite.m
//  poop
//
//  Created by Administrator on 12. 9. 4..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "sqllite.h"


@implementation sqllite
- (void) addsql : (NSInteger) count
{

    const char *sql = "insert into brain_db (id, count) values (?, ?)";
    
    sqlite3_stmt *insert_statement = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSString *thePath = [docsDir stringByAppendingPathComponent:@"db_data.sqlite"];
    
    sqlite3_open([thePath UTF8String], &database);
    sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL);
    
    sqlite3_bind_null(insert_statement, 1);
    sqlite3_bind_int(insert_statement, 2, count);
    
    sqlite3_step(insert_statement);
    sqlite3_finalize(insert_statement);
    sqlite3_close(database);
}
- (void) createSQL
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSString *thePath = [docsDir stringByAppendingPathComponent:@"db_data.sqlite"];
    
    if (!(sqlite3_open([thePath UTF8String], &database) == SQLITE_OK))
    {
        NSLog(@"An error Opening Database, normally handle error here.");
    }
    //CREATE TABLE IF NOT EXISTS 'brain_db' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'count' INTEGER NOT NULL)
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS 'brain_db' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'count' INTEGER NOT NULL)";
    char *errormsg;
    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errormsg) != SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating Table : %s", errormsg);
    }
    
}
- (NSMutableArray *) getAllinfo {
    
    NSMutableArray *info = [[NSMutableArray alloc] init];

    @try {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [paths objectAtIndex:0];
        NSString *thePath = [docsDir stringByAppendingPathComponent:@"db_data.sqlite"];
        
        if (!(sqlite3_open([thePath UTF8String], &database) == SQLITE_OK))
        {
            NSLog(@"An error Opening Database, normally handle error here.");
        }
        
        const char *sql = "SELECT count From brain_db ORDER by `count` DESC";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK)
        {
            NSLog(@"Error, failed to prepare statement, normally handle error here.");
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            [info addObject:[NSNumber numberWithInteger:sqlite3_column_int(statement, 0)]];
            //[info addObject:[NSNumber numberWithInteger:sqlite3_column_int(statement, 1)]];
            break;
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
    return info;
}
@end

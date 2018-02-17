//
//  SqlLiteCore.m
//  incorrect
//
//  Created by Administrator on 12. 12. 29..
//
//

#import "SqlLiteCore.h"
#import "ImageTouchCore.h"

//Delete from Coordinate

@implementation SqlLiteCore

- (BOOL) clearDB {
    
    @try {
        //NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Coordinate.sqlite"];
        
        if (!(sqlite3_open([[self filePath] UTF8String], &database) == SQLITE_OK))
        {
            NSLog(@"An error Opening Database, normally handle error here.");
        }
        
        NSString *query_sql = [NSString stringWithFormat:@"Delete from Coordinate"];
        const char *sql = [query_sql UTF8String];
        
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error, failed to prepare statement, normally handle error here.");
        }
        
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_finalize(statement);
        }
        
        if (sqlite3_close(database) != SQLITE_OK)
        {
            NSLog(@"Failed to Close database, normally error handling here.");
        }
        return true;
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occurred : %@", [exception reason]);
        return false;
    }
    
    return false;

}

- (BOOL) insertData : (NSMutableArray *) data {
    
    @try {
        //NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Coordinate.sqlite"];
        [self createTable];
        
        if (!(sqlite3_open([[self filePath] UTF8String], &database) == SQLITE_OK))
        {
            NSLog(@"An error Opening Database, normally handle error here.");
        }
        
        sqlite3_stmt *statement;        
        for(int i=0;i<[data count];i++)
        {
            NSString *query_sql = [NSString stringWithFormat:@"INSERT INTO Coordinate (culturalno, x, y) VALUES (?, ?, ?)"];
            const char *sql = [query_sql UTF8String];
            
            if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
                NSLog(@"Error, failed to prepare statement, normally handle error here.");
            }
            
            List *temp = [data objectAtIndex:i];
            sqlite3_bind_int(statement, 1, temp.manage_id);
            sqlite3_bind_int(statement, 2, temp.X);
            sqlite3_bind_int(statement, 3, temp.Y);
            sqlite3_step(statement);
            
        }
        
        sqlite3_finalize(statement);
        if (sqlite3_close(database) != SQLITE_OK)
        {
            NSLog(@"Failed to Close database, normally error handling here.");
        }
        return true;
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occurred : %@", [exception reason]);
        return false;
    }
    
    return false;
    
}
- (void) createTable {
    char *err;
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE Coordinate ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , 'culturalno' INTEGER NOT NULL , 'x' INTEGER NOT NULL , 'y' INTEGER NOT NULL)"];
    
    if (sqlite3_open_v2([[self filePath] UTF8String], &database, SQLITE_OPEN_CREATE|SQLITE_OPEN_READWRITE, NULL) == SQLITE_OK) {
        sqlite3_exec(database, [sql UTF8String], NULL, NULL, &err);
    }
    
}

- (NSString *) filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Coordinate.sqlite"];
}

- (NSMutableArray *) GetSafetyMark : (NSInteger) idx {

    NSMutableArray *DB = [[NSMutableArray alloc] init];
    
    @try {
        //NSFileManager *fileMgr = [NSFileManager defaultManager];
        //NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Coordinate.sqlite"];
        //BOOL success = [fileMgr fileExistsAtPath:dbPath];
        
        //SQLITE_OPEN_CREATE
                
        if (!(sqlite3_open([[self filePath] UTF8String], &database) == SQLITE_OK))
        {
            
        }
        
        NSString *query_sql = [NSString stringWithFormat:@"SELECT * FROM Coordinate WHERE culturalno = %d", idx];
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

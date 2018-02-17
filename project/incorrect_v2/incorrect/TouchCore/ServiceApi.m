//
//  CulturalJsonCore.m
//  SeoulXmlCore
//
//  Created by administrator on 13. 8. 26..
//  Copyright (c) 2013년 administrator. All rights reserved.
//


#import "ServiceApi.h"
#import "ImageTouchCore.h"

#define VERSION_CHECK_URL @"http://noantech.cafe24.com/app/seoul_app.php?versionCheck=1"
#define INIT_USER_URL @"http://noantech.cafe24.com/app/seoul_app.php?init=1"
#define LIST_URL @"http://noantech.cafe24.com/app/seoul_app.php?list=1"

static NSDictionary *jsonData;
static NSMutableArray *ParserData;

@implementation BasicAppInfo
@end

@implementation CulturalAssetsInfo
@end

@implementation ServiceApi


- (id)init {
    self = [super init];
    if (self) {
        jsonData = [[NSDictionary alloc] init];
        ParserData = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NSDictionary *) GetUserRankList {
    
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:@"http://noantech.cafe24.com/app/seoul_app.php?rank=1"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return jsonData;
}

+ (NSDictionary *) getParserInitData {
    
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:INIT_USER_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return jsonData;
}

+ (NSString *) getVerCheck {
    
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:VERSION_CHECK_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSString *str = [NSString stringWithFormat:@"%@", [[jsonData objectForKey:@"app"] objectForKey:@"version"]];
    
    return str;
}

+ (NSMutableArray *) getCoordinate {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:@"http://noantech.cafe24.com/app/seoul_app.php?coordinate=1"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger count = [[jsonData objectForKey:@"count"] intValue];
    
    for (int i=0;count>i;i++)
    {
        List *info = [[List alloc] init];
        
        info.idx = [[[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"] intValue];
        info.manage_id = [[[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"manage_id"] intValue];
        info.x = [[[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"x"] intValue];
        info.y = [[[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"y"] intValue];

        [list addObject:info];
    }
    
    return list;
    
       
}

+ (NSMutableArray *) updateData : (NSString *)version {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://noantech.cafe24.com/app/seoul_app.php?init=0&version=%@", version, nil]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger count = [[jsonData objectForKey:@"count"] intValue];
    
    for (int i=0;count>i;i++)
    {
        BasicAppInfo *info = [[BasicAppInfo alloc] init];
        
        info.Manage_id = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"];
        info.Hd_url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"hd_url"];
        info.Url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"url"];
        info.Falult_hd_url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"falult_hd_url"];
        info.Falult_url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"falult_url"];
        info.Version = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"version"];
        
        [list addObject:info];
    }
    
    return list;
    
}

+ (NSMutableArray *) getParserInitDataParser {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:INIT_USER_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger count = [[jsonData objectForKey:@"count"] intValue];
    
    for (int i=0;count>i;i++)
    {
        BasicAppInfo *info = [[BasicAppInfo alloc] init];
        
        info.Manage_id = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"];
        info.Hd_url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"hd_url"];
        info.Url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"url"];
        info.Falult_hd_url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"falult_hd_url"];
        info.Falult_url = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"falult_url"];
        info.Version = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"version"];
        
        [list addObject:info];
    }
    
    return list;
}

+ (NSMutableArray *) getlistManageId {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:LIST_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger count = [[jsonData objectForKey:@"count"] intValue];
    
    for (int i=0;count>i;i++)
    {
        BasicAppInfo *info = [[BasicAppInfo alloc] init];
        
        info.Manage_id = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"];
        info.Version = [[[jsonData objectForKey:@"data"] objectAtIndex:i] objectForKey:@"version"];
        
        [list addObject:info];
    }
    
    return list;
    
}

+ (CulturalAssetsInfo *) getCulturaldata : (NSInteger ) idx {

    CulturalAssetsInfo *info = [[CulturalAssetsInfo alloc] init];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openapi.seoul.go.kr:8088/6462677464627a32303931/json/ListCulturalAssetsInfo/1/1/%d", idx]]];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    NSInteger count = [[[json objectForKey:@"ListCulturalAssetsInfo"] objectForKey:@"row"] count];
    
    if (count > 0) {        
        info.Cultural_Name = [[[[json objectForKey:@"ListCulturalAssetsInfo"] objectForKey:@"row"] objectAtIndex:0] objectForKey:@"NAME_KOR"];
        info.Cultural_EngName = [[[[json objectForKey:@"ListCulturalAssetsInfo"] objectForKey:@"row"] objectAtIndex:0] objectForKey:@"NAME_ENG"]; 
        info.Manage_id = [[[[json objectForKey:@"ListCulturalAssetsInfo"] objectForKey:@"row"] objectAtIndex:0] objectForKey:@"MANAGE_NUM"];        
        info.App_reason = [[[[json objectForKey:@"ListCulturalAssetsInfo"] objectForKey:@"row"] objectAtIndex:0] objectForKey:@"APP_REASON"];
        info.App_Board = [[[[json objectForKey:@"ListCulturalAssetsInfo"] objectForKey:@"row"] objectAtIndex:0] objectForKey:@"BOARD_KOR"];
        info.Stand_addr = [[[[json objectForKey:@"ListCulturalAssetsInfo"] objectForKey:@"row"] objectAtIndex:0] objectForKey:@"STAND_ADDR"];
    }    
    
    return info;
}

+ (bool) SetSignUser : (NSString *) userName {
    NSURLResponse * response = nil;
    NSError *error = nil;
    userName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"http://noantech.cafe24.com/app/apps_contest.php?cmd=2&name=%@", userName, nil];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if ([[jsonData valueForKey:@"result"] integerValue] == 1) {
        return true;
    }
    return false;
    
}


+ (void) SetUserScore : (NSString *) userName : (NSInteger) score {
    NSURLResponse * response = nil;
    NSError *error = nil;
    userName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"http://noantech.cafe24.com/app/apps_contest.php?cmd=3&name=%@&score=%d", userName, score, nil];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
}


+ (NSDictionary *) GetUserinfo : (NSString *) userName {
    NSURLResponse * response = nil;
    NSError *error = nil;
    userName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"http://noantech.cafe24.com/app/apps_contest.php?cmd=4&name=%@", userName, nil];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
    return jsonData;
}


@end

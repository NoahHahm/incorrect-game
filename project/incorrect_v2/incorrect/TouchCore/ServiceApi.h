//
//  CulturalJsonCore.h
//  SeoulXmlCore
//
//  Created by administrator on 13. 8. 26..
//  Copyright (c) 2013년 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommunication.h"

@interface CulturalAssetsInfo : NSObject
@property (nonatomic, assign) NSString *Manage_id;
@property (nonatomic, assign) NSString *Cultural_Name;
@property (nonatomic, assign) NSString *Cultural_EngName;
@property (nonatomic, assign) NSString *App_reason;
@property (nonatomic, assign) NSString *Stand_addr;
@property (nonatomic, assign) NSString *App_Board;
@end

@interface BasicAppInfo : NSObject
@property (nonatomic, assign) NSString *Manage_id;
@property (nonatomic, assign) NSString *Hd_url;
@property (nonatomic, assign) NSString *Url;
@property (nonatomic, assign) NSString *Falult_hd_url;
@property (nonatomic, assign) NSString *Falult_url;
@property (nonatomic, assign) NSString *Version;
@end


@interface ServiceApi : NSObject
+ (bool) SetSignUser : (NSString *) userName;
+ (NSDictionary *) GetUserRankList;
- (void) jsonCulturalParserText : (NSMutableData *)jsonText;
+ (NSMutableArray *) getParserInitDataParser;
- (NSString *) verCheck :(NSDictionary *)_jsonData;
+ (NSDictionary *) GetUserinfo : (NSString *) userName;
+ (void) SetUserScore : (NSString *) userName : (NSInteger) score;
+ (CulturalAssetsInfo *) getCulturaldata : (NSInteger ) idx;
+ (NSString *) getVerCheck;
+ (NSMutableArray *) updateData : (NSString *)version;
+ (NSMutableArray *) getlistManageId;
+ (NSMutableArray *) getCoordinate;
@end

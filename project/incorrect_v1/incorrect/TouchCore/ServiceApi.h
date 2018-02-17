//
//  ServiceApi.h
//  incorrect
//
//  Created by Administrator on 12. 12. 30..
//
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@protocol httpDelegate
- (void)downComplete:(NSString*)_downString;
@end

@interface ServiceApi : NSObject
{
    NSDictionary *Technologyinfo;
    SBJsonParser *Parser;
    NSString *Filename;
}

extern NSInteger Fileindex;
- (NSDictionary *) GetPicseqno : (NSInteger) idx;
- (NSDictionary *) GetAllPicseqno;
- (BOOL) GetFileNamePicseqno : (NSInteger) idx info : (NSDictionary *) info;
- (BOOL) GetPicseqnoInfo : (NSInteger) idx info : (NSDictionary *) info;
- (UIImage *) GetImageData : (NSInteger) idx;
+ (NSDictionary *) GetUserRankList;
+ (bool) SetSignUser : (NSString *) userName;
+ (void) SetUserScore : (NSString *) userName : (NSInteger) score;
+ (NSDictionary *) GetUserinfo : (NSString *) userName;

@property (nonatomic, assign) NSString *KorName;
@property (nonatomic, assign) NSString *EngName;
@property (nonatomic, assign) NSString *Description;
@property (nonatomic, assign) NSString *ApplyField;

@end

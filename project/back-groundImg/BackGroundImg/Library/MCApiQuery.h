#import <Foundation/Foundation.h>

@class MCApiQuery;

@protocol MCApiQueryDelegete
- (void)apiQueryBegin:(MCApiQuery*)sender;
- (void)apiQueryEnd:(MCApiQuery*)sender;
- (void)apiQuerySucceeded:(MCApiQuery*)sender content:(NSString*)content;
- (void)apiQueryFailed:(MCApiQuery*)sender;
- (NSInteger)getSection;
@end

@interface MCApiQuery : NSObject {
    NSMutableData *_responseData;
}
@property (weak, nonatomic) id<MCApiQueryDelegete> delegate;
//@property (nonatomic) NSInteger session;

//-(void)query_uploadPicture:(NSData*)pictureData;
-(void)query_uploadPicture:(NSData*)pictureData _section:(NSInteger)_section _title:(NSString *)_title _uploader:(NSString *)_uploader;
@end

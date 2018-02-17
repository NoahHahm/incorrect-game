//
//  ServiceApi.m
//  incorrect
//
//  Created by Administrator on 12. 12. 30..
//
//

#import "ServiceApi.h"
#import "AFNetworking.h"
#import "Singleton.h"

#define PICSEQNOMAX 302

static NSDictionary *RankList;
static SBJsonParser *Parser;

@implementation ServiceApi
@synthesize KorName, EngName, Description, ApplyField;

-(id) init
{
	if((self=[super init])) {
        Parser = [[SBJsonParser alloc] init];
        Technologyinfo = [[NSDictionary alloc] init];
	}
	return self;
}

- (NSDictionary *) GetAllPicseqno  {
    
    @try {
        
        // Create client
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.ibtk.kr/"]];
        
        NSString *str_parameter = [NSString stringWithFormat:@"openapi/publicAssistanceFigurecover_api.do?count=0&countPerPage=302"];
        
        // Send request
        [client getPath:str_parameter parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
            
            NSError *error;
            Technologyinfo = (NSDictionary*)[Parser objectWithString:operation.responseString error:&error];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"%@", error);   
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    return Technologyinfo;
    
}

- (NSDictionary *) GetPicseqno : (NSInteger) idx  {
    
    @try {
        // Create client
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.ibtk.kr/"]];
        
        NSString *str_parameter = [NSString stringWithFormat:@"openapi/publicAssistanceFigurecoverDetail_api.do?picseqno=%d", idx];
        
        // Send request
        [client getPath:str_parameter parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
            NSError *error;
            Technologyinfo = (NSDictionary *)[Parser objectWithString:operation.responseString error:&error];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"%@", error);
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    return Technologyinfo;
}

- (BOOL) GetFileNamePicseqno : (NSInteger) idx info : (NSDictionary *) info {
    for(int i=0;i<PICSEQNOMAX;i++) {
        NSString *picseqno = [[[info objectForKey:@"ksp_list"] objectAtIndex:i] objectForKey:@"picseqno"];
        if ([picseqno integerValue] == idx) {
            Filename = [[[info objectForKey:@"ksp_list"] objectAtIndex:i] objectForKey:@"fileName"];
            return true;
        }
    }
    return false;
}

- (BOOL) GetPicseqnoInfo : (NSInteger) idx info : (NSDictionary *) info {
    for(int i=0;i<PICSEQNOMAX;i++) {
        NSString *picseqno = [[[info objectForKey:@"ksp_list"] objectAtIndex:i] objectForKey:@"picseqno"];
        if ([picseqno integerValue] == idx) {
            KorName = [[[info objectForKey:@"ksp_list"] objectAtIndex:i] objectForKey:@"korName"];
            EngName = [[[info objectForKey:@"ksp_list"] objectAtIndex:i] objectForKey:@"engName"];
            ApplyField = [[[info objectForKey:@"ksp_list"] objectAtIndex:i] objectForKey:@"applyField"];
            Description = [[[info objectForKey:@"ksp_list"] objectAtIndex:i] objectForKey:@"description"];
            return true;
        }
    }
    return false;
}

- (UIImage *) GetImageData : (NSInteger) idx {
    
    if(Filename == nil) return nil;

    UIImageView *imageView;
    
    @try {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
        [imageView setImageWithURL:[NSURL URLWithString:Filename] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    if (imageView.image != nil) {
        return imageView.image;
    }
    
    return nil;      
}

+ (NSDictionary *) GetUserRankList {
    RankList = [[NSDictionary alloc] init];
    Parser = [[SBJsonParser alloc] init];
    NSURLResponse * response = nil;
    NSError *error = nil;
    
    NSURL *url = [NSURL URLWithString:@"http://noantech.cafe24.com/app/apps_contest.php?cmd=1"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString *text = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
    NSDictionary *info = (NSDictionary*)[Parser objectWithString:text error:&error];
    
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
    NSString *text = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
    NSDictionary *info = (NSDictionary*)[Parser objectWithString:text error:&error];
    if ([[info valueForKey:@"result"] integerValue] == 1) {
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
    RankList = [[NSDictionary alloc] init];
    Parser = [[SBJsonParser alloc] init];
    NSURLResponse * response = nil;
    NSError *error = nil;
    userName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"http://noantech.cafe24.com/app/apps_contest.php?cmd=4&name=%@", userName, nil];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString *text = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
    NSDictionary *info = (NSDictionary*)[Parser objectWithString:text error:&error];
    
    return info;
}

@end

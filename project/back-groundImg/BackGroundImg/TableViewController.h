//
//  TableViewController.h
//  BackGroundImg
//
//  Created by Administrator on 12. 6. 9..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 
#import "httpaddress.h"
#import "MBProgressHUD.h"
#import "Downloader.h"
#import "SBJSON.h"
#import "GADBannerView.h"
#import "IconDownloader.h"
#import "AppRecord.h"

@interface TableViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, MBProgressHUDDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, IconDownloaderDelegate, UIScrollViewDelegate, MFMailComposeViewControllerDelegate>
{
    MBProgressHUD *_HUD;
    SBJsonParser *parser;
    NSDictionary* person;
    NSArray *arr;
  	NSString *downloadedpath;	
	NSInteger downloading;
    NSInteger Touchindex;	 
    NSMutableDictionary *imageDownloadsInProgress;
    GADBannerView *bannerView_;
    //이미지 저장
    NSData *_bimg;
}
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) NSArray *listData;
@property (nonatomic) IBOutlet UITextField *Search;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;

- (IBAction)SearchClick:(id)sender;
- (IBAction)section:(id)sender;
- (IBAction)pageback:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)btnComposeEmail:(id)sender;

@end

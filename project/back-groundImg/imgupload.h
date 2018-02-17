//
//  imgupload.h
//  BackGroundImg
//
//  Created by Administrator on 12. 6. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCApiQuery.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

#import "GADBannerView.h"


@interface imgupload : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate, MCApiQueryDelegete,MBProgressHUDDelegate, UIAlertViewDelegate>
{
    UIPickerView *singlePicker;
    NSArray *pickerData;
    MBProgressHUD *_HUD; 
    NSInteger i; //피커뷰 인덱스
    GADBannerView *bannerView_;
}
@property (nonatomic,retain) IBOutlet UIPickerView *singlePicker;
@property (nonatomic,retain) NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UITextField *title;
@property (weak, nonatomic) IBOutlet UITextField *username;

- (IBAction)imguse:(id)sender;
- (IBAction)pageback:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)imgupload:(id)sender;
@end

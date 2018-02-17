//
//  ViewController.h
//  BackGroundImg
//
//  Created by Administrator on 12. 5. 23..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "GADBannerView.h"
#import <StoreKit/SKProductsRequest.h>
#import <StoreKit/SKProduct.h>
#import <StoreKit/SKPaymentQueue.h>
#import <StoreKit/SKPaymentTransaction.h>

@interface ViewController : UIViewController<SKPaymentTransactionObserver>
{
    GADBannerView *bannerView_;
    SKProductsRequest *productRequest;
}

- (IBAction) backgroundimg:(id)sender;
- (IBAction) imgupload:(id)sender;
- (IBAction)info:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imgupload;
@property (weak, nonatomic) IBOutlet UIButton *appinfo;
@property (weak, nonatomic) IBOutlet UIButton *imgsee;

@end
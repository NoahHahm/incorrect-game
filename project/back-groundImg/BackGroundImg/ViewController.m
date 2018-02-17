//
//  ViewController.m
//  BackGroundImg
//
//  Created by Administrator on 12. 5. 23..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "imgupload.h"
#import "AppDelegate.h"
#import "infomation.h"
#import <stdlib.h>
#import "GADBannerView.h"
#import "HFViewController.h"
#import <StoreKit/SKProductsRequest.h>
#import <StoreKit/SKProduct.h>
#import <StoreKit/SKPaymentQueue.h>
#import <StoreKit/SKPaymentTransaction.h>

#define MY_BANNER_UNIT_ID @"a14ff46a93a9572";

@interface ViewController ()

@end

@implementation ViewController
@synthesize imgupload;
@synthesize appinfo;
@synthesize imgsee;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"SKPaymentTransactionStateRestored");
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"SKPaymentTransactionStateFailed");	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
	NSLog(@"SKPaymentTransactionStatePurchased");
    
	NSLog(@"Trasaction Identifier : %@", transaction.transactionIdentifier);
	NSLog(@"Trasaction Date : %@", transaction.transactionDate);
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
	NSLog(@"SKProductRequest got response");
	if( [response.products count] > 0 ) {
		SKProduct *product = [response.products objectAtIndex:0];
		NSLog(@"Title : %@", product.localizedTitle);
		NSLog(@"Description : %@", product.localizedDescription);
		NSLog(@"Price : %@", product.price);
	}
	
	if( [response.invalidProductIdentifiers count] > 0 ) {
		NSString *invalidString = [response.invalidProductIdentifiers objectAtIndex:0];
		NSLog(@"Invalid Identifiers : %@", invalidString);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"111" 
                                                        message:invalidString
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
        
        [alert show];
	}
}
- (void)viewDidLoad
{
    [super viewDidLoad];  
    
    if ([SKPaymentQueue canMakePayments]) {	// 스토어가 사용 가능하다면
        NSLog(@"Start Shop!");
		
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];	// Observer를 등록한다.
    }
    else
        NSLog(@"Failed Shop!");
    
    
    productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"adkiller"]];
    productRequest.delegate = self;
	
    [productRequest start];
    
    

    
    // 화면 하단에 표준 크기의 뷰를 만듭니다.
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    // 광고의 '단위 ID'로 AdMob 게시자 ID를 지정합니다.
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    
    // 광고의 방문 페이지로 사용자를 연결한 후 복구할 UIViewController를
    // 지정하여 뷰 계층에 추가합니다.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // 기본 요청을 시작하여 광고와 함께 로드합니다.
    [bannerView_ loadRequest:[GADRequest request]];
     
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
}

- (void)viewDidUnload
{
    [self setImgupload:nil];
    [self setAppinfo:nil];
    [self setImgsee:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)backgroundimg:(id)sender {
    TableViewController *view = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    [self presentModalViewController:view animated:YES];
}
- (IBAction) imgupload:(id)sender
{
    imgupload *userview = [[imgupload alloc] initWithNibName:@"imgupload" bundle:nil];
    [self presentModalViewController:userview animated:YES];
}

- (IBAction)info:(id)sender {  
    
    infomation *_view = [[infomation alloc] initWithNibName:@"infomation" bundle:nil];
    [self presentModalViewController:_view animated:YES];
     
}
@end

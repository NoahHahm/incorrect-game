//
//  infomation.m
//  BackGroundImg
//
//  Created by Administrator on 12. 6. 26..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "infomation.h"
#import "GADBannerView.h"

#define MY_BANNER_UNIT_ID @"a14ff46a93a9572";

@interface infomation ()

@end

@implementation infomation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    datalist = [[NSArray alloc] initWithObjects:@"배경바꿔 (BackGroundChanger)", @"Copyright(저작권)&App(어플) 문의", nil];
    subdatalist = [[NSArray alloc] initWithObjects:@"Version : 1.1", @"contact@itholicer.com", nil];
    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->datalist count];     
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AA"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self->datalist objectAtIndex:[indexPath row]];
    cell.detailTextLabel.text = [self->subdatalist objectAtIndex:[indexPath row]];
    
    return cell;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

@end

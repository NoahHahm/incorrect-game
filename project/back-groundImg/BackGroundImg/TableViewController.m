//
//  TableViewController.m
//  BackGroundImg
//
//  Created by Administrator on 12. 6. 9..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <MessageUI/MessageUI.h> 
#import "TableViewController.h"
#import "CustomCell.h"
#import "WebPictureViewController.h"
#import "SBJSON.h"
#import "Downloader.h"
#import "GADBannerView.h"
#import "IconDownloader.h"
#import "AppRecord.h"


#define NS_EUC_KR_Encoding

#define MY_BANNER_UNIT_ID @"a14ff46a93a9572";
@interface TableViewController ()
- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath;
@end

@implementation TableViewController

@synthesize TableView;
@synthesize listData;
@synthesize Search,imageDownloadsInProgress;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[UIActivity startAnimating];
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_HUD];
    [_HUD setCenter:CGPointMake(160, 190)];
    _HUD.delegate = self;
    
    _HUD.labelText = @"Loading..";
    [_HUD show:YES];
    
    httpaddress *address = [[httpaddress alloc] init];
    [address getHtmlCode:@"http://noantech.cafe24.com/app/main.php?main=0"];
    [address setDelegate:self];  
    //[TableView reloadData];
    //[self performSelector:@selector(ViewStartDelay) withObject:nil afterDelay:2];
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
    [self setTableView:nil];
    [self setSearch:nil];
    [super viewDidUnload];
    [_HUD hide:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)downComplete:(NSString*)_downString
{
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    //주소 파싱   
    NSError *error;   
    person = (NSDictionary*)[parser objectWithString:_downString error:&error]; 
    [TableView reloadData];
    [_HUD hide:YES];
}

 #pragma mark -
 #pragma mark Table View Data Source Methods

 - (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     return [[person objectForKey: @"items"] count];     
 }

 - (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     static NSString *identifier = @"mycell";
     CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:identifier];

     if (cell == nil)
     {
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
         cell = (CustomCell *)[nib objectAtIndex:0];
     }
     
     cell.Title.text = [[[person objectForKey: @"items"] objectAtIndex:indexPath.row] objectForKey:@"Title"];
     cell.Uploader.text = [[[person objectForKey: @"items"] objectAtIndex:indexPath.row] objectForKey:@"name"];
     cell.Date.text = [[[person objectForKey: @"items"] objectAtIndex:indexPath.row] objectForKey:@"Date"];
     cell.Section.text = [[[person objectForKey: @"items"] objectAtIndex:indexPath.row] objectForKey:@"Section"];
     

     AppRecord *appRecord = [[AppRecord alloc] init];
     // Only load cached images; defer new downloads until scrolling ends
     if (!appRecord._Artimg)
     {
         if (TableView.dragging == NO && TableView.decelerating == NO)
         {
             appRecord.imageURLString = [[[person objectForKey: @"items"] objectAtIndex:indexPath.row] objectForKey:@"Realurl"];
             [self startIconDownload:appRecord forIndexPath:indexPath];
         }
        cell.backimg.image = nil;
     }
     else
     {
         cell.backimg.image = appRecord._Artimg;
     }
     
     return cell;
 }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
 }
 
- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Touchindex = indexPath.row;
    
    NSURL *imgurl = [NSURL URLWithString:[[[person objectForKey: @"items"] objectAtIndex:Touchindex] objectForKey:@"Realurl"]];
    _bimg = [NSData dataWithContentsOfURL:imgurl];  
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image See" 
                                                    message:@"이미지를 보시겠습니까?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
     
    [alert show];

}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{            
    switch (buttonIndex) {
        case 1:
            {
                WebPictureViewController *photoView = [[WebPictureViewController alloc] initWithNibName:@"WebPictureViewController" bundle:nil];
                [self presentModalViewController:photoView animated:YES];
            
                [photoView downPicture:[[[person objectForKey: @"items"] objectAtIndex:Touchindex] objectForKey:@"Realurl"] filename:@""];
            }
            break;
    }
}
- (IBAction)SearchClick:(id)sender {
    [imageDownloadsInProgress removeAllObjects];
    [Search resignFirstResponder];    
    
    NSString *str = @"http://noantech.cafe24.com/app/search.php?search=1&title=";
    NSString *str1 = Search.text;
    NSString *strresult = [str stringByAppendingString:str1];
    NSLog(@"%@",strresult);
    httpaddress *address = [[httpaddress alloc] init];
    [address getHtmlCode:NS_EUC_KR_Encoding strresult];
    [address setDelegate:self]; 
}

- (IBAction)section:(id)sender {
    /*
     0 - 메인
     1 - 자연
     2 - 연예인/인물
     3 - 동물
     4 - 만화/애니
     5 - 패션/스타일
     6 - 섹시
     7 - 기타
     */   
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Filter Choose(필터 선택)"
															 delegate:self
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil
													otherButtonTitles:@"All", @"Nature(자연)", @"Star/Person(연예인/사람)", @"Animal(동물)", @"Cartoon(만화/애니)",@"Fashion(패션/스타일)",@"Sexy(섹시)",@"Etc", nil];
	[actionSheet showInView:self.view];    
}
- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [imageDownloadsInProgress removeAllObjects];
   httpaddress *address = [[httpaddress alloc] init];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    [_HUD setCenter:CGPointMake(160, 190)];
    _HUD.delegate = self;
    
    _HUD.labelText = @"Loading..";
    [_HUD show:YES];
    
	if(buttonIndex != [actionSheet cancelButtonIndex])
	{  
        NSString * urlString = [NSString stringWithFormat: @"http://noantech.cafe24.com/app/main.php?main=%d", buttonIndex] ;
        [address getHtmlCode:urlString];
        [address setDelegate:self];  
	}
}
- (IBAction)pageback:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)backgroundTap:(id)sender
{
    [Search resignFirstResponder];    
}

#pragma mark -
#pragma mark Table cell image support

- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([[person objectForKey: @"items"] count] > 0)
    {
        NSArray *visiblePaths = [TableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            AppRecord *appRecord = [[AppRecord alloc] init];    
            IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
            
            if (!appRecord._Artimg) // avoid the app icon download if the app already has an icon
            {
                appRecord.imageURLString = [[[person objectForKey: @"items"] objectAtIndex:indexPath.row] objectForKey:@"Realurl"];
                
                [self startIconDownload:appRecord forIndexPath:indexPath];
                
                CustomCell *cell = [TableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
                cell.backimg.image = iconDownloader.appRecord._Artimg;
            }
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        CustomCell *cell = [TableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        cell.backimg.image = iconDownloader.appRecord._Artimg;
    }
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}
- (IBAction)btnComposeEmail:(id)sender
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:nil];
    
    // 수신자 설정    
    NSArray *toRecipients = [NSArray arrayWithObjects:nil, nil];
    
    [picker setToRecipients:toRecipients];
    
    // 이미지 첨부하기
    [picker addAttachmentData:_bimg mimeType:@"image/png" fileName:@"img.png"];
    
    // 본문 채우기
    [picker setMessageBody:nil isHTML:NO];
    
    [self presentModalViewController:picker animated:YES];
    
}
#pragma mark -
#pragma mark 메일 델리게이트
- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
	    case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle:@"성공" 
                                        message:@"성공적으로 보냈습니다." 
                                       delegate:nil 
                              cancelButtonTitle:@"확인" 
                              otherButtonTitles:nil] show];
            break;
        case MFMailComposeResultFailed:
			[[[UIAlertView alloc] initWithTitle:@"실패" 
                                        message:@"전송에 실패했습니다." 
                                       delegate:nil 
                              cancelButtonTitle:@"확인" 
                              otherButtonTitles:nil] show];
            break;
    };
    [controller dismissModalViewControllerAnimated:YES];
}
@end
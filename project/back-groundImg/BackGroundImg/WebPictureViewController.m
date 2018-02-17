#import "WebPictureViewController.h"
#import "AppDelegate.h"
#import "Downloader.h"
#import "MBProgressHUD.h"
#import "CustomCell.h"
#import "GADBannerView.h"
#import "GlobalVar.h"
#import "HFViewController.h"

#define MY_BANNER_UNIT_ID @"a14ff46a93a9572";

@implementation WebPictureViewController
@synthesize scrollView, activityView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 //self.title = NSLocalizedString(@"First", @"First");
 //self.tabBarItem.image = [UIImage imageNamed:@"first"];
 }
 return self;
 }



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"사진보기";
	imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	
	[scrollView addSubview:imageView];
	[scrollView setContentOffset:CGPointMake(0, 0)];
	scrollView.showsVerticalScrollIndicator = NO;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.bouncesZoom = YES;
	scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
	
	
	/*
	
	float mylocale = (float)320.0/(float)imageView.image.size.width;
	imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);

	[scrollView setContentSize:imageView.image.size];

	scrollView.minimumZoomScale = mylocale;
	scrollView.maximumZoomScale = 4.0;

	[scrollView setZoomScale:mylocale animated:NO];
	*/
	
	
	activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityView.frame = CGRectMake(150, 220, 30, 30);
	[self.view addSubview:activityView];
        
    
  

}
- (IBAction)onClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)? 
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)? 
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, 
                                   scrollView.contentSize.height * 0.5 + offsetY);
}
- (void)downPicture:(NSString *)picurl filename:(NSString *)filename {
    [self startIconDownloadForUrl:picurl];
}

#pragma mark - imageDownLoader delegate
- (void)startIconDownloadForUrl:(NSString *)url{
    [activityView startAnimating];
	downloading = 1;
    
    Downloader* iconDownloader = [[Downloader alloc] init];
    iconDownloader.imageURL = [NSURL URLWithString:url];
    
    iconDownloader.indexPathInTableView = nil;
    iconDownloader.idxString = url;
    iconDownloader.delegate = self;
    iconDownloader.type = 8;
    [iconDownloader startDownload];
}


- (void)Downloader:(Downloader *)downloader didFinished:(UIImage *)image {
    [imageView setImage:image];
    
    downloading = 0;
	[activityView stopAnimating];
	float mylocale_x = (float)scrollView.frame.size.width/(float)imageView.image.size.width;
    float mylocale_y = (float)scrollView.frame.size.height/(float)imageView.image.size.height;
    float y = (float)(scrollView.frame.size.height - imageView.image.size.height*mylocale_x)/2.0f;
    
	NSLog(@"사이즈2:%f, %f, %f", scrollView.frame.size.height, imageView.image.size.height*mylocale_x, mylocale_x);
	imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
	NSLog(@"사이즈2:%f    %f,%f, %f",y,imageView.image.size.width, imageView.image.size.height, mylocale_x);
	
	scrollView.minimumZoomScale = mylocale_x;
	scrollView.maximumZoomScale = 4.0;
	
	[scrollView setContentSize:CGSizeMake(imageView.image.size.width, imageView.image.size.height)];
	[scrollView setZoomScale:mylocale_x animated:YES];   
    
    GlobalVar *img = [GlobalVar sharedInstance];
    img._image = imageView.image; 	
    
}
- (IBAction)onSave:(id)sender
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_HUD];
    [_HUD setCenter:CGPointMake(160, 190)];
    _HUD.delegate = self;
    
    _HUD.labelText = @"Saveing..";
    [_HUD show:YES];
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, nil, nil);  
    [_HUD hide:YES];  
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Success!\n(기본앨범에 저장 성공)" 
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (IBAction)facebook:(id)sender {
    HFViewController *_view = [[HFViewController alloc] initWithNibName:@"HFViewController" bundle:nil];
    [self presentModalViewController:_view animated:YES];
}
@end

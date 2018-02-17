#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "TableViewController.h"
#import "GADBannerView.h"


@interface WebPictureViewController : UIViewController 
<UIScrollViewDelegate, MBProgressHUDDelegate, UIAlertViewDelegate> {
	UIScrollView *scrollView;
	UIActivityIndicatorView *activityView;	
	UIImageView *imageView;    
	NSString *downloadedpath;	
	NSInteger downloading;	
    MBProgressHUD *_HUD;
    GADBannerView *bannerView_;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;
- (IBAction)onClose:(id)sender;
- (IBAction)onSave:(id)sender;
- (void)downPicture:(NSString *)picurl filename:(NSString *)filename;
- (void)startIconDownloadForUrl:(NSString *)url;
- (IBAction)facebook:(id)sender;

@end

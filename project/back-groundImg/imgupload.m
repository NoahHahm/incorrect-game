//
//  imgupload.m
//  BackGroundImg
//
//  Created by Administrator on 12. 6. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "imgupload.h"
#import "AppDelegate.h"
#import "GADBannerView.h"

#define MY_BANNER_UNIT_ID @"a14ff46a93a9572";
@interface imgupload ()

@end

@implementation imgupload
@synthesize singlePicker;
@synthesize pickerData;
@synthesize Image;
@synthesize title;
@synthesize username;


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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_HUD];
    [_HUD setCenter:CGPointMake(160, 190)];
    _HUD.delegate = self;

    NSArray *array = [[NSArray alloc]initWithObjects:@"Nature(자연)", @"Star/Person(연예인/사람)", @"Animal(동물)", @"Cartoon(만화/애니)",@"Fashion(패션/스타일)",@"Sexy(섹시)",@"Etc" ,nil];
    self.pickerData = array; 
    
    i = 1; // 피커뷰 기본값   
    
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
    /*
    // AdamAdView 객체를 가져온다.
    AdamAdView *adView = [AdamAdView sharedAdView];
    if (![adView.superview isEqual:self.view]) {
        // adView가 self.view에 붙어있는 상태가 아니라면,
        // adView에 필요한 속성을 설정한 후 self.view에 붙인다.
        adView.frame = CGRectMake(0.0, 412.0, 320.0, 48.0);
        adView.clientId = @"2f66Z02T1382dcc29b0";
        [self.view addSubview:adView];
        if (!adView.usingAutoRequest) {
            // adView가 광고 자동요청 기능을 사용하는 상태가 아니라면,
            // 60초 간격으로 광고 자동요청을 시작한다.
            [adView startAutoRequestAd:15.0];
        }
    }
    */
}
- (void)viewDidUnload
{
    [self setImage:nil];
    [self setTitle:nil];
    [self setUsername:nil];
    //[self setImgupload:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1; 
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [pickerData objectAtIndex:row];
    
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
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
    //NSLog(@"선택 : %i 결과 : %@", row+1, [pickerData objectAtIndex:row]);
    i = (row+1);
}

- (IBAction)pageback:(id)sender
{
    [self dismissModalViewControllerAnimated:YES]; 
}

- (IBAction)imguse:(id)sender
{
     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     picker.delegate = self;
     [self presentModalViewController:picker animated:YES];
}

- (void)uploadPictureWithData:(NSData*)pictureData {
    MCApiQuery *query = [[MCApiQuery alloc] init];
    query.delegate = self;
    //query.session = 33;
    [query query_uploadPicture:pictureData _section:i _title:title.text _uploader:username.text];    
}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
	//nowPicker = picker;	
	[picker dismissModalViewControllerAnimated:YES];
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [Image setImage:image];
	//[NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:image];

}

- (void)useImage:(UIImage *)image {
    
	CGSize newSize = CGSizeMake(image.size.width, image.size.height);
	
	if(image.size.height >= image.size.width) {
		if(image.size.height > 1024) {
			newSize.height = (float)1024;
			float rate = newSize.height/(image.size.height);
			newSize.width = image.size.width * rate;
		}
	} else {
		if(image.size.width > 1024) {
			newSize.width = (float)1024;
			float rate = (newSize.width)/(image.size.width);
			newSize.height = image.size.height * rate;
		}
	}
	
	UIGraphicsBeginImageContext(newSize);
	// Tell the old image to draw in this new context, with the desired
	// new size
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	// Get the new image from the context
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	// End the context
	UIGraphicsEndImageContext();
	NSData* imageData = UIImageJPEGRepresentation(newImage, 0.30);
	[self performSelectorOnMainThread:@selector(uploadPictureWithData:) withObject:imageData waitUntilDone:YES];
}
/*
- (NSInteger)getSection {
    return Section;
}
 */
- (void)apiQueryBegin:(MCApiQuery*)sender
{
    _HUD.labelText = @"Uploading...";
    [_HUD show:YES];
}

- (void)apiQueryEnd:(MCApiQuery*)sender
{
    
}

- (void)apiQuerySucceeded:(MCApiQuery*)sender content:(NSString*)content
{
    [_HUD hide:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Upload Success!" 
                                                        message:@"Upload Success!\n(업로드 성공)"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
    [self dismissModalViewControllerAnimated:YES]; 
}

- (void)apiQueryFailed:(MCApiQuery*)sender
{
    [_HUD hide:YES];
}
- (IBAction)backgroundTap:(id)sender
{
    [title resignFirstResponder];
    [username resignFirstResponder];
}

- (IBAction)imgupload:(id)sender {
    
    UIAlertView *textalert = [[UIAlertView alloc] initWithTitle:@"Upload Impossible!" 
                                                    message:@"Blank All Input!\n(빈칸을 모두 입력하세요)"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Yes", nil];
    
    UIAlertView *imgalert = [[UIAlertView alloc] initWithTitle:@"Upload Impossible!" 
                                                    message:@"Image Choose!\n(이미지를 선택하세요)"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Yes", nil];
    
    
    UIAlertView *titlealert = [[UIAlertView alloc] initWithTitle:@"Upload Impossible!" 
                                                        message:@"Title length 15 below\n(제목은 15글자 이하 입력)"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                               otherButtonTitles:@"Yes", nil];
    
    UIAlertView *usernamealert = [[UIAlertView alloc] initWithTitle:@"Upload Impossible!" 
                                                         message:@"Uploader Name length 10 below\n(이름은 10글자 이하 입력)"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"Yes", nil];
    
    if (Image.image.size.height < 1 || Image.image.size.width < 1)
    {
        [imgalert show];  
    }
    else if (title.text.length < 1 || username.text.length < 1)
    {
        [textalert show];          
    }
    else if (title.text.length > 15)
    {
        [titlealert show]; 
    }
    else if (username.text.length > 10)
    {
        [usernamealert show]; 
    }
    else
    {
        [self useImage:Image.image];
    }    
}

@end

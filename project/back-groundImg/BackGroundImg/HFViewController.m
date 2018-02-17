/*
 * Copyright 2012 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "HFViewController.h"
#import "AppDelegate.h"
#import "GlobalVar.h"
#import <FBiOSSDK/FacebookSDK.h>
#import "GADBannerView.h"

#define MY_BANNER_UNIT_ID @"a14ff46a93a9572";


@implementation HFViewController
@synthesize faceimage = _faceimage;
@synthesize buttonPostPhoto = _buttonPostPhoto;
@synthesize labelFirstName = _labelFirstName;
@synthesize loggedInUser = _loggedInUser;
@synthesize profilePic = _profilePic;

- (void)viewDidLoad {  
    
    [super viewDidLoad];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    [_HUD setCenter:CGPointMake(160, 190)];
    _HUD.delegate = self;
    
    _HUD.labelText = @"Uploading..";
    
    GlobalVar *img = [GlobalVar sharedInstance];
    _faceimage.image = img._image;
    
    // Create Login View so that the app will be granted "status_update" permission.
    FBLoginView *loginview = 
        [[FBLoginView alloc] initWithPermissions:[NSArray arrayWithObject:@"status_update"]];
    
    loginview.frame = CGRectOffset(loginview.frame, 5, 50);
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
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
- (void)viewDidUnload {
    self.buttonPostPhoto = nil;
    self.labelFirstName = nil;
    self.loggedInUser = nil;
    self.profilePic = nil;
    [self setFaceimage:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
    self.buttonPostPhoto.enabled = YES;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the userID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.userID = user.id;
    self.loggedInUser = user;
}
 
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.buttonPostPhoto.enabled = NO;
    
    self.profilePic.userID = nil;            
    self.labelFirstName.text = nil;
}


// Post Photo button handler
- (IBAction)postPhotoClick:(UIButton *)sender {
    
    // Just use the icon image from the application itself.  A real app would have a more 
    // useful way to get an image.
    

    [_HUD show:YES];
    
    
    // Build the request for uploading the photo
    FBRequest *photoUploadRequest = [FBRequest requestForUploadPhoto:_faceimage.image];
    
    // Then fire it off.
    [photoUploadRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {  
        
        [self showAlert:nil result:result error:error];
        self.buttonPostPhoto.enabled = YES;
    }];
    
    self.buttonPostPhoto.enabled = NO;
}


// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {

    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = error.localizedDescription;
        alertTitle = @"Error";
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully Posted.\n페이스북에 이미지 전송 성공!", 
                    message];
        alertTitle = @"FaceBook Send Success!";
    }

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [_HUD hide:YES];
    [alertView show];
}

- (IBAction)pageback:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end

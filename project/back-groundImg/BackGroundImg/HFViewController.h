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

#import <UIKit/UIKit.h>
#import <FBiOSSDK/FacebookSDK.h>
#import "GADBannerView.h"
#import "MBProgressHUD.h"

@interface HFViewController : UIViewController<FBLoginViewDelegate, MBProgressHUDDelegate>
{	
    MBProgressHUD *_HUD;
	UIImageView *imageView;
    GADBannerView *bannerView_;        
}
- (IBAction)pageback:(id)sender;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UIButton *buttonPostPhoto;
@property (strong, nonatomic) IBOutlet UILabel *labelFirstName;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

- (IBAction)postPhotoClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *faceimage;

- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error;
@end

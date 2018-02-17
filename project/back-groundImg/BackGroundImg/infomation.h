//
//  infomation.h
//  BackGroundImg
//
//  Created by Administrator on 12. 6. 26..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

@interface infomation : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *datalist;
    NSArray *subdatalist;
    GADBannerView *bannerView_;
}
- (IBAction)back:(id)sender;
@end

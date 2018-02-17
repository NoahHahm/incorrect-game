//
//  RankViewController.h
//  incorrect
//
//  Created by Administrator on 13. 2. 19..
//
//

#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface RankViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *RankDataInfo;
    int RankCount;
}
@property (retain, nonatomic) IBOutlet UITableView *RankTableView;

@end

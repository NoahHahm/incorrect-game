//
//  RankViewController.m
//  incorrect
//
//  Created by Administrator on 13. 2. 19..
//
//

#import "RankViewController.h"
#import "RankCell.h"
#import "ServiceApi.h"
#import "SBJson.h"

@implementation RankViewController
@synthesize RankTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        RankDataInfo = [ServiceApi GetUserRankList];
        RankCount = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    RankTableView.transform = CGAffineTransformRotate(RankTableView.transform, M_PI*2/4);
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    RankCell *cell = (RankCell *) [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[RankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    RankCount++;
    
    NSString *str = [NSString stringWithFormat:@"순위 : %@ / 이름 : %@ / 점수 : %@", [[RankDataInfo valueForKey:@"id"] objectAtIndex:indexPath.row], [[RankDataInfo valueForKey:@"name"] objectAtIndex:indexPath.row],[[RankDataInfo valueForKey:@"score"] objectAtIndex:indexPath.row], nil];
    
    UIImage *img = [UIImage imageNamed:@"ranking.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(0, 0, 266, 53);
    [cell setBackgroundView:imgView];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
    cell.textLabel.text = str;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [RankDataInfo count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)dealloc {
    [RankTableView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setRankTableView:nil];
    [super viewDidUnload];
}
@end

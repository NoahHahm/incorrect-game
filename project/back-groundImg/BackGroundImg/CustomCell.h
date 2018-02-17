//
//  CustomCell.h
//  BackGroundImg
//
//  Created by Administrator on 12. 6. 10..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backimg;
@property (weak, nonatomic) IBOutlet UILabel *Uploader;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Section;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@end

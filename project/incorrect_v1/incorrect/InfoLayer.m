//
//  InfoLayer.m
//  incorrect
//
//  Created by Administrator on 13. 1. 20..
//
//

#import "InfoLayer.h"

@implementation InfoLayer

@synthesize KorName_Sub, EngName_Sub, Description_Sub, btn, Delegate, ApplyField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        KorName_Sub = [[UILabel alloc] initWithFrame:CGRectMake(106, 305, 270, 20)];
        EngName_Sub = [[UILabel alloc] initWithFrame:CGRectMake(74, 305, 270, 20)];
        ApplyField = [[UILabel alloc] initWithFrame:CGRectMake(45, 297, 270, 30)];
        Description_Sub = [[UILabel alloc] initWithFrame:CGRectMake(15, 297, 270, 40)];
    }
    return self;
}
- (IBAction)btn:(id)sender {
    [self.view removeFromSuperview];
    [Delegate InfoLayerDelegate];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *korName = [[UILabel alloc] initWithFrame:CGRectMake(190, 140, 100, 20)];
    korName.backgroundColor = [UIColor clearColor];
    korName.textColor = [UIColor blueColor];
    [korName setText:@"한글 명칭 :"];
    
    UILabel *engName = [[UILabel alloc] initWithFrame:CGRectMake(160, 140, 100, 20)];
    engName.backgroundColor = [UIColor clearColor];
    engName.textColor = [UIColor blueColor];
    [engName setText:@"영문 명칭 :"];
    
    UILabel *applyField = [[UILabel alloc] initWithFrame:CGRectMake(130, 140, 100, 20)];
    applyField.backgroundColor = [UIColor clearColor];
    applyField.textColor = [UIColor blueColor];
    [applyField setText:@"적용 필드 :"];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 100, 20)];
    description.backgroundColor = [UIColor clearColor];
    description.textColor = [UIColor blueColor];
    [description setText:@"기술 설명 :"];
    
    
    
    KorName_Sub.backgroundColor = [UIColor clearColor];
    EngName_Sub.backgroundColor = [UIColor clearColor];
    Description_Sub.backgroundColor = [UIColor clearColor];
    ApplyField.backgroundColor = [UIColor clearColor];
    
    [Description_Sub setLineBreakMode:UILineBreakModeWordWrap];
    [Description_Sub setNumberOfLines:2];
    
    korName.transform = CGAffineTransformRotate(korName.transform, M_PI*2/4);
    KorName_Sub.transform = CGAffineTransformRotate(KorName_Sub.transform, M_PI*2/4);
    engName.transform = CGAffineTransformRotate(engName.transform, M_PI*2/4);
    EngName_Sub.transform = CGAffineTransformRotate(EngName_Sub.transform, M_PI*2/4);
    
    applyField.transform = CGAffineTransformRotate(applyField.transform, M_PI*2/4);
    ApplyField.transform = CGAffineTransformRotate(ApplyField.transform, M_PI*2/4);
    
    description.transform = CGAffineTransformRotate(description.transform, M_PI*2/4);
    Description_Sub.transform = CGAffineTransformRotate(Description_Sub.transform, M_PI*2/4);
    btn.transform = CGAffineTransformRotate(btn.transform, M_PI*2/4);
    
    [self.view addSubview:korName];
    [self.view addSubview:KorName_Sub];
    [self.view addSubview:engName];
    [self.view addSubview:EngName_Sub];
    [self.view addSubview:description];
    [self.view addSubview:Description_Sub];
    [self.view addSubview:applyField];
    [self.view addSubview:ApplyField];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [KorName_Sub setText:KorName_Sub.text];
    [EngName_Sub setText:EngName_Sub.text];
    [Description_Sub setText:Description_Sub.text];
    [ApplyField setText:ApplyField.text];
}
- (void)dealloc {
    [btn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBtn:nil];
    [super viewDidUnload];
}
@end

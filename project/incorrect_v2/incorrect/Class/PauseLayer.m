//
//  PauseLayer.m
//  incorrect
//
//  Created by Administrator on 13. 2. 11..
//
//

#import "PauseLayer.h"

@interface PauseLayer ()

@end

@implementation PauseLayer
@synthesize Delegate;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_PauseView release];
    [_HomeButton release];
    [_ContinueButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPauseView:nil];
    [self setHomeButton:nil];
    [self setContinueButton:nil];
    [super viewDidUnload];
}
- (IBAction)HomeAction:(id)sender {
    [self.view removeFromSuperview];
    [Delegate HomeDelegate];
}

- (IBAction)ContinueAction:(id)sender {
    [UIView animateWithDuration:1.0
                          delay:1.0
                        options:UIViewAnimationTransitionFlipFromRight
                     animations:^{
                         self.view.frame = CGRectMake(0, 480, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                         [self.view removeFromSuperview];
                         [Delegate ContinueDelegate];
                     }];
    
}
@end

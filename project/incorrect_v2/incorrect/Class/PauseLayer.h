//
//  PauseLayer.h
//  incorrect
//
//  Created by Administrator on 13. 2. 11..
//
//

#import <UIKit/UIKit.h>

@protocol PauseLayerProtocol <NSObject>
- (void) ContinueDelegate;
- (void) HomeDelegate;
@end

@interface PauseLayer : UIViewController
@property (retain, nonatomic) IBOutlet UIView *PauseView;
@property (retain, nonatomic) IBOutlet UIButton *HomeButton;
@property (retain, nonatomic) IBOutlet UIButton *ContinueButton;
@property (nonatomic, assign) id Delegate;
- (IBAction)HomeAction:(id)sender;
- (IBAction)ContinueAction:(id)sender;

@end

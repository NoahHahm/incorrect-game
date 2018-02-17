//
//  InfoLayer.h
//  incorrect
//
//  Created by Administrator on 13. 1. 20..
//
//

#import <UIKit/UIKit.h>

@protocol InfoLayerProtocol <NSObject>
- (void) InfoLayerDelegate;
@end

@interface InfoLayer : UIViewController

- (IBAction)btn:(id)sender;
@property (nonatomic, assign) UILabel *KorName_Sub;
@property (nonatomic, assign) UILabel *EngName_Sub;
@property (nonatomic, assign) UILabel *ApplyField;
@property (nonatomic, assign) UILabel *Description_Sub;
@property (retain, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, assign) id Delegate;
@end

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textFieldRed;
@property (nonatomic, strong) UITextField *textFieldGreen;
@property (nonatomic, strong) UITextField *textFieldBlue;
@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) UILabel *labelGreen;
@property (nonatomic, strong) UILabel *labelBlue;
@property (nonatomic, strong) UILabel *labelResultColor;
@property (nonatomic, strong) UIView *viewResultColor;
@property (nonatomic, strong) UIButton *buttonProcess;

- (void)calculateColor;
- (NSString*)hexColor:(UIColor*)color;
- (BOOL)isInteger:(NSString*)str;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)isValidColor;

@end


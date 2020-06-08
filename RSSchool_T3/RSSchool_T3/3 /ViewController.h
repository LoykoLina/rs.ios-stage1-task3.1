#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UITextField *textFieldRed;
@property (nonatomic, strong) UITextField *textFieldGreen;
@property (nonatomic, strong) UITextField *textFieldBlue;
@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) UILabel *labelGreen;
@property (nonatomic, strong) UILabel *labelBlue;
@property (nonatomic, strong) UILabel *labelResultColor;
@property (nonatomic, strong) UIView *viewResultColor;
@property (nonatomic, strong) UIButton *buttonProcess;

- (void)setUIElements;
- (void)setConstraits;
- (void)setConstraintsForTextField:(UITextField *)textField topAnchor:(NSLayoutAnchor *)topAnchor;
- (void)setUpTextField:(UITextField *)textfield withIdentifier:(NSString *)identifier;
- (void)setUpLabel:(UILabel *)label withIdentifier:(NSString *)identifier andText:(NSString *)text;
- (void)calculateColor;
- (NSString*)hexColor:(UIColor*)color;
- (BOOL)isInteger:(NSString*)str;
- (BOOL)isValidColor;

@end

@interface ViewController(TextFieldDelegate) <UITextFieldDelegate>

- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end


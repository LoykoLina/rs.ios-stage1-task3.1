#import "ViewController.h"

static const CGFloat kSpacing = 40;
static const CGFloat kLeadingLabels = 25;
static const CGFloat kLeadingTextFields = 100;
static const CGFloat kTrailing = -25;
static const CGFloat kLeadingViewResult = 130;
static const CGFloat kTopLabel = 40;
static const CGFloat kHeight = 40;
static const CGFloat kWidth = 60;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIElements];
    [self setConstraits];
}

- (void)setUIElements {
    self.view.accessibilityIdentifier = @"mainView";
  
    self.textFieldRed = [[UITextField alloc] init];
    [self setUpTextField:self.textFieldRed withIdentifier:@"textFieldRed"];
    
    self.textFieldGreen = [[UITextField alloc] init];
    [self setUpTextField:self.textFieldGreen withIdentifier:@"textFieldGreen"];
    
    self.textFieldBlue = [[UITextField alloc] init];
    [self setUpTextField:self.textFieldBlue withIdentifier:@"textFieldBlue"];
    
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(kLeadingLabels, kTopLabel, kWidth, kHeight)];
    [self setUpLabel:self.labelResultColor withIdentifier:@"labelResultColor" andText:@"Color"];
    
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(kLeadingLabels, self.labelResultColor.frame.origin.y + kHeight + kSpacing,
                                                              kWidth, kHeight)];
    [self setUpLabel:self.labelRed withIdentifier:@"labelRed" andText:@"RED"];

    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(kLeadingLabels, self.labelRed.frame.origin.y + kHeight + kSpacing,
                                                                kWidth, kHeight)];
    [self setUpLabel:self.labelGreen withIdentifier:@"labelGreen" andText:@"GREEN"];

    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(kLeadingLabels, self.labelGreen.frame.origin.y + kHeight + kSpacing,
                                                               kWidth, kHeight)];
    [self setUpLabel:self.labelBlue withIdentifier:@"labelBlue" andText:@"BLUE"];
    
    self.viewResultColor = [[UIView alloc] init];
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    [self.view addSubview:self.viewResultColor];
    
    self.buttonProcess = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    [self.buttonProcess setTitle:@"Process" forState: UIControlStateNormal];
    [self.buttonProcess addTarget:self action:@selector(calculateColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonProcess];
}

- (void)setConstraits {
    [self setConstraintsForTextField:self.textFieldRed topAnchor:self.viewResultColor.bottomAnchor];
    [self setConstraintsForTextField:self.textFieldGreen topAnchor:self.textFieldRed.bottomAnchor];
    [self setConstraintsForTextField:self.textFieldBlue topAnchor:self.textFieldGreen.bottomAnchor];
    
    self.viewResultColor.translatesAutoresizingMaskIntoConstraints = NO;
    self.buttonProcess.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.viewResultColor.heightAnchor constraintEqualToConstant:kHeight],
        [self.viewResultColor.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:kSpacing],
        [self.viewResultColor.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kLeadingViewResult],
        [self.viewResultColor.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:kTrailing],
    
        [self.buttonProcess.topAnchor constraintEqualToAnchor:self.labelBlue.bottomAnchor constant:kSpacing],
        [self.buttonProcess.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

- (void)setConstraintsForTextField:(UITextField *)textField topAnchor:(NSLayoutAnchor *)topAnchor {
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
           [textField.heightAnchor constraintEqualToConstant:kHeight],
           [textField.topAnchor constraintEqualToAnchor:topAnchor constant:kSpacing],
           [textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kLeadingTextFields],
           [textField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:kTrailing],
    ]];
}

- (void)setUpTextField:(UITextField *)textfield withIdentifier:(NSString *)identifier {
    textfield.accessibilityIdentifier = identifier;
    textfield.placeholder = @"0..255";
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.delegate = self;
    textfield.allowsEditingTextAttributes = true;
    [self.view addSubview:textfield];
}
    
- (void)setUpLabel:(UILabel *)label withIdentifier:(NSString *)identifier andText:(NSString *)text {
    label.accessibilityIdentifier = identifier;
    label.text = text;
    [self.view addSubview:label];
}

- (void)calculateColor {
    [self.view endEditing:YES];
    
    if ([self isValidColor]) {
        self.viewResultColor.backgroundColor = [UIColor colorWithRed:[self.textFieldRed.text floatValue]/255 green:[self.textFieldGreen.text floatValue]/255 blue:[self.textFieldBlue.text floatValue]/255 alpha:1];
        self.labelResultColor.text = [self hexColor:self.viewResultColor.backgroundColor];
    } else {
        self.labelResultColor.text = @"Error";
    }
    
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
}

- (NSString*)hexColor:(UIColor*)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"0x%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

- (BOOL)isValidColor {
    if ([self isInteger:self.textFieldRed.text] && [self isInteger:self.textFieldGreen.text] && [self isInteger:self.textFieldBlue.text]) {
        int r = [self.textFieldRed.text intValue];
        int g = [self.textFieldGreen.text intValue];
        int b = [self.textFieldBlue.text intValue];

        if (r >= 0 && r < 256 && g >= 0 && g < 256 && b >= 0 && b < 256) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isInteger:(NSString*)str {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [formatter numberFromString:str] == nil ? NO : YES;
}

@end
   
@implementation ViewController (TextFieldDelegate)

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.labelResultColor.text = @"Color";
    self.viewResultColor.backgroundColor = UIColor.clearColor;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end



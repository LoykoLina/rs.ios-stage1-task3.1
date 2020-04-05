#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIElements];
}

- (void)setUIElements {
    self.view.accessibilityIdentifier = @"mainView";
  
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 200.0, 270.0, 40.0)];
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldRed.placeholder = @"0..255";
    self.textFieldRed.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldRed.delegate = self;
    [self.view addSubview:self.textFieldRed];
    
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 280.0, 270.0, 40.0)];
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldGreen.placeholder = @"0..255";
    self.textFieldGreen.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldGreen.delegate = self;
    [self.view addSubview:self.textFieldGreen];
    
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 360.0, 270.0, 40.0)];
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.textFieldBlue.placeholder = @"0..255";
    self.textFieldBlue.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldBlue.delegate = self;
    [self.view addSubview:self.textFieldBlue];
    
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(25, 200, 60, 40)];
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelRed.text = @"RED";
    [self.view addSubview:self.labelRed];
    
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(25, 280, 60, 40)];
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelGreen.text = @"GREEN";
    [self.view addSubview:self.labelGreen];
    
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(25, 360, 60, 40)];
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelBlue.text = @"BLUE";
    [self.view addSubview:self.labelBlue];
    
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(25, 120, 90, 40)];
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.labelResultColor.text = @"Color";
    [self.view addSubview:self.labelResultColor];
    
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 250.0, 40.0)];
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    [self.view addSubview:self.viewResultColor];
    
    UIButton *buttonProcess = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonProcess.accessibilityIdentifier = @"buttonProcess";
    [buttonProcess setTitle:@"Process" forState: UIControlStateNormal];
    buttonProcess.frame = CGRectMake(177, 440, 60, 40);
    [buttonProcess addTarget:self action:@selector(calculateColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonProcess];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.labelResultColor.text = @"Color";
    self.viewResultColor.backgroundColor = UIColor.whiteColor;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
    



#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    if ([numbers count] == 0) {
        return nil;
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (NSInteger i = 0; i < [numbers count]; i++) {
        int number = [numbers[i] intValue];
        if (number != 0) {
            if (number < 0) {
                [result appendString:@" - "];
                number *= -1;
            } else if (i != 0) {
                [result appendString:@" + "];
            }
            
            if (i == [numbers count] - 1) {
                [result appendFormat:@"%d", number];
            } else if (i == [numbers count] - 2) {
                number == 1 ? [result appendString:@"x"] : [result appendFormat:@"%dx", number];
            } else {
                number == 1 ? [result appendFormat:@"x^%ld", [numbers count] - 1 - i] : [result appendFormat:@"%dx^%ld", number, [numbers count] - 1 - i];
            }
        }
    }
    
    return result;
}
@end

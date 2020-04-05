#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    NSInteger m = [array[0] integerValue];
    NSInteger n = [array[1] integerValue];
    NSInteger x = 0;
    
    if (m == n) {
        return @1;
    }
    
    while (x < n) {
        NSInteger comb = [self getCombinations:n k:x];
        if (comb == m) {
            return [NSNumber numberWithInteger:x];
        }
        x++;
    }
    
    return nil;
}

- (NSInteger)factorial:(NSInteger)n {
    if (n == 0) {
        return 1;
    } else {
        return n * [self factorial:n - 1];
    }
}

- (NSInteger)getCombinations:(NSInteger)n k:(NSInteger)k {
    return [self factorial:n] / ([self factorial:n - k] * [self factorial:k]);
}

@end

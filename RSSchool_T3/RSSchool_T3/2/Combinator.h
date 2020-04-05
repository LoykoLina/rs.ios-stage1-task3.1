#import <Foundation/Foundation.h>

@interface Combinator : NSObject
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array;
- (NSInteger)factorial:(NSInteger)n;
- (NSInteger)getCombinations:(NSInteger)n k:(NSInteger)k;
@end


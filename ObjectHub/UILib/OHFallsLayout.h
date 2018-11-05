#import <UIKit/UIKit.h>

@interface OHFallsLayout : UICollectionViewLayout

- (OHFallsLayout *)initWithItemsHeightBlock:(CGFloat (^)(NSIndexPath *))heightBlock;

@end

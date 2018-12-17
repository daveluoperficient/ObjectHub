#import <UIKit/UIKit.h>

@protocol OHTabBarDelegate <NSObject>

- (void)didSelectBarItem:(NSInteger )tag andToastMessage:(NSString *)message andDuration:(NSTimeInterval)duration;

@end

@interface OHTabBarViewController : UIViewController

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

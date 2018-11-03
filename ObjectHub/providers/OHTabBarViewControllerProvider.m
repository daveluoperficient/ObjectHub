#import "OHTabBarViewControllerProvider.h"
#import "OHTabBarViewController.h"
#import "Blindside.h"

@interface OHTabBarViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation OHTabBarViewControllerProvider

- (OHTabBarViewController *)provideController {
    return [self.injector getInstance:[OHTabBarViewController class]];
}

@end

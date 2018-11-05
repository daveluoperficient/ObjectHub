#import "HomePageViewControllerProvider.h"
#import "HomePageViewController.h"
#import "Blindside.h"

@interface HomePageViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation HomePageViewControllerProvider

- (HomePageViewController *)provideController {
    return [self.injector getInstance:[HomePageViewController class]];
}

@end

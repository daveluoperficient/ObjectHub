#import "GuideViewControllerProvider.h"
#import "GuideViewController.h"
#import "Blindside.h"

@interface GuideViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation GuideViewControllerProvider

- (GuideViewController *)provideController {
    return [self.injector getInstance:[GuideViewController class]];
}

@end

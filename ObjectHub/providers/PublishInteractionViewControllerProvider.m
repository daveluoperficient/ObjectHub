#import "PublishInteractionViewControllerProvider.h"
#import "PublishInteractionViewController.h"
#import "OHTabBarViewController.h"
#import "Blindside.h"

@interface PublishInteractionViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation PublishInteractionViewControllerProvider

- (PublishInteractionViewController *)provideControllerWithTabBarDelegate:(id<OHTabBarDelegate>) tabBarDelegate {
    return [self.injector getInstance:[PublishInteractionViewController class] withArgs:tabBarDelegate, nil];
}

@end

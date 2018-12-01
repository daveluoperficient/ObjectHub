#import "GuideViewControllerProvider.h"
#import "GuideViewController.h"
#import "LoginViewControllerProvider.h"
#import "Blindside.h"

@interface GuideViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation GuideViewControllerProvider


- (GuideViewController *)provideControllerWithLoginViewControllerProvider:(LoginViewControllerProvider *)loginViewControllerProvider {
    return [self.injector getInstance:[GuideViewController class] withArgs:loginViewControllerProvider, nil];
}

@end

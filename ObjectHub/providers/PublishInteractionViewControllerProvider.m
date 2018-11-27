#import "PublishInteractionViewControllerProvider.h"
#import "PublishInteractionViewController.h"
#import "Blindside.h"

@interface PublishInteractionViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation PublishInteractionViewControllerProvider

- (PublishInteractionViewController *)provideController {
    return [self.injector getInstance:[PublishInteractionViewController class]];
}

@end

#import <Foundation/Foundation.h>

@class PublishInteractionViewController;
@protocol OHTabBarDelegate;

@interface PublishInteractionViewControllerProvider : NSObject

- (PublishInteractionViewController *)provideControllerWithTabBarDelegate:(id<OHTabBarDelegate>) tabBarDelegate;

@end

#import <UIKit/UIKit.h>

@class GuideViewController;
@class LoginViewControllerProvider;

@interface GuideViewControllerProvider : NSObject

- (GuideViewController *)provideControllerWithLoginViewControllerProvider: (LoginViewControllerProvider *) loginViewControllerProvider;

@end

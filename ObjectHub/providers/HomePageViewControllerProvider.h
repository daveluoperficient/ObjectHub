#import <Foundation/Foundation.h>

@class HomePageViewController;

@interface HomePageViewControllerProvider : NSObject

- (HomePageViewController *)provideController;

@end

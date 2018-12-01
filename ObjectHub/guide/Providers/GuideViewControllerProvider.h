#import <Foundation/Foundation.h>

@class GuideViewController;

@interface GuideViewControllerProvider : NSObject

- (GuideViewController *)provideController;

@end

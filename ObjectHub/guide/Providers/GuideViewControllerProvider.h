//
//  GuideViewControllerProvider.h
//  ObjectHub
//
//  Created by lester.ji on 2018/11/1.
//  Copyright © 2018年 dave.luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GuideViewController;

@interface GuideViewControllerProvider : NSObject

- (GuideViewController *)provideController;

@end

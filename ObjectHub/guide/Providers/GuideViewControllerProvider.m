//
//  GuideViewControllerProvider.m
//  ObjectHub
//
//  Created by lester.ji on 2018/11/1.
//  Copyright © 2018年 dave.luo. All rights reserved.
//

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

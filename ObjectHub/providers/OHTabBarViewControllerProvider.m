//
//  OHTabBarControllerProvider.m
//  ObjectHub
//
//  Created by dave.luo on 11/1/18.
//  Copyright © 2018 dave.luo. All rights reserved.
//

#import "OHTabBarViewControllerProvider.h"
#import "OHTabBarViewController.h"
#import "Blindside.h"

@interface OHTabBarViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation OHTabBarViewControllerProvider

- (OHTabBarViewController *)provideController {
    return [self.injector getInstance:[OHTabBarViewController class]];
}

@end

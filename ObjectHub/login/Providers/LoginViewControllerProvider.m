//
//  LoginControllerProvider.m
//  ObjectHub
//
//  Created by dave.luo on 10/18/18.
//  Copyright © 2018 dave.luo. All rights reserved.
//
#import "LoginViewControllerProvider.h"
#import "LoginViewController.h"
#import "Blindside.h"

@interface LoginViewControllerProvider ()

@property (nonatomic, readonly) id<BSInjector> injector;

@end

@implementation LoginViewControllerProvider

- (LoginViewController *)provideControllerWithNavigationController:(UINavigationController *)navigationController {
    return [self.injector getInstance:[LoginViewController class] withArgs:navigationController, nil];
}

@end

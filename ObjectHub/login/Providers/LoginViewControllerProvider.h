//
//  LoginConrollerProvider.h
//  ObjectHub
//
//  Created by dave.luo on 10/18/18.
//  Copyright © 2018 dave.luo. All rights reserved.
//
#import <UIKit/UIKit.h>

@class LoginViewController;

@interface LoginViewControllerProvider : NSObject

- (LoginViewController *)provideControllerWithNavigationController:(UINavigationController *)navigationController;

@end


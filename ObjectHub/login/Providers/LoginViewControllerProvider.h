//
//  LoginConrollerProvider.h
//  ObjectHub
//
//  Created by dave.luo on 10/18/18.
//  Copyright © 2018 dave.luo. All rights reserved.
//
#import <Foundation/Foundation.h>

@class LoginViewController;

@interface LoginViewControllerProvider : NSObject

- (LoginViewController *)provideController;

@end

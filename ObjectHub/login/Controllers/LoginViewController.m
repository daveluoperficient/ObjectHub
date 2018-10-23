//
//  LoginController.m
//  ObjectHub
//
//  Created by dave.luo on 10/18/18.
//  Copyright © 2018 dave.luo. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUpLayout];
}

- (void)setUpLayout {
    _textFieldPhoneNumber.layer.cornerRadius = 20;
    _textFieldPhoneNumber.layer.masksToBounds = YES;
    _textFieldPhoneNumber.alpha = 0.8;
    [_textFieldPhoneNumber setKeyboardType:UIKeyboardTypeNumberPad];
    [_textFieldPhoneNumber setValue:[NSNumber numberWithInt:20] forKey:@"paddingLeft"];
    
    _textFieldPassword.layer.cornerRadius = 20;
    _textFieldPassword.layer.masksToBounds = YES;
    _textFieldPassword.alpha = 0.8;
    [_textFieldPassword setValue:[NSNumber numberWithInt:20] forKey:@"paddingLeft"];
    
    _loginButton.layer.cornerRadius = 25;
}

@end

//
//  LoginController.m
//  ObjectHub
//
//  Created by dave.luo on 10/18/18.
//  Copyright © 2018 dave.luo. All rights reserved.
//

#import "LoginViewController.h"
#import "OHTabBarViewControllerProvider.h"
#import "OHTabBarViewController.h"
#import "Blindside.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, readonly) OHTabBarViewControllerProvider *tabBarViewControllerProvider;
@property (nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation LoginViewController

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithNavigationController:andOHTabBarViewControllerProvider:)
                                  argumentKeys:BS_DYNAMIC,[OHTabBarViewControllerProvider class], nil];
}

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController andOHTabBarViewControllerProvider:(OHTabBarViewControllerProvider *)tabBarViewControllerProvider  {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
        _tabBarViewControllerProvider = tabBarViewControllerProvider;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpLayout];
}

- (void)setUpLayout {
    _textFieldPhoneNumber.layer.cornerRadius = 20;
    _textFieldPhoneNumber.layer.masksToBounds = YES;
    _textFieldPhoneNumber.alpha = 0.8;
    [_textFieldPhoneNumber setKeyboardType:UIKeyboardTypeNumberPad];
    [_textFieldPhoneNumber setValue:[NSNumber numberWithInt:20] forKey:@"paddingLeft"];
    
    _textFieldPhoneNumber.delegate = self;
    
    _textFieldPhoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textFieldPhoneNumber addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    _textFieldPassword.layer.cornerRadius = 20;
    _textFieldPassword.layer.masksToBounds = YES;
    _textFieldPassword.alpha = 0.8;
    [_textFieldPassword setValue:[NSNumber numberWithInt:20] forKey:@"paddingLeft"];
    
    _loginButton.layer.cornerRadius = 25;
}

#pragma delegate method

-(void)textFieldDidChange {
    NSDictionary *attrsDictionary =@{
                                     NSFontAttributeName: _textFieldPhoneNumber.font,
                                     NSKernAttributeName:[NSNumber numberWithFloat:2.0f]
                                     };
    _textFieldPhoneNumber.attributedText=[[NSAttributedString alloc] initWithString:_textFieldPhoneNumber.text attributes:attrsDictionary];
    
    if (_textFieldPhoneNumber.text.length > 11) {
        _textFieldPhoneNumber.text = [_textFieldPhoneNumber.text substringToIndex:11];
    }
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (IBAction)onLoginButtonTapped:(id)sender {
    OHTabBarViewController *tabBarController = [_tabBarViewControllerProvider provideController];
    self.view.window.rootViewController = tabBarController;
    //[self.navigationController pushViewController:tabBarController animated:YES];
}

@end

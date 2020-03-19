//
//  ViewController.m
//  single-view-demo
//
//  Created by muyun on 2020/3/17.
//  Copyright © 2020 muyun. All rights reserved.
//

#import "ViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterAccountViewController.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet UITextField *userName;
@property(weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender {
    NSLog(@"username is %@", [_userName text]);
    NSLog(@"password is %@", [_password text]);
}

- (IBAction)registerAccount:(id)sender {
//    使用showViewController跳转页面，目标页面需要在viewDidLoad中添加元素
//    RegisterAccountViewController *viewController = [[RegisterAccountViewController alloc] init];
//    viewController.noticeDetail = @"注册功能暂未开放！嘻嘻嘻嘻";
//    [self showViewController:viewController sender:self];
    [self performSegueWithIdentifier:@"forwardRegisterAccountView" sender:self];
}


//使用segue跳转页面并且传值
- (IBAction)forgetPassword:(id)sender {
    [self performSegueWithIdentifier:@"forwardForgetPasswordView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([segue.identifier isEqual:@"forwardRegisterAccountView"]) {
        RegisterAccountViewController *viewController = [segue destinationViewController];
        viewController.noticeDetail = @"注册功能暂未开放！嘻嘻嘻嘻";
    }

    if ([segue.identifier isEqual:@"forwardForgetPasswordView"]) {
        ForgetPasswordViewController *viewController = [segue destinationViewController];
        viewController.noticeDetail = @"忘了就忘了吧！嘻嘻嘻嘻";
    }
}

@end

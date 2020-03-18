//
//  ViewController.m
//  single-view-demo
//
//  Created by muyun on 2020/3/17.
//  Copyright © 2020 muyun. All rights reserved.
//

#import "ViewController.h"
#import "ForgetPasswordViewController.h"

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

//使用编码方式跳转页面
- (IBAction)forgetPassword:(id)sender {
    [self performSegueWithIdentifier:@"forwardForgetPasswordView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([segue.identifier isEqual:@"forwardForgetPasswordView"]) {
        ForgetPasswordViewController *viewController = [segue destinationViewController];
        viewController.noticeDetail = @"忘了就忘了吧!嘻嘻嘻嘻";
    }
}

@end

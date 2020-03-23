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
#import "MovieListViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"

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

    UIStoryboard *storyboard = self.storyboard;
    UITabBarController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
    //弹出页面
//    [self presentViewController:viewController animated:YES completion:nil];
    //跳转页面，并且将viewController设置为rootViewController TODO why?
    UIWindowScene *scene = [UIApplication sharedApplication].openSessions.allObjects.lastObject.scene;
    SceneDelegate *sceneDelegate = (SceneDelegate *) scene.delegate;
    sceneDelegate.window.rootViewController = viewController;
    [sceneDelegate.window makeKeyAndVisible];

}

- (IBAction)registerAccount:(id)sender {
//    [self performSegueWithIdentifier:@"forwardRegisterAccountView" sender:self];
    [self forwardResisterAccountViewByPresent];
//    [self forwardResisterAccountViewByShow];
}

//使用storyboard+ViewController's identifier获取ViewController，然后跳转页面
- (void)forwardResisterAccountViewByPresent {
    //使用name获取storyboard
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    UIStoryboard *storyboard = self.storyboard;
    RegisterAccountViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"registerAccountViewController"];
    viewController.noticeDetail = @"注册功能暂未开放！嘻嘻嘻嘻";

    [self presentViewController:viewController animated:YES completion:nil];
    //也可以使用show方法 TODO why？
    //    [self showViewController:viewController sender:self];
}

//使用alloc 和init获取ViewController，目标页面需要在viewDidLoad中添加元素，（必须调用show方法）TODO why？
- (void)forwardResisterAccountViewByShow {
    RegisterAccountViewController *viewController = [[RegisterAccountViewController alloc] init];
    viewController.noticeDetail = @"注册功能暂未开放！嘻嘻嘻嘻";
    [self showViewController:viewController sender:self];
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

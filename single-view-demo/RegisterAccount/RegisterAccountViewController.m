//
//  RegisterAccountViewController.m
//  single-view-demo
//
//  Created by muyun on 2020/3/19.
//  Copyright © 2020 muyun. All rights reserved.
//

#import "RegisterAccountViewController.h"

@interface RegisterAccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@end

@implementation RegisterAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _noticeLabel.text = _noticeDetail;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

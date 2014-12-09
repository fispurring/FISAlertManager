//
//  ViewController.m
//  FISAlertManager
//
//  Created by LiXinyu on 14/12/9.
//  Copyright (c) 2014年 LiXinyu. All rights reserved.
//

#import "ViewController.h"
#import "FISAlertManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [FISAlertManager sharedManager].viewController=self;
    
//    Set the OK and Cancel button title
//    [FISAlertManager sharedManager].titleOK=NSLocalizedString(@"YES", nil);
//    [FISAlertManager sharedManager].titleCancel=NSLocalizedString(@"NO", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showDialog:(id)sender {
    [[FISAlertManager sharedManager] showAlert:@"Dialog" message:@"This is a Dialog" handler:^(id alert){}];
}
- (IBAction)showConfirmDialog:(id)sender {
    [[FISAlertManager sharedManager] showConfirmDialog:@"ConfirmDialog" message:@"This is a Confirm Dialog" handler:^(id alert){}];
}
- (IBAction)showTextDialog:(id)sender {
    [[FISAlertManager sharedManager] showTextAlert:@"TextDialog" message:@"This is a Text Dialog" handler:^(id alert){}];
}
- (IBAction)showCustomDialog:(id)sender {
    NSMutableArray *items=[NSMutableArray array];
    [items addObject:[FISItem itemWithTitle:@"YES" handler:nil]];
    [items addObject:[FISItem itemWithTitle:@"NO" handler:nil]];
    [items addObject:[FISItem itemWithTitle:@"Detail" handler:nil]];
    [[FISAlertManager sharedManager] showAlert:@"CustomDialog" message:@"This is a Custom Dialog" items:items];
}

- (IBAction)showLoginDialog:(id)sender {
    NSMutableArray *items=[NSMutableArray array];
    [items addObject:[FISItem itemWithTitle:@"Cancel" handler:nil]];
    [items addObject:[FISItem itemWithTitle:@"Login" handler:nil]];
    [items addObject:[FISItem itemWithTitle:@"username" placeholder:@"username" security:NO]];
    [items addObject:[FISItem itemWithTitle:@"password" placeholder:@"password" security:YES]];
    [[FISAlertManager sharedManager] showAlert:@"LoginDialog" message:@"This is a Login Dialog" items:items];
}

@end

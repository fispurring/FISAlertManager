//
//  FISAlertManager.m
//  FISAlertManager
//
//  Created by LiXinyu on 14-11-7.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "FISAlertManager.h"

@implementation FISAlertManager

+(FISAlertManager *)sharedManager
{
    static FISAlertManager *s_singleton;
    if (!s_singleton) {
        s_singleton=[[FISAlertManager alloc] init];
    }
    return s_singleton;
}

-(id)init
{
    if (self=[super init]) {
        self.viewController=nil;
        self.titleOK=@"OK";
        self.titleCancel=@"Cancel";
    }
    return self;
}

-(id)showAlert:(NSString*)title message:(NSString*)message handler:(void (^)(id)) handler
{
    FISItem *item=[FISItem itemWithTitle:self.titleOK handler:handler];
    return [self showAlert:title message:message items:[NSArray arrayWithObject:item]];
}

-(id)showConfirmDialog:(NSString*)title message:(NSString*)message handler:(void (^)(id))handler {
    NSMutableArray *items=[NSMutableArray array];
    [items addObject:[FISItem itemWithTitle:self.titleCancel handler:nil]];
    [items addObject:[FISItem itemWithTitle:self.titleOK handler:handler]];
    return [self showAlert:title message:message items:items];
}

-(id)showTextAlert:(NSString*)title message:(NSString*)message handler:(void (^)(id))handler
{
    return [self showTextAlert:title message:message text:@"" placeholder:@"" handler:handler];
}

-(id)showTextAlert:(NSString *)title message:(NSString *)message text:(NSString*)text placeholder:(NSString*)placeholder handler:(void (^)(id))handler
{
    NSMutableArray *items=[NSMutableArray array];
    [items addObject:[FISItem itemWithTitle:self.titleCancel handler:nil]];
    [items addObject:[FISItem itemWithTitle:self.titleOK handler:handler]];
    [items addObject:[FISItem itemWithTitle:text placeholder:placeholder security:NO]];
    return [self showAlert:title message:message items:items];
}

-(id)showAlert:(NSString*)title message:(NSString *)message items:(NSMutableArray *)items
{
    if (!self.viewController) {
        return nil;
    }

    float version=[[UIDevice currentDevice].systemName floatValue];
    if (version>=8.0) {
        UIAlertController* alertContrller = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        for (FISItem *item in items) {
            switch (item.type) {
                case FIS_TYPE_ACTION:
                {
                    [alertContrller addAction:[UIAlertAction actionWithTitle:item.title
                                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                                           item.handler(alertContrller);
                                                                       }]];
                }
                    break;
                case FIS_TYPE_TEXT:
                {
                    [alertContrller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                        textField.placeholder=item.placeholder;
                        textField.text=item.title;
                    }];
                }
                    break;
                case FIS_TYPE_PASSWORD:
                {
                    [alertContrller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                        textField.placeholder=item.placeholder;
                        textField.secureTextEntry=YES;
                        textField.text=item.title;
                    }];
                    break;
                }
                default:
                    break;
            }
        }
        [self.viewController presentViewController:alertContrller animated:YES completion:nil];
        return alertContrller;
    }
    else {
        self.items=[NSMutableArray array];
        for (FISItem *item in items) {
            if (item.type==FIS_TYPE_ACTION) {
                [self.items addObject:item];
            }
        }
        for (FISItem *item in items) {
            if (item.type!=FIS_TYPE_ACTION) {
                [self.items addObject:item];
            }
        }
        
        BOOL hasText=NO;
        BOOL hasPassword=NO;
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        for (FISItem *item in self.items) {
            switch (item.type) {
                case FIS_TYPE_ACTION:
                    [alertView addButtonWithTitle:item.title];
                    break;
                case FIS_TYPE_TEXT:
                    hasText=YES;
                    break;
                case FIS_TYPE_PASSWORD:
                    hasPassword=YES;
                    break;
                default:
                    break;
            };
        }
        if (hasText&&!hasPassword) {
            alertView.alertViewStyle=UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].text=[[self.items lastObject] title];
            [alertView textFieldAtIndex:0].placeholder=[[self.items lastObject] placeholder];
        }
        else if(!hasText&&hasPassword) {
            alertView.alertViewStyle=UIAlertViewStyleSecureTextInput;
            [alertView textFieldAtIndex:0].text=[[self.items lastObject] title];
            [alertView textFieldAtIndex:0].placeholder=[[self.items lastObject] placeholder];
        }
        else if (hasText&&hasPassword) {
            alertView.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
            for (int i=self.items.count-2; i<self.items.count; ++i) {
                FISItem *item=self.items[i];
                if (item.type==FIS_TYPE_TEXT) {
                    [alertView textFieldAtIndex:0].text=[item title];
                    [alertView textFieldAtIndex:0].placeholder=[item placeholder];
                }
                else {
                    [alertView textFieldAtIndex:1].text=[item title];
                    [alertView textFieldAtIndex:1].placeholder=[item placeholder];

                }
            }
        }
        [alertView show];
        return alertView;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    FISItem *item=self.items[buttonIndex];
    if(item.handler) {
        item.handler(alertView);
    }
}

@end

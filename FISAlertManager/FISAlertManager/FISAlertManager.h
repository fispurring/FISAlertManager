//
//  FISAlertManager.h
//  FISAlertManager
//
//  Created by LiXinyu on 14-11-7.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FISItem.h"

@interface FISAlertManager : NSObject<UIAlertViewDelegate>

@property(nonatomic,weak)UIViewController *viewController;
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,strong)NSString *titleOK;
@property(nonatomic,strong)NSString *titleCancel;

+(FISAlertManager *)sharedManager;

-(id)showAlert:(NSString*)title message:(NSString*)message handler:(void (^)(id)) handler;
-(id)showConfirmDialog:(NSString*)title message:(NSString*)message handler:(void (^)(id)) handler;
-(id)showTextAlert:(NSString*)title message:(NSString*)message handler:(void (^)(id))handler;
-(id)showTextAlert:(NSString *)title message:(NSString *)message text:(NSString*)text placeholder:(NSString*)placeholder handler:(void (^)(id))handler;
-(id)showAlert:(NSString*)title message:(NSString *)message items:(NSArray *)items;

@end

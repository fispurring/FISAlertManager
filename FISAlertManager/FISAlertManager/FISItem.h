//
//  FISItem.h
//  FISAlertManager
//
//  Created by LiXinyu on 14-11-28.
//  Copyright (c) 2014年 LiXinyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FIS_TYPE_ACTION,
    FIS_TYPE_TEXT,
    FIS_TYPE_PASSWORD
}FISItemType;

@interface FISItem : NSObject

@property(nonatomic)FISItemType type;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)void (^handler)(id);
@property(nonatomic,strong)NSString *placeholder;

//return button item
+(FISItem*)itemWithTitle:(NSString*)title handler:(void (^)(id))handler;
//return textfield item
+(FISItem*)itemWithTitle:(NSString*)title placeholder:(NSString*)placeholder security:(BOOL)security;

@end

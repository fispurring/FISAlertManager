//
//  FISItem.m
//  FISAlertManager
//
//  Created by LiXinyu on 14-11-28.
//  Copyright (c) 2014年 LiXinyu. All rights reserved.
//

#import "FISItem.h"

@implementation FISItem

-(id)init
{
    if (self=[super init]) {
        self.title=@"";
        self.handler=nil;
        self.placeholder=@"";
    }
    return self;
}

+(FISItem*)itemWithTitle:(NSString*)title handler:(void (^)(id))handler
{
    FISItem *item=[[FISItem alloc]init];
    item.title=title;
    item.handler=handler;
    item.type=FIS_TYPE_ACTION;
    return item;
}

+(FISItem*)itemWithTitle:(NSString*)title placeholder:(NSString*)placeholder security:(BOOL)security;
{
    FISItem *item=[[FISItem alloc]init];
    item.title=title;
    item.type=security?FIS_TYPE_PASSWORD:FIS_TYPE_TEXT;
    item.placeholder=placeholder;
    return item;
}

@end

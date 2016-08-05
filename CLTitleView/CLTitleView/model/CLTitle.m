//
//  CLTitle.m
//  CLTitleView
//
//  Created by WuChunlong on 16/8/5.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "CLTitle.h"

@implementation CLTitle

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _name = [dict objectForKey:@"name"];
    }
    
    return self;
}

+ (instancetype)titleWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}





@end

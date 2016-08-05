//
//  CLTitle.h
//  CLTitleView
//
//  Created by WuChunlong on 16/8/5.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLTitle : NSObject

/** name */
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)titleWithDict:(NSDictionary *)dict;

@end

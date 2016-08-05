
//
//  Created on 16/6/8.
//  Copyright © 2016年 WFP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLTitleView;
@protocol CLTitleViewDelegate <NSObject>
@required
- (void)titleView:(CLTitleView *)titleView didSelectTitleItemFromIndex:(NSInteger)from toIndex:(NSInteger)to;
@end

@interface CLTitleView : UIView
{
    NSInteger _selectedIndex;
}

/** 标题 */
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) id <CLTitleViewDelegate> delegate;

@property (nonatomic, assign)NSInteger selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
+ (instancetype)titleViewWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end

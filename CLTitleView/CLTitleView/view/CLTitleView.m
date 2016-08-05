//
//  Created on 16/6/8.
//  Copyright © 2016年 WFP. All rights reserved.
//

#import "CLTitleView.h"

#define SELF_WIDTH self.bounds.size.width

#define kBtn_Num 6  // 一页显示的button数
#define kBtn_Margin 20  // button 的间距
#define kBtn_Width ((SELF_WIDTH - 20 - kBtn_Margin * (kBtn_Num - 1)) / kBtn_Num)



@interface CLTitleView ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIButton *selectedItem;
@property (nonatomic, strong) UIScrollView *titleScrollView;

@end


@implementation CLTitleView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SELF_WIDTH, 44)];
        titleScrollView.delegate = self;
        titleScrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:titleScrollView];
        self.titleScrollView = titleScrollView;
        
        _selectedIndex = 0;

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    CLTitleView *tv = [self initWithFrame:frame];
    tv.titles = titles;
    return tv;
}

+ (instancetype)titleViewWithFrame:(CGRect)frame titles:(NSArray *)titles {
    return [[self alloc] initWithFrame:frame titles:titles];
}

#pragma mark - buttonSelect
- (void)buttonSelect:(UIButton *)button {
    
    [self.delegate titleView:self didSelectTitleItemFromIndex:self.selectedItem.tag - 100 toIndex:button.tag - 100];
    
    button.selected = !button.selected;
    if (button.selected) {
        [UIView animateWithDuration:0.25 animations:^{
            [button.titleLabel setFont:[UIFont systemFontOfSize:21]];
            [button.titleLabel sizeToFit];
            [self.selectedItem.titleLabel setFont:[UIFont systemFontOfSize:16]];
        }];
        
    }
    
    self.selectedItem.selected = NO;
    button.selected = YES;
    self.selectedItem = button;
    
    CGPoint offset = self.titleScrollView.contentOffset;
    
    if (self.selectedIndex >= 2 && self.selectedIndex <= self.titles.count - 4) {
        offset.x = self.selectedItem.frame.origin.x - 2 * (kBtn_Width + kBtn_Margin);
                                                           
    } else if (self.selectedIndex == 1) {
        offset.x = self.selectedItem.frame.origin.x - 1 * (kBtn_Width + kBtn_Margin);
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        self.titleScrollView.contentOffset = offset;
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - override setter
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    CGFloat titleScrollContentW = 10 + kBtn_Width * titles.count + kBtn_Margin * (titles.count - 1) + 10;
    self.titleScrollView.contentSize = CGSizeMake(titleScrollContentW, 44);
    
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        button.frame = CGRectMake(10 + (kBtn_Width + kBtn_Margin) * i, 5, kBtn_Width, 34);
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.selectedItem = button;
            [button.titleLabel setFont:[UIFont systemFontOfSize:21]];
        }
        [button.titleLabel sizeToFit];
        [self.titleScrollView addSubview:button];
        
    }
}


- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.selectedItem = (UIButton *)[self.titleScrollView viewWithTag:100 + self.selectedIndex];
    [self buttonSelect:self.selectedItem];
                       
}



#pragma mark - override getter
- (NSInteger)selectedIndex {
    return self.selectedItem.tag - 100;

}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

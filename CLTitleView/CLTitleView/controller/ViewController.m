//
//  ViewController.m
//  CLTitleView
//
//  Created by WuChunlong on 16/8/5.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "ViewController.h"
#import "CLTitle.h"
#import "CLTitleView.h"

@interface ViewController () <CLTitleViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, strong)NSArray *titles;

/** titleView */
@property (nonatomic, weak) CLTitleView *titleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.view.backgroundColor = [self randomColor];
    self.label.text = self.titles[0];
    self.label.textAlignment = NSTextAlignmentCenter;
 
    // Do any additional setup after loading the view, typically from a nib.
    
    CLTitleView *titleView = [CLTitleView titleViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44) titles:self.titles];
    titleView.delegate = self;
    [self.navigationController.navigationBar addSubview:titleView];
    self.titleView = titleView;
    
    
    
    
    
}

#pragma mark - CLTitleViewDelegate 
- (void)titleView:(CLTitleView *)titleView didSelectTitleItemFromIndex:(NSInteger)from toIndex:(NSInteger)to {
    
    CATransition *transion = [[CATransition alloc] init];
    transion.type = @"push";
    transion.subtype = (from < to) ? kCATransitionFromRight : kCATransitionFromLeft;
    transion.duration = 0.25f;
    
    self.view.backgroundColor = [self randomColor];
    self.label.text = self.titles[to];
    
    [self.view.layer addAnimation:transion forKey:nil];
    
    
}

#pragma mark - 懒加载
- (NSArray *)titles {
    if (_titles == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Default_channel.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            CLTitle *title = [CLTitle titleWithDict:dict];
            [mArr addObject:title.name];
        }
        
        _titles = mArr;
    }
    
    return _titles;
}




- (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    UIColor *color = [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.0];
    return color;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

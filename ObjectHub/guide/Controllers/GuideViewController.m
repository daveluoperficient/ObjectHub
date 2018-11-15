//
//  GuideViewController.m
//  ObjectHub
//
//  Created by lester.ji on 2018/11/1.
//  Copyright © 2018年 dave.luo. All rights reserved.
//

#import "GuideViewController.h"

#define kImageCount 3
#define kScrollViewSize (_guideScrollView.frame.size)
#define kAfterDelayTime 0.3 //最后按钮显示的延迟时间


@interface GuideViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *guideScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *guidePageControll;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

#pragma mark -
#pragma mark - 设置UI界面
- (void)setUpUI {
    //设置控制器成为scrollView代理
    _guideScrollView.delegate = self;
    [self setupScrollView];
    [self setupPageController];
}

#pragma mark -
#pragma mark - scrollView设置
- (void)setupScrollView {
//    CGSize scrollViewSize = _guideScrollView.frame.size;
    for (int i = 0; i < kImageCount; i++) {
        CGFloat imageViewX = i * kScrollViewSize.width;
        UIImageView *guideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 0, kScrollViewSize.width , kScrollViewSize.height)];
        //拼接图片名称
        NSString *imageName = [NSString stringWithFormat:@"guide_%02d",i +1];
        guideImageView.image = [UIImage imageNamed:imageName];
        [_guideScrollView addSubview:guideImageView];
//        if (i == 2) {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            button.frame = CGRectMake(0, 0, kScrollViewSize.width * 0.5, kScrollViewSize.height * 0.05);
//            button.center = CGPointMake(kScrollViewSize.width / 2, self.guidePageControll.frame.origin.y - button.frame.size.height / 2);
//            [button setTitle:@"进入应用" forState:UIControlStateNormal];
//            button.titleLabel.font = [UIFont systemFontOfSize:16];
//            button.titleLabel.textAlignment = NSTextAlignmentCenter;
//            [button sizeToFit];
//            [_guideScrollView addSubview:button];
//        }
    }
    _guideScrollView.contentSize = CGSizeMake(kImageCount * kScrollViewSize.width, 0);
    _guideScrollView.showsHorizontalScrollIndicator = NO;
    //scrollView 分页效果
    _guideScrollView.pagingEnabled = YES;
}

#pragma mark -
#pragma mark - 设置pageController
- (void)setupPageController {
    //设置几个点
    _guidePageControll.numberOfPages = kImageCount;
    //设置非当前指示器颜色
    _guidePageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    //设置当前指示器颜色
    _guidePageControll.currentPageIndicatorTintColor = [UIColor redColor];
    //设置当前在第几个点
    _guidePageControll.currentPage = 0;
}

#pragma mark -
#pragma mark - 当scrollView停止减速时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _guidePageControll.currentPage = scrollView.contentOffset.x / kScrollViewSize.width;
}

@end

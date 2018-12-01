#import "GuideViewController.h"
#import "LoginViewControllerProvider.h"
#import "LoginViewController.h"
#import "Blindside.h"

#define kImageCount 4
#define kAfterDelayTime 0.3 //最后按钮显示的延迟时间


@interface GuideViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *guideScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *guidePageControll;
@property (weak, nonatomic) IBOutlet UIButton *toLoginPageButton;

@property (weak, nonatomic) LoginViewControllerProvider *loginViewControllerProvider;
@property (nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation GuideViewController

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithLoginViewControllerProvider:)
                                  argumentKeys:BS_DYNAMIC, nil];
}

- (instancetype)initWithLoginViewControllerProvider:(LoginViewControllerProvider *)loginViewControllerProvider  {
    self = [super init];
    if (self) {
        _navigationController = [[UINavigationController alloc] init];
        _loginViewControllerProvider = loginViewControllerProvider;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self.toLoginPageButton setHidden:YES];
}

#pragma mark -
#pragma mark - 设置UI界面
- (void)setUpUI {
    //设置控制器成为scrollView代理
    _guideScrollView.delegate = self;
    [self setupPageController];
}

- (void)viewDidAppear:(BOOL)animated {
    CGSize kScrollViewSize = _guideScrollView.frame.size;
    _guideScrollView.contentSize = CGSizeMake(kImageCount * kScrollViewSize.width, 0);
    _guideScrollView.showsHorizontalScrollIndicator = NO;
    _guideScrollView.pagingEnabled = YES;
}

-  (BOOL)prefersStatusBarHidden {
    return YES;
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
    _guidePageControll.currentPage = scrollView.contentOffset.x / self.view.bounds.size.width;
    [self.toLoginPageButton setHidden:_guidePageControll.currentPage == 3 ? NO : YES];
}

- (IBAction)onLoginPageButtonTapped:(id)sender {
    LoginViewController *loginViewController = [_loginViewControllerProvider provideControllerWithNavigationController:self.navigationController];
    [self presentViewController:loginViewController animated:YES completion:nil];
}


@end

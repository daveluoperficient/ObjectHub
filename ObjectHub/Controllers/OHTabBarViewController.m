#import "OHTabBarViewController.h"
#import "Blindside.h"

@interface OHTabBarViewController () <UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabHome;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabCollect;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabPublish;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabNews;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabMime;


@end

@implementation OHTabBarViewController



+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initViewController)
                                  argumentKeys:nil
                                  ];
}

- (instancetype)initViewController  {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpLayoutConstraints];
    
    [_tabBar setSelectedItem:_tabHome];
    _tabBar.tintColor = [UIColor colorWithRed:249.0/255.0 green:94.0/255 blue:93.0/255 alpha:1];
    _tabBar.delegate = self;
}

- (void)setUpLayoutConstraints {
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.width) {
            case 640:
                [self setBarItemOffsets:0 andImageOffset:-5];
                break;
            case 750:
                [self setBarItemOffsets:0 andImageOffset:-10];
                break;
            case 828:
            case 1242:
                [self setBarItemOffsets:-5 andImageOffset:-5];
                break;
            case 1080:
                [self setBarItemOffsets:30 andImageOffset:-20];
                break;
            case 1125:
                [self setBarItemOffsets:30 andImageOffset:-20];
                break;
            default:
                break;
        }
    }
}

- (void)setBarItemOffsets:(NSInteger)offsetTitle andImageOffset:(NSInteger)offsetImage {
    [_tabHome setTitlePositionAdjustment:UIOffsetMake(0, offsetTitle)];
    [_tabHome setImageInsets:UIEdgeInsetsMake(0, 0, offsetImage, 0)];
    [_tabCollect setTitlePositionAdjustment:UIOffsetMake(0, offsetTitle)];
    [_tabCollect setImageInsets:UIEdgeInsetsMake(0, 0, offsetImage, 0)];
    [_tabNews setTitlePositionAdjustment:UIOffsetMake(0, offsetTitle)];
    [_tabNews setImageInsets:UIEdgeInsetsMake(0, 0, offsetImage, 0)];
    [_tabMime setTitlePositionAdjustment:UIOffsetMake(0, offsetTitle)];
    [_tabMime setImageInsets:UIEdgeInsetsMake(0, 0, offsetImage, 0)];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

@end

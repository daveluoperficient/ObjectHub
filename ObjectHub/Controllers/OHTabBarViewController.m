#import "OHTabBarViewController.h"
#import "Blindside.h"

@interface OHTabBarViewController ()

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
}

@end

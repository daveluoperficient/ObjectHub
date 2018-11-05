#import "HomePageViewController.h"
#import "Blindside.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initViewController)
                                  argumentKeys:nil
            ];
}

- (instancetype)initViewController {
    self = [super init];
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
}

@end

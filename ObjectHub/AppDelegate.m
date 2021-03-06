#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LoginViewControllerProvider.h"
#import "GuideViewController.h"
#import "GuideViewControllerProvider.h"
#import "Blindside.h"
#import "InjectorProvider.h"
#import "ApplicationSetting.h"

@interface AppDelegate ()

@property (nonatomic) id<BSBinder, BSInjector> injector;
@property (nonatomic) LoginViewControllerProvider *loginViewControllerProvider;
@property (nonatomic) GuideViewControllerProvider *guideViewControllerProvider;
@property (nonatomic) ApplicationSetting *applicationSetting;
@property (nonatomic) FeatureSet *featureSet;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupDependencies];
    UINavigationController *navigationController = [[UINavigationController alloc]init];
    if (self.featureSet.isFirstRunApplicationFlag) {
        navigationController.navigationBarHidden = YES;
        //LoginViewController *loginViewController = [self.loginViewControllerProvider provideControllerWithNavigationController:navigationController];
    
        GuideViewController *guideViewController = [self.guideViewControllerProvider provideControllerWithLoginViewControllerProvider:self.loginViewControllerProvider];
    
        [navigationController addChildViewController:guideViewController];
    } else {
        LoginViewController *loginViewController = [self.loginViewControllerProvider provideControllerWithNavigationController:navigationController];
        [navigationController setNavigationBarHidden:YES];
        [navigationController addChildViewController:loginViewController];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    
    self.applicationSetting.featureSet.isFirstRunApplicationFlag = NO;
    [self.applicationSetting archive];
    return YES;
}

- (void)setupDependencies {
    self.injector = (id)[InjectorProvider injector];
    self.loginViewControllerProvider = [self.injector getInstance:[LoginViewControllerProvider class]];
    self.guideViewControllerProvider = [self.injector getInstance:[GuideViewControllerProvider class]];
    self.applicationSetting = [self.injector getInstance:[ApplicationSetting class]];
    [self.applicationSetting unarchive];
    if (self.applicationSetting.featureSet == nil) {
        FeatureSet *featureSet = [[FeatureSet alloc] init];
        featureSet.isFirstRunApplicationFlag = YES;
        self.featureSet = featureSet;
        [self.applicationSetting setFeatureSet:featureSet];
    } else {
        self.featureSet = self.applicationSetting.featureSet;
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

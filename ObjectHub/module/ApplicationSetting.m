#import "ApplicationSetting.h"

@implementation ApplicationSetting

- (instancetype) initWithFeatureSet:(FeatureSet *)featureSet {
    self = [super init];
    if (self) {
        self.featureSet = featureSet;
    }
    return self;
}

- (void) archive {
    NSData *featureData = [NSKeyedArchiver archivedDataWithRootObject:self.featureSet requiringSecureCoding:YES error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:featureData forKey:@"profileData"];
}

- (void) unarchive {
    NSData *featureData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileData"];
    NSError *error;
    if (featureData != nil) {
        self.featureSet = [NSKeyedUnarchiver unarchivedObjectOfClass:[FeatureSet class] fromData:featureData error:&error];
    }
}

@end

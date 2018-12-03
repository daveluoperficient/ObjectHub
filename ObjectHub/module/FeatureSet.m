#import "FeatureSet.h"

@implementation FeatureSet

- (instancetype) initWithIsFirstRunApplicationFlag:(BOOL)isFirstRunApplicationFlag {
    self = [super init];
    if (self) {
        self.isFirstRunApplicationFlag = isFirstRunApplicationFlag;
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.isFirstRunApplicationFlag = [aDecoder decodeBoolForKey:@"isFirstRunApplicationFlag"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:self.isFirstRunApplicationFlag forKey:@"isFirstRunApplicationFlag"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

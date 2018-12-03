#import <Foundation/Foundation.h>
#import "FeatureSet.h"

@interface ApplicationSetting : NSObject

@property (nonatomic) FeatureSet *featureSet;
@property (nonatomic) NSData *profileData;

-(instancetype)initWithFeatureSet:(FeatureSet *) featureSet;

- (void) archive;
- (void) unarchive;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end


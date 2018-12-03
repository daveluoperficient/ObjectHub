#import <Foundation/Foundation.h>

@interface FeatureSet : NSObject <NSSecureCoding>

@property (nonatomic) BOOL isFirstRunApplicationFlag;

-(instancetype)initWithIsFirstRunApplicationFlag:(BOOL) isFirstRunApplicationFlag;

@end


#import "BlindsideModule.h"
#import "InjectorProvider.h"
#import "Blindside.h"

@implementation BlindsideModule

- (void)configure:(id<BSBinder>)binder {
    [binder bind:@protocol(BSInjector) toBlock:^id(NSArray *args, id<BSInjector> injector){
        return [InjectorProvider injector];
    }];
}

@end

#import "InjectorProvider.h"
#import "BSInjector.h"
#import "BlindsideModule.h"
#import "Blindside.h"

@implementation InjectorProvider

+ (id <BSInjector>)injector {
    NSArray *modules = @[
                         [BlindsideModule new]
                         ];
    return [Blindside injectorWithModules:modules];
}

@end


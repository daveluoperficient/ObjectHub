#import <UIKit/UIKit.h>

@protocol PublishInteractionDelegate <NSObject>

@optional
- (void)didFinishSelectImage:(NSArray *) arrImages andAssets:(NSArray *)assets;

@end

@interface PublishInteractionViewController : UIViewController;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@property(nonatomic,strong) NSMutableArray *arrSelected;
@property(nonatomic,strong) UIViewController *showActionSheetViewController;
@property(nonatomic,strong) NSMutableArray * bigImageArray;
@property(nonatomic,strong) NSMutableArray * bigImgDataArray;
@property (nonatomic, assign) CGFloat collectionFrameY;

@end

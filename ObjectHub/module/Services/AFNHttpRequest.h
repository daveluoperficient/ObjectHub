#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RequestDelegate <NSObject>

@required
- (void)requestFinishedSuccessed:(NSDictionary *)dictionary;
- (void)requestFinishedFailed:(NSDictionary *)dictionary;
@optional
- (void)requestFailed:(NSError *)error;

@end

@interface AFNHttpRequest : NSObject

@property (nonatomic,copy) NSString *requestUrl;
@property (strong,nonatomic) NSMutableDictionary *requestParams;
@property (nonatomic, weak) id<RequestDelegate> delegate;

- (id)initWithDelegate:(id<RequestDelegate>)delegate;

- (void)request;
- (void)requestMultipartMediaFormData:(NSMutableArray<UIImage *> *)images;

@end

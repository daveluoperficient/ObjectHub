#import "AFNHttpRequest.h"
#import "AFNetworking.h"

@implementation AFNHttpRequest

- (id)initWithDelegate:(id<RequestDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.requestParams = [[NSMutableDictionary alloc]init];
        self.requestUrl = [[NSString alloc]init];
    }
    return self;
}

- (void)request {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:self.requestUrl parameters:self.requestParams progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self callBackFinishedWithDictionary:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self callBackFaild:error];
    }];
}

- (void)requestMultipartMediaFormData:(NSMutableArray<UIImage *> *)images {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:self.requestUrl parameters:self.requestParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < images.count ; i++) {
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self callBackFinishedWithDictionary:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self callBackFaild:error];
    }];
}

-(void) callBackFinishedWithDictionary:(NSDictionary *)dictionary{
    
    if (dictionary) {
        dictionary = [[self deleteAllNullValueInDictionary:dictionary] copy];
        NSString *string = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"code"]];
        if([string isEqualToString:@"200"]){
            if(_delegate && [_delegate respondsToSelector:@selector(requestFinishedSuccessed:)]){
                [_delegate requestFinishedSuccessed:dictionary];
            }
        }else{
            if (_delegate && [_delegate respondsToSelector:@selector(requestFinishedFailed:)]) {
                [_delegate requestFinishedFailed:dictionary];
            }
        }
    }
}

-(void) callBackFaild:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFailed:)]) {
        [_delegate requestFailed:error];
    }
}

-(NSMutableDictionary*)deleteAllNullValueInDictionary:(NSDictionary*)dictionary {
    NSMutableDictionary *result = [dictionary copy];
    NSEnumerator *enumerator = [result keyEnumerator];
    id key = [enumerator nextObject];
    while(key) {
        id value = [dictionary objectForKey:key];
        if (value == nil) {
            [result removeObjectForKey:key];
        }
        key = [enumerator nextObject];
    }
    return [dictionary copy];
}

@end

//
//  HWImagePickerSheet.m
//  PhotoSelector
//
//  Created by 洪雯 on 2017/1/12.
//  Copyright © 2017年 洪雯. All rights reserved.
//

#import "HWImagePickerSheet.h"
#import "TZImagePickerController.h"

@interface HWImagePickerSheet ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, TZImagePickerControllerDelegate>

@end

@implementation HWImagePickerSheet
-(instancetype)init{
    self = [super init];
    if (self) {
        if (!_arrSelected) {
            self.arrSelected = [NSMutableArray array];
        }
    }
    return self;
}

//显示选择照片提示Sheet
-(void)showImgPickerActionSheetInView:(UIViewController *)controller selectedAssets:(NSMutableArray *)selectedAssetes {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"拍照"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!self->imaPic) {
            self->imaPic = [[UIImagePickerController alloc] init];
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self->imaPic.sourceType = UIImagePickerControllerSourceTypeCamera;
            self->imaPic.delegate = self;
            [self->viewController presentViewController:self->imaPic animated:NO completion:nil];
        }
        
    }];
    
    UIAlertAction *actionAlbum = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"相册"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        imagePickerVc.selectedAssets = selectedAssetes;
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [self.delegate didFinishSelectImage:photos andAssets:assets];
        }];
        
        [imagePickerVc setDoneBtnTitleStr:@"完成"];
        [imagePickerVc setCancelBtnTitleStr:@"取消"];
        [imagePickerVc setPreviewBtnTitleStr:@"预览"];
        [imagePickerVc setFullImageBtnTitleStr:@"原图"];
        
        [controller presentViewController:imagePickerVc animated:YES completion:nil];
    }];
    [alertController addAction:actionCancel];
    [alertController addAction:actionCamera];
    [alertController addAction:actionAlbum];
    viewController = controller;
    [viewController presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - 拍照获得数据
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *theImage = nil;
    // 判断，图片是否允许修改
    if ([picker allowsEditing]){
        //获取用户编辑之后的图像
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        // 照片的元数据参数
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (theImage) {
        //保存图片到相册中
        MImaLibTool *imgLibTool = [MImaLibTool shareMImaLibTool];
        [imgLibTool.lib writeImageToSavedPhotosAlbum:[theImage CGImage] orientation:(ALAssetOrientation)[theImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
            if (error) {
            } else {
                
                //获取图片路径
                [imgLibTool.lib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    if (asset) {
                        
                        [_arrSelected addObject:asset];
                        [picker dismissViewControllerAnimated:NO completion:nil];
                    }
                } failureBlock:^(NSError *error) {
                    
                }];
            }
        }];
    }
    
}

@end

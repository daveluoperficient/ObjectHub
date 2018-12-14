#import "PublishInteractionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HWCollectionViewCell.h"
#import "JJPhotoManeger.h"
#import "HWImagePickerSheet.h"
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import "AFNHttpRequest.h"
#import "UIView+Toast.h"


@interface PublishInteractionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,PublishInteractionDelegate,TZImagePickerControllerDelegate,JJPhotoDelegate,UITextViewDelegate,RequestDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *interactionTextView;
@property (weak, nonatomic) UIViewController *viewController;

@property (nonatomic) NSMutableArray *imageArray;

@property (nonatomic) NSString *pushImageName;
//添加图片提示
@property (nonatomic) UILabel *addImageStrLabel;
@property (nonatomic, strong) HWImagePickerSheet *imgPickerActionSheet;
@property (nonatomic, strong) NSString *inputHint;

@property (nonatomic) UIImagePickerController *imaPic;

@end

@implementation PublishInteractionViewController

#define MAX_PICK_NUM 9
#define CELL_INDENTIFIER "MyCollectionViewCell"

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickerView];
    
    _inputHint = @"这一刻的想法...";
    _interactionTextView.text = _inputHint;
    _interactionTextView.textColor = [UIColor lightGrayColor];
    _interactionTextView.delegate = self;
}

-(void)initPickerView{
    _showActionSheetViewController = self;
    
    self.contentView.delegate=self;
    self.contentView.dataSource=self;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.arrSelected = [[NSMutableArray alloc]init];
    
    if(_imageArray.count == 0)
    {
        _imageArray = [NSMutableArray array];
    }
    if(_bigImageArray.count == 0)
    {
        _bigImageArray = [NSMutableArray array];
    }
    _pushImageName = @"plus.png";
    
    //_pickerCollectionView.scrollEnabled = YES;
    
}
#pragma argumentsUICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"HWCollectionViewCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"HWCollectionViewCell"];
    // Set up the reuse identifier
    HWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"HWCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == _imageArray.count) {
        [cell.profilePhoto setImage:[UIImage imageNamed:_pushImageName]];
        cell.closeButton.hidden = YES;
        
        //没有任何图片
        if (_imageArray.count == 0) {
            _addImageStrLabel.hidden = NO;
        }
        else{
            _addImageStrLabel.hidden = YES;
        }
    }
    else{
        [cell.profilePhoto setImage:_imageArray[indexPath.item]];
        cell.closeButton.hidden = NO;
    }
    [cell setBigImageViewWithImage:nil];
    cell.profilePhoto.tag = [indexPath item];
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.profilePhoto .userInteractionEnabled = YES;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-64) /4 ,([UIScreen mainScreen].bounds.size.width-64) /4);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 8, 20, 8);
}

#pragma 点击事件

- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_imageArray.count)) {
        [self.view endEditing:YES];
        //添加新图片
        [self addNewImg];
    }
    else{
        //点击放大查看
        HWCollectionViewCell *cell = (HWCollectionViewCell*)[_contentView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if (!cell.BigImageView || !cell.BigImageView.image) {
            [cell setBigImageViewWithImage:self.imageArray[index]];
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImageView] selecImageindex:0];
    }
}

- (void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex {
    
}

- (void)addNewImg{
    NSMutableArray *selectedAsset = [[NSMutableArray alloc]initWithArray:self.arrSelected];
    [self showImgPickerActionSheetInView:self selectedAssets:selectedAsset];
}

#pragma PublishInteractionDelegate method

- (void)didFinishSelectImage:(NSArray *)arrImages andAssets:(NSArray *)assets{
    for (UIImage * img in arrImages) {
        [self.imageArray addObject:img];
    }
    for (PHAsset * asset in assets) {
        [self.arrSelected addObject:asset];
    }
    [self.contentView reloadData];
}

- (void)changeCollectionViewHeight{
    
    if (_collectionFrameY) {
        _contentView.frame = CGRectMake(0, _collectionFrameY, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
    }
    else{
        _contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
    }
}

- (void)deletePhoto:(UIButton *)sender{
    
    [_imageArray removeObjectAtIndex:sender.tag];
    [_arrSelected removeObjectAtIndex:sender.tag];
    
    [self.contentView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];
    
    for (NSInteger item = sender.tag; item <= _imageArray.count; item++) {
        HWCollectionViewCell *cell = (HWCollectionViewCell*)[self.contentView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        cell.closeButton.tag--;
        cell.profilePhoto.tag--;
    }
}

#pragma UITextViewDelegate

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = _inputHint;
        textView.textColor = [UIColor lightGrayColor];
        textView.tag = 0;
    }
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    return YES;
}

#pragma show img picker

-(void)showImgPickerActionSheetInView:(UIViewController *)controller selectedAssets:(NSMutableArray *)selectedAssetes {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"拍照"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!self.imaPic) {
            self.imaPic = [[UIImagePickerController alloc] init];
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imaPic.sourceType = UIImagePickerControllerSourceTypeCamera;
            //self.imaPic.delegate = self;
            [self.viewController presentViewController:self.imaPic animated:NO completion:nil];
        }
        
    }];
    
    UIAlertAction *actionAlbum = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"相册"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.imageArray removeAllObjects];
        [self.arrSelected removeAllObjects];
        [self.bigImageArray removeAllObjects];
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAX_PICK_NUM delegate:self];
        imagePickerVc.selectedAssets = selectedAssetes;
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [self didFinishSelectImage:photos andAssets:assets];
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
    _viewController = controller;
    [_viewController presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)submitButton:(id)sender {
    NSString *message = self.interactionTextView.text;
    AFNHttpRequest *request = [[AFNHttpRequest alloc] initWithDelegate:self];
    [request setRequestUrl:@"http://127.0.0.1:2018/upload/interaction"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:message forKey:@"content"];
    [dictionary setObject:@1001 forKey:@"userId"];
    [dictionary setObject:@"hot" forKey:@"topic"];
    [request setRequestParams:dictionary];
    [request requestMultipartMediaFormData:_imageArray];
}

- (void)requestFinishedSuccessed:(NSDictionary *)dictionary {
    NSEnumerator *enumeraor = [dictionary keyEnumerator];
    NSString *key = [enumeraor nextObject];
    while (key) {
        NSLog(@"%@", [dictionary objectForKey:key]);
        key = [enumeraor nextObject];
    }
    
    [self.contentView makeToast:@"动态发布成功"
                duration:3.0
                position:CSToastPositionBottom];
}

- (void)requestFinishedFailed:(NSDictionary *)dictionary {
    NSEnumerator *enumeraor = [dictionary keyEnumerator];
    NSString *key = [enumeraor nextObject];
    while (key) {
        NSLog(@"%@", [dictionary objectForKey:key]);
        key = [enumeraor nextObject];
    }
}

@end

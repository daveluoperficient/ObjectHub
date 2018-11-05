#import "HomePageViewController.h"
#import "OHFallsLayout.h"
#import "Blindside.h"

@interface HomePageViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, readwrite) IBOutlet UICollectionView *collectionView;
@property(nonatomic, readwrite) UICollectionViewLayout *layout;

@property(nonatomic,strong) NSArray* heightArr;

@end

@implementation HomePageViewController

static NSString * identifer = @"CollectionCell";

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initViewController)
                                  argumentKeys:nil
            ];
}

- (instancetype)initViewController {
    self = [super init];
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

#pragma CollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell* cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.heightArr.count;
}

-(UICollectionView *)collectionView {
    [_collectionView setCollectionViewLayout:self.layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifer];
    return _collectionView;
}

-(UICollectionViewLayout *)layout{
    if(!_layout){
        _layout = [[OHFallsLayout alloc]initWithItemsHeightBlock:^CGFloat(NSIndexPath *index) {
            return [self.heightArr[index.item] floatValue];
        }];
        
    }
    return _layout;
}

-(NSArray *)heightArr{
    if(!_heightArr){
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i<100; i++) {
            [arr addObject:@(arc4random()%100+80)];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}

@end

@interface CollectionViewCell()

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor=[self randomColor];
    }
    return self;
}

-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end

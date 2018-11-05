#import "OHFallsLayout.h"

#define colMargin 5
#define colCount 2
#define rolMargin 5

@interface OHFallsLayout ()

@property(nonatomic, strong) NSMutableArray* colsHeight;
@property(nonatomic, assign) CGFloat colWidth;

@property (nonatomic, copy, nullable) CGFloat (^heightBlock)(NSIndexPath *);

@end

@implementation OHFallsLayout

- (OHFallsLayout *)initWithItemsHeightBlock:(CGFloat (^)(NSIndexPath *))heightBlock {
    self = [super init];
    if (self) {
        self.heightBlock = heightBlock;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.colWidth = (self.collectionView.frame.size.width - (colCount+1)*colMargin )/colCount;
    self.colsHeight = nil;
}

- (CGSize)collectionViewContentSize {
    NSNumber *longest = self.colsHeight[0];
    for (NSInteger i =0;i<self.colsHeight.count;i++) {
        NSNumber* rolHeight = self.colsHeight[i];
        if(longest.floatValue<rolHeight.floatValue){
            longest = rolHeight;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, longest.floatValue);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSNumber * shortest = self.colsHeight[0];
    NSInteger  shortCol = 0;
    for (NSInteger i =0;i<self.colsHeight.count;i++) {
        NSNumber* rolHeight = self.colsHeight[i];
        if(shortest.floatValue>rolHeight.floatValue){
            shortest = rolHeight;
            shortCol=i;
        }
    }
    CGFloat x = (shortCol+1)*colMargin+ shortCol * self.colWidth;
    CGFloat y = shortest.floatValue+colMargin;
    
    CGFloat height=0;
    NSAssert(self.heightBlock!=nil, @"未实现计算高度的block ");
    if(self.heightBlock){
        height = self.heightBlock(indexPath);
    }
    attr.frame= CGRectMake(x, y, self.colWidth, height);
    self.colsHeight[shortCol]=@(shortest.floatValue+colMargin+height);
    
    return attr;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* array = [NSMutableArray array];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<items;i++) {
        UICollectionViewLayoutAttributes* attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attr];
    }
    return array;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(NSMutableArray *)colsHeight{
    if(!_colsHeight){
        NSMutableArray * array = [NSMutableArray array];
        for(int i =0;i<colCount;i++){
            [array addObject:@(0)];
        }
        _colsHeight = [array mutableCopy];
    }
    return _colsHeight;
}

@end

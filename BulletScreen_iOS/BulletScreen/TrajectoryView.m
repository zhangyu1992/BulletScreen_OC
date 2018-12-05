//
//  TrajectoryView.m
//  BulletScreen_iOS
//
//  Created by 张张 on 2018/11/29.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "TrajectoryView.h"

#define KKWidth [UIScreen mainScreen].bounds.size.width
#define KKHeight [UIScreen mainScreen].bounds.size.height
#define SpeaceWidth 50
#define BulletTimeDuration 5

@interface TrajectoryView ()

@property (nonatomic, strong) NSMutableArray * cachePoolArray;// 缓存池
@property (nonatomic, strong) UILabel * lastBulletLabel;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) BOOL bulletState;// 弹道状态 yes:占用 NO：空闲
@end

@implementation TrajectoryView

- (NSMutableArray *)cachePoolArray{
    if (_cachePoolArray == nil) {
        _cachePoolArray = [[NSMutableArray alloc]init];
    }
    return _cachePoolArray;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
// 初始
- (void)setTextDataArray:(NSMutableArray *)textDataArray{
    self.arrayModel.modelArray = textDataArray;
}
// 添加
- (void)addBulletTextWith:(NSString *)text{
    
    if (self.bulletState) {
        // 当前弹道占用
        [self.dataArray addObject:text];
        NSLog(@"当前弹道占用");
    }else{
        // 弹道空闲
        if(self.arrayModel.modelArray.count == 0){
            [[self.arrayModel mutableArrayValueForKeyPath:@"modelArray"] addObject:text];
        }
    }

}

- (instancetype)init{
    if (self = [super init]) {
        [self instanceData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self instanceData];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"modelArray"]) {
        [self checkCachePool];
    }
}
- (void)dealloc{
    [self.arrayModel removeObserver:self forKeyPath:@"modelArray"];
    
}
- (void)instanceData{
    
    UILabel * firstLabel = [self creatLabel];
    [self.cachePoolArray addObject:firstLabel];
    
    self.arrayModel = [[ArrayModel alloc]init];
    [self.arrayModel addObserver:self forKeyPath:@"modelArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

}
- (UILabel *)creatLabel{
    UILabel * bulletLabel = [[UILabel alloc]init];
    bulletLabel.textAlignment = NSTextAlignmentCenter;
    bulletLabel.font = [UIFont systemFontOfSize:16];
    bulletLabel.textColor = [UIColor redColor];
    bulletLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:bulletLabel];
    return bulletLabel;
}
- (void)checkCachePool{
    
    if (self.arrayModel.modelArray.count > 0) {
        NSString * bulletText =     self.arrayModel.modelArray.firstObject;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:16]
                                     };
        float width = [bulletText sizeWithAttributes:attributes].width;
        UILabel * bulletLabel;
        if (self.cachePoolArray.count > 0) {
            bulletLabel = self.cachePoolArray.firstObject;
        }else{
            bulletLabel = [self creatLabel];
        }
        bulletLabel.text = bulletText;
        bulletLabel.frame = CGRectMake(KKWidth, 0, width, 20);
        [self startBulletScreenWith:bulletLabel];
    }
}
- (void)startBulletScreenWith:(UILabel *)bulletLabel{
    
    __weak typeof(self) weakSelf = self;
    self.bulletState = YES;
    [UIView animateWithDuration:BulletTimeDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = CGRectMake(-CGRectGetWidth(bulletLabel.frame), 0, bulletLabel.frame.size.width, bulletLabel.frame.size.height);
       bulletLabel.frame = frame;
        
    } completion:^(BOOL finished) {
        if (weakSelf.finishedAnimation) {
            weakSelf.finishedAnimation();
        }
        weakSelf.bulletState = NO;
        
        if (weakSelf.arrayModel.modelArray.count > 0) {
            [[weakSelf.arrayModel mutableArrayValueForKey:@"modelArray"] removeObjectAtIndex:0];
        }
        if (weakSelf.arrayModel.modelArray.count == 0 && weakSelf.dataArray.count !=0){

            weakSelf.arrayModel.modelArray = [weakSelf.dataArray mutableCopy];
            [weakSelf.dataArray removeAllObjects];
            
        }
        
    }];
}

@end

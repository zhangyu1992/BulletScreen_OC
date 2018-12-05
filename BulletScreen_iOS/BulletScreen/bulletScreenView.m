//
//  bulletScreenView.m
//  BulletScreen_iOS
//
//  Created by 张张 on 2018/11/28.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "bulletScreenView.h"

#define KKWidth [UIScreen mainScreen].bounds.size.width
#define KKHeight [UIScreen mainScreen].bounds.size.height
#define SpeaceWidth 50
#define BulletTimeDuration 5
@interface bulletScreenView ()
@property (nonatomic, strong) UILabel * bulletLabel;

@end
@implementation bulletScreenView
- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.bulletLabel];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bulletLabel];
    }
    return self;
}
- (void)setBulletText:(NSString *)bulletText{
    
    _bulletText = bulletText;
    self.bulletLabel.text = bulletText;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16]
                                 };
    float width = [bulletText sizeWithAttributes:attributes].width;
    self.bulletLabel.frame = CGRectMake(KKWidth, 0, width, 20);

}
-(UILabel *)bulletLabel{
    if (_bulletLabel == nil) {

        _bulletLabel = [[UILabel alloc]init];
        _bulletLabel.textAlignment = NSTextAlignmentCenter;
        _bulletLabel.font = [UIFont systemFontOfSize:16];
        _bulletLabel.textColor = [UIColor redColor];
    }
    return _bulletLabel;
}
- (void)startBulletScreen{
    
    [UIView animateWithDuration:BulletTimeDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = CGRectMake(-CGRectGetWidth(self.bulletLabel.frame), 0, self.bulletLabel.frame.size.width, self.bulletLabel.frame.size.height);
        self.bulletLabel.frame = frame;
        
    } completion:^(BOOL finished) {
        if (self.finishedAnimation) {
            self.finishedAnimation();

        }

    }];
}

@end

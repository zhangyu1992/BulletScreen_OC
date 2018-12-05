//
//  bulletScreenView.h
//  BulletScreen_iOS
//
//  Created by 张张 on 2018/11/28.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bulletScreenView : UIView

@property (nonatomic, copy) NSString * bulletText;
@property (nonatomic, copy) void (^finishedAnimation)(void);
- (void)startBulletScreen;

@end

NS_ASSUME_NONNULL_END

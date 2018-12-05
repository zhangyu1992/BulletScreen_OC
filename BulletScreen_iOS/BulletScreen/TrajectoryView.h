//
//  TrajectoryView.h
//  BulletScreen_iOS
//
//  Created by 张张 on 2018/11/29.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrajectoryView : UIView
@property (nonatomic, strong) NSMutableArray * textDataArray;// 弹幕数据
@property (nonatomic, copy) void (^finishedAnimation)(void);
@property (nonatomic, strong) ArrayModel * arrayModel;
- (void)addBulletTextWith:(NSString *)text;
@end

NS_ASSUME_NONNULL_END

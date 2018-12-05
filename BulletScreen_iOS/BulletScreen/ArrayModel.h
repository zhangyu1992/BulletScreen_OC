//
//  ArrayModel.h
//  BulletScreen_iOS
//
//  Created by 张张 on 2018/11/29.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArrayModel : NSObject
@property (nonatomic, copy) NSString * modelName;
@property (nonatomic, strong) NSMutableArray * modelArray;

@end

NS_ASSUME_NONNULL_END

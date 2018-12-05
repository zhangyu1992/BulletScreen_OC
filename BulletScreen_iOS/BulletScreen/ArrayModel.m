//
//  ArrayModel.m
//  BulletScreen_iOS
//
//  Created by 张张 on 2018/11/29.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ArrayModel.h"

@implementation ArrayModel
-(NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [[NSMutableArray alloc]init];
        
    }
    return _modelArray;
}
@end

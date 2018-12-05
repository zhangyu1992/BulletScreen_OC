//
//  ViewController.m
//  BulletScreen_iOS
//
//  Created by 张张 on 2018/11/28.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ViewController.h"
#import "bulletScreenView.h"
#import "TrajectoryView.h"
#define maxNUM 3 // 弹幕的行数
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * bulletViewArray;
@property (weak, nonatomic) IBOutlet UITextField *textFile;

@property (nonatomic, strong) NSMutableArray * trajectoryArray;

@end

@implementation ViewController
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]initWithArray:@[@"我是弹幕1",@"我是弹幕2",@"我是弹幕3",@"我是弹幕4",@"我是弹幕5",@"我是弹幕6",@"我是弹幕7",@"我是弹幕8",@"我是弹幕9",@"我是弹幕10",@"我是弹幕11"]];
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    int num  = 0;
    while (num < maxNUM) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((num + 1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            bulletScreenView * bulletView = [[bulletScreenView alloc]init];
            bulletView.bulletText = @"默认文字";
            bulletView.frame =CGRectMake(0, num * 50 + 100, [UIScreen mainScreen].bounds.size.width,50);
            bulletView.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:bulletView];
            //            [self.bulletViewArray addObject:bulletView];
            [self startWith:num andBulletView:bulletView andAddIndex:maxNUM];
        });
        num++;
    }
    
    int num2 = 0;
    while (num2 < maxNUM) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((num2) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            TrajectoryView * trajectoryView = [[TrajectoryView alloc]initWithFrame:CGRectMake(0, 300 + num2 * 50, [UIScreen mainScreen].bounds.size.width, 50)];
            trajectoryView.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:trajectoryView];
            NSMutableArray * array =  [[NSMutableArray alloc]init];
            [self startTrajectoryWith:num2 andTrajectoryArray:array andAddIndex:maxNUM];
            trajectoryView.textDataArray = array;
            
            [self.trajectoryArray addObject:trajectoryView];
            
            if (num2 == maxNUM -1) {
                NSInteger index = self.dataArray.count % maxNUM;
                NSArray * subArray = [self.trajectoryArray subarrayWithRange:NSMakeRange(0, index)];
                NSArray * preArray = [self.trajectoryArray subarrayWithRange:NSMakeRange(index, self.trajectoryArray.count - index)];
                [self.trajectoryArray removeAllObjects];
                [self.trajectoryArray addObjectsFromArray:preArray];
                [self.trajectoryArray addObjectsFromArray:subArray];
            }
            
        });
        num2 ++;
    }
}

#pragma mark -- 保存弹道
-(NSMutableArray *)trajectoryArray{
    if (_trajectoryArray == nil) {
        _trajectoryArray = [[NSMutableArray alloc]init];
    }
    return _trajectoryArray;
}
#pragma mark -- 初始化弹道中 弹幕数组
- (NSMutableArray *)startTrajectoryWith:(int)index andTrajectoryArray:(NSMutableArray *)trajectoryarray andAddIndex:(int)addIndex{
    __block int i = index;
    __block int num = addIndex;
    NSString * text = self.dataArray[i];
    [trajectoryarray addObject:text];
    i = i + num;
    if (i < self.dataArray.count) {
        [self startTrajectoryWith:i andTrajectoryArray:trajectoryarray andAddIndex:num];
    }
    
    return trajectoryarray;
}
#pragma mark -- 发送弹幕
- (IBAction)sendBulletMessage:(id)sender {
    NSLog(@"%@",self.textFile.text);
    
    TrajectoryView * trajectoryView = self.trajectoryArray.firstObject;
    [self.trajectoryArray insertObject:trajectoryView atIndex:self.trajectoryArray.count];
    [self.trajectoryArray removeObjectAtIndex:0];
    [trajectoryView addBulletTextWith:self.textFile.text];

}

#pragma mark -- test1
-(NSMutableArray *)bulletViewArray{
    if (_bulletViewArray == nil) {
        _bulletViewArray = [[NSMutableArray alloc]init];
    }
    return _bulletViewArray;
}

- (void)startWith:(int)index andBulletView:(bulletScreenView *)bulletView andAddIndex:(int)addIndex{
    __block int i = index;
    __block int num = addIndex;
    NSString * text = self.dataArray[i];
    
    __weak bulletScreenView * bulletViewBlock = bulletView;
    bulletViewBlock.bulletText = text;
    [bulletViewBlock startBulletScreen];
    
    bulletViewBlock.finishedAnimation = ^{
        i = i + num;
        if (i < self.dataArray.count) {
            [self startWith:i andBulletView:bulletViewBlock andAddIndex:num];
        }else{
            
        }
    };
}
@end

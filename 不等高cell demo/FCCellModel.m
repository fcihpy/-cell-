//
//  FCCellModel.m
//  不等高cell demo
//
//  Created by locojoy on 16/2/2.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import "FCCellModel.h"

@implementation FCCellModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    FCCellModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end


#pragma mark   - FCCompnayInfoModel

@implementation FCCompnayInfoModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    FCCompnayInfoModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
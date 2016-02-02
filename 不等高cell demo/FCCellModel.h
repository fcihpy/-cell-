//
//  FCCellModel.h
//  不等高cell demo
//
//  Created by locojoy on 16/2/2.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FCCellModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *picture;
@property (assign, nonatomic, getter=isVip) BOOL vip;

/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end


@interface FCCompnayInfoModel : NSObject;

@property (strong, nonatomic) NSString *compnayName;
@property (strong, nonatomic) NSString *fax;
@property (strong, nonatomic) NSString *networkAddress;
@property (strong, nonatomic) NSString *telephone;
/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

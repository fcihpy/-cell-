//
//  FCCustomCell.h
//  不等高cell demo
//
//  Created by locojoy on 16/2/2.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCCellModel.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface FCCustomCell : UITableViewCell

@property (nonatomic,strong) FCCellModel *cellModel;


+ (instancetype)cellWithTableView:(UITableView *)tableView reuseID:(NSString *)reuseID;

@end


@interface FCCompanyInfoCell : UIView

@property (nonatomic,strong) FCCompnayInfoModel *infoModel;

- (instancetype)initCellWithModel:(FCCompnayInfoModel *)infoModel;

@end

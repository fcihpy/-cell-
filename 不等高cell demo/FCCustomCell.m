//
//  FCCustomCell.m
//  不等高cell demo
//
//  Created by locojoy on 16/2/2.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import "FCCustomCell.h"

@interface FCCustomCell ()

@property (strong, nonatomic) UIImageView     *iconView;
@property (strong, nonatomic) UILabel         *nameLabel;
@property (strong, nonatomic) UIImageView     *vipView;
@property (strong, nonatomic) UILabel         *contentLabel;
@property (strong, nonatomic) UIImageView     *pictureView;

@end


@implementation FCCustomCell

+ (instancetype)cellWithTableView:(UITableView *)tableView reuseID:(NSString *)reuseID{
    return [tableView dequeueReusableCellWithIdentifier:reuseID];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
    _iconView = [[UIImageView alloc]init];
    _iconView.frame = CGRectMake(10, 10, 30, 30);
    [self.contentView addSubview:_iconView];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake(50, 10, 100, 21);
    [self.contentView addSubview:_nameLabel];

    _vipView = [[UIImageView alloc]init];
    _vipView.frame = CGRectMake(102, 14, 14, 14);
    [self.contentView addSubview:_vipView];

    _contentLabel  = [[UILabel alloc]init];
    _contentLabel.frame = CGRectMake(10, 50, 42, 21);
    _contentLabel.font = [UIFont systemFontOfSize:15.f];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    _pictureView = [[UIImageView alloc]init];
    _pictureView.frame = CGRectMake(10, 81, 100, 100);
    [self.contentView addSubview:_pictureView];
    
}

- (void)setCellModel:(FCCellModel *)cellModel{
    _cellModel = cellModel;
    
    if (cellModel.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    //name
    self.nameLabel.text = cellModel.name;
    CGSize nameSize = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
    _nameLabel.frame = CGRectMake(50, 10, nameSize.width, 21);

    //iconView
    self.iconView.image = [UIImage imageNamed:cellModel.icon];
    
    //content
    self.contentLabel.text = cellModel.text;
    CGSize contentMaxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, MAXFLOAT);
    CGSize contentSize = [self getSizeForString:self.cellModel.text fontSize:15.f rect:contentMaxSize lineBreakMode:NSLineBreakByCharWrapping];

    _contentLabel.frame = CGRectMake(10, 50, contentSize.width, contentSize.height);

    //picture
    if (cellModel.picture) {
        self.pictureView.hidden = NO;
        self.pictureView.image = [UIImage imageNamed:cellModel.picture];
    } else {
        self.pictureView.hidden = YES;
    }
    _pictureView.frame = CGRectMake(10, CGRectGetMaxY(_contentLabel.frame) + 15, 100, 100);

    // 强制布局
    [self layoutIfNeeded];
    
    // 计算cell的高度
    if (self.pictureView.hidden) { // 没有配图
        cellModel.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 10;
    } else { // 有配图
        cellModel.cellHeight = CGRectGetMaxY(self.pictureView.frame) + 10;
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (CGSize)getSizeForString:(NSString *)string
                  fontSize:(float)fontSize
                      rect:(CGSize)rect
             lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    if ([string isEqualToString:@""]) {
        return CGSizeMake(0, 0);
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    if (lineBreakMode) {
        paragraphStyle.lineBreakMode = lineBreakMode ;
    }
    
    NSDictionary *dict =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                          NSParagraphStyleAttributeName:paragraphStyle};
    
    
    CGSize stringSize =  [string boundingRectWithSize:CGSizeMake(rect.width - 15, rect.height)
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:dict
                                              context:nil].size;
    
    return stringSize ;
}

@end


#pragma mark -  FCCompanyInfoCell

@interface FCCompanyInfoCell ()

@property (strong, nonatomic) UILabel         *nameLabel;
@property (strong, nonatomic) UILabel         *comfaxLabel;
@property (strong, nonatomic) UILabel         *networkAddressLabel;
@property (strong, nonatomic) UILabel         *telephoneLabel;

@end

@implementation FCCompanyInfoCell

- (instancetype)initCellWithModel:(FCCompnayInfoModel *)infoModel{
    if (self = [super init]) {
        [self initSubViews];
        self.infoModel = infoModel;
    }
    return self;
}

- (void)initSubViews{
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.contentMode = UIViewContentModeCenter;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.frame = CGRectZero;
    [self addSubview:_nameLabel];
    
    _comfaxLabel = [[UILabel alloc]init];
    _comfaxLabel.frame = CGRectZero;
    [self addSubview:_comfaxLabel];
    
    _networkAddressLabel = [[UILabel alloc]init];
    _networkAddressLabel.frame = CGRectZero;
    [self addSubview:_networkAddressLabel];
    
    
    _telephoneLabel = [[UILabel alloc]init];
    _telephoneLabel.frame = CGRectZero;
    [self addSubview:_telephoneLabel];
}

#define STRISEMPTY(str) (str==nil || [str isEqualToString:@""])

- (void)setInfoModel:(FCCompnayInfoModel *)infoModel{
    _infoModel = infoModel;
    
    CGFloat padding = 20.f;
    CGFloat marging = 10.f;
    if (infoModel.compnayName) {
        _nameLabel.text = infoModel.compnayName;
        _nameLabel.frame = CGRectMake(0,10, kScreenW, 20);
    }
    
    CGFloat currentY = CGRectGetMaxY(_nameLabel.frame);
    if (infoModel.fax) {
        _comfaxLabel.text = infoModel.fax;
        _comfaxLabel.frame = CGRectMake(padding, currentY + marging, kScreenW - padding, 21);
        currentY = CGRectGetMaxY(_comfaxLabel.frame) ;
    }
    
    if (infoModel.networkAddress) {
        _networkAddressLabel.text = infoModel.networkAddress;
        _networkAddressLabel.frame = CGRectMake(padding, currentY + marging, kScreenW - padding, 21);
        currentY = CGRectGetMaxY(_networkAddressLabel.frame) ;
    }
    
    if (infoModel.telephone) {
        _telephoneLabel.text = infoModel.telephone;
        _telephoneLabel.frame = CGRectMake(padding, currentY + marging, kScreenW - padding, 21);
        currentY = CGRectGetMaxY(_telephoneLabel.frame) ;
    }
    
    if (STRISEMPTY(infoModel.fax) && STRISEMPTY(infoModel.networkAddress) && STRISEMPTY(infoModel.telephone)) {
        _comfaxLabel.frame = CGRectMake(padding, currentY + marging, kScreenW - padding, 21);
        _comfaxLabel.text = @"暂无公司信息";
        currentY = CGRectGetMaxY(_comfaxLabel.frame) ;
    }
    
    [self layoutIfNeeded];
    _infoModel.cellHeight = currentY + padding;
    
}

- (CGSize)getSizeForString:(NSString *)string
                  fontSize:(float)fontSize
                      rect:(CGSize)rect
             lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    if ([string isEqualToString:@""]) {
        return CGSizeMake(0, 0);
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    if (lineBreakMode) {
        paragraphStyle.lineBreakMode = lineBreakMode ;
    }
    
    NSDictionary *dict =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                          NSParagraphStyleAttributeName:paragraphStyle};
    
    
    CGSize stringSize =  [string boundingRectWithSize:CGSizeMake(rect.width - 15, rect.height)
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:dict
                                              context:nil].size;
    
    return stringSize ;
}

@end

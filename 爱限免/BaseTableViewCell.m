//
//  BaseTableViewCell.m
//  爱限免
//
//  Created by 夏世萍 on 16/5/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
   
    //
    self.iconImgview.layer.cornerRadius = 8.0;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

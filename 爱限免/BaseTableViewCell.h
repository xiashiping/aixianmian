//
//  BaseTableViewCell.h
//  爱限免
//
//  Created by 夏世萍 on 16/5/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImgview;
@property (strong, nonatomic) IBOutlet UIImageView *starImgview;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UILabel *timelabel;
@property (strong, nonatomic) IBOutlet UILabel *plicelabel;
@property (strong, nonatomic) IBOutlet UILabel *sharelabel;
@property (strong, nonatomic) IBOutlet UILabel *collectionlabel;
@property (strong, nonatomic) IBOutlet UILabel *downlabel;
@property (strong, nonatomic) IBOutlet UILabel *gamelabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *allstar;

@end

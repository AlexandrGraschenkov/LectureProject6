//
//  WallCell.h
//  TestVK
//
//  Created by Alexander on 27.03.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WallCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *avatarImgView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;

@property (nonatomic, strong) NSDictionary *data;

+ (float)heightWithData:(NSDictionary*)dataDic;

@end

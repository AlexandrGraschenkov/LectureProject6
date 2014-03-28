//
//  WallCell.m
//  TestVK
//
//  Created by Alexander on 27.03.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "WallCell.h"

@implementation WallCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatarImgView.layer.masksToBounds = YES;
        self.avatarImgView.layer.cornerRadius = 25;
    }
    return self;
}

- (void)awakeFromNib
{
    self.avatarImgView.layer.masksToBounds = YES;
    self.avatarImgView.layer.cornerRadius = 25;
}


//@{@"sender" : @"Anna", @"sender_ava" : UIImage, @"message" : @"..."}
- (void)setData:(NSDictionary *)data
{
    _data = data;
    
    self.nameLabel.text = data[@"sender"];
    self.messageLabel.text = data[@"message"];
    self.avatarImgView.image = data[@"sender_ava"];
}


+ (float)heightWithData:(NSDictionary*)dataDic
{
    NSString *str = dataDic[@"message"];
//    CGSize textSize = [text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Regular" size:17.0] }];
    CGSize textSize = [str sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(303, 10000)];
    return textSize.height + 67 + 7 + 20;
}

@end

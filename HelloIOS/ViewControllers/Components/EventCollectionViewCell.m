//
//  EventCollectionViewCell.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/9.
//

#import "EventCollectionViewCell.h"

@implementation EventCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 单元格的宽度
        CGFloat cellWidth = self.frame.size.width;
        
        CGFloat imageViewWidth = 101;
        CGFloat imageViewHeight = 101;
        CGFloat imageViewTopView = 15;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((cellWidth - imageViewWidth) / 2, imageViewTopView, imageViewWidth, imageViewHeight)];
        [self addSubview:self.imageView];
        
        CGFloat labelWidth = 101;
        CGFloat labelHeight = 16;
        CGFloat labelTopView = 120;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake((cellWidth - labelWidth) / 2, labelTopView, labelWidth, labelHeight)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.label];
    }
    return self;
}

@end

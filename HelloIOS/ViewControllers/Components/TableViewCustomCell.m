//
//  TableViewCustomCell.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/15.
//

#import "TableViewCustomCell.h"

@implementation TableViewCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGFloat cellHeight = self.frame.size.height;
        
        CGFloat imageViewWidth = 39;
        CGFloat imageViewHeight = 28;
        CGFloat imageViewLeftView = 300;
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewLeftView, (cellHeight - imageViewHeight) / 2, imageViewWidth, imageViewHeight)];
        
        [self addSubview:self.myImageView];
        
        CGFloat labelWidth = 120;
        CGFloat labelHeight = 21;
        CGFloat labelLeftView = 15;
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelLeftView, (cellHeight - labelHeight) / 2, labelWidth, labelHeight)];
        
        [self addSubview:self.myLabel];
    }
    
    return self;
}

@end

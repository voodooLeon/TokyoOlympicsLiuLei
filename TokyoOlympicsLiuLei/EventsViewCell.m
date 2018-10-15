//
//  EventsViewCell.m
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/10/15.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "EventsViewCell.h"

@implementation EventsViewCell

-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        //单元格的宽度
        CGFloat cellWidth=self.frame.size.width;
        
        /// 1.添加ImageView
        CGFloat imageViewWidth = 100;
        CGFloat imageViewHeight = 100;
        CGFloat imageViewTopView = 0;
        
        self.imageView = [[UIImageView alloc] initWithFrame: CGRectMake((cellWidth - imageViewWidth) / 2, imageViewTopView, imageViewWidth, imageViewHeight)];
        
        [self addSubview:self.imageView];
        
    }
    return self;
}
@end

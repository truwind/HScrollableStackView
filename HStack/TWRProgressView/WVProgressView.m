//
//  WVProgressView.m
//  HStack
//
//  Created by truwind on 2017. 9. 8..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "WVProgressView.h"

@interface WVProgressView ()

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) CGFloat progress;

@end

@implementation WVProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    
    return self;
}

- (void) setup {
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
    
    [self setValue:0.0];
}

- (BOOL)isSelected {
    return self.isSelected;
}

- (void)setSelect:(BOOL)isSelected{
    self.isSelected = isSelected;
    if(!isSelected) {
        [self setValue:0.0];
    }
}

- (void)setValue:(CGFloat)value{
    self.progress = value;
#if 0
    CGFloat newValue = value;
    newValue = newValue > 1.0 ? newValue/100 : newValue;
    
    const CGFloat margin = 0.0; // 6.0
    CGFloat width = self.frame.size.width - margin;
    CGFloat height = (self.frame.size.height - margin) * newValue;
    
    UIBezierPath * pathRef = [UIBezierPath bezierPathWithRect:CGRectMake(margin / 2.0, margin / 2.0, width, -height)];
    
    [[UIColor greenColor] setFill];
    [pathRef fill];
    
    [[UIColor clearColor] setStroke];
    [pathRef stroke];
    
    [pathRef closePath];
#endif
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    CGFloat newValue = self.progress;
    newValue = newValue > 1.0 ? newValue/100 : newValue;
    
    const CGFloat margin = 0.0; // 6.0
    CGFloat width = self.frame.size.width - margin;
    CGFloat height = (self.frame.size.height - margin) * newValue;
    
    UIBezierPath * pathRef = [UIBezierPath bezierPathWithRect:CGRectMake(margin / 2.0, margin / 2.0, width, -height)];
    
    [[UIColor greenColor] setFill];
    [pathRef fill];
    
    [[UIColor clearColor] setStroke];
    [pathRef stroke];
    
    [pathRef closePath];
    

//    [self setValue:self.progress];
}

@end

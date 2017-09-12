//
//  HorizonalScrollableStackView.m
//  HStack
//
//  Created by truwind on 2017. 9. 7..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "HorizonalScrollableStackView.h"

@interface HorizonalScrollableStackView() 

@end

@implementation HorizonalScrollableStackView

- (void) awakeFromNib {
    [super awakeFromNib];
    
    [self initialize:self.frame];
}

- (instancetype)initWithFrame:(CGRect)frame innerWidth:(CGFloat)width {
    self = [super initWithFrame:frame];
    if(self){
        [self initialize:frame];
    }
    
    return self;
}

- (void)initialize:(CGRect)frame{
    [super initialize:frame axis:UILayoutConstraintAxisHorizontal];
    [self setInnerViewSize:CGSizeMake(50, frame.size.height)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - LifeCycle Function
- (void)initStackView {
    [super initStackView];
}

#pragma mark - External Function

- (void)addCustomViewToStack:(UIView *)view{
    
    [view.widthAnchor constraintEqualToConstant:self.innerViewWidth].active = YES;
    [view.heightAnchor constraintEqualToConstant:self.innerViewHeight].active = YES;
    
    self.layoutEqualWidht.constant = self.innerViewWidth * (self.stackView.arrangedSubviews.count + 1);
    [self.stackView addArrangedSubview:view];
    [self.stackView  setNeedsLayout];
    
    [super addTapGestureToSubView:view tag:(self.stackView.arrangedSubviews.count - 1)];
}

- (void)insertCustomViewToStack:(UIView *)view index:(NSInteger)index {
    if(self.stackView.arrangedSubviews.count <= index) return;
    
    [view.widthAnchor constraintEqualToConstant:self.innerViewWidth].active = YES;
    [view.heightAnchor constraintEqualToConstant:self.innerViewHeight].active = YES;
    
    self.layoutEqualWidht.constant = self.innerViewWidth * (self.stackView.arrangedSubviews.count + 1);
    [self.stackView insertArrangedSubview:view atIndex:index];
    [self.stackView  setNeedsLayout];
    [super addTapGestureToSubView:view tag:(self.stackView.arrangedSubviews.count - 1)];
}

/**
 * function for Test
 */
//- (void)addUIViewToStack {
//    UIView * newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.innerViewWidth, self.innerViewHeight)];
//    UIColor *randomColor = [UIColor colorWithRed:(CGFloat)drand48() green:(CGFloat)drand48() blue:(CGFloat)drand48() alpha:1.0];
//    //
//    //newView.widthAnchor constraintEqualToConstant[].active = YES;로 설정해줘야 동적으로 subView를 추가할 수 있다..
//    [newView.widthAnchor constraintEqualToConstant:self.innerViewWidth].active = YES;
//    [newView.heightAnchor constraintEqualToConstant:self.innerViewHeight].active = YES;
//    newView.backgroundColor = randomColor;
//    
//    self.layoutEqualWidht.constant = self.innerViewWidth * (self.stackView.arrangedSubviews.count + 1);
//    [self.stackView addArrangedSubview:newView];
//    [self.stackView  setNeedsLayout];
//    
//}

@end

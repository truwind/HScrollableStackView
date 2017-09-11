//
//  BasicScrollableStackView.m
//  HStack
//
//  Created by truwind on 2017. 9. 11..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "BasicScrollableStackView.h"


@implementation BasicScrollableStackView

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
    }
    
    return self;
}

- (void)initialize:(CGRect)frame axis:(UILayoutConstraintAxis)axis{
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.layoutMargins = UIEdgeInsetsZero;
    [self addSubview:self.scrollView];
    
    self.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"self.scrollView.bounds :%@", NSStringFromCGRect(self.scrollView.bounds));
    self.stackView = [[UIStackView alloc] initWithFrame:self.scrollView.bounds];
    // stackView axis default : Horizontal.
    self.stackView.axis = axis;
    if(axis == UILayoutConstraintAxisHorizontal) {
        self.stackView.alignment = UIStackViewAlignmentFill;
        self.stackView.distribution = UIStackViewDistributionFillEqually;
    } else {
        self.stackView.alignment = UIStackViewAlignmentFill;
        self.stackView.distribution = UIStackViewDistributionFillEqually;
    }
    self.stackView.spacing = 0;
    
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.layoutMargins = UIEdgeInsetsZero;
    [self.scrollView addSubview:self.stackView];
    
    [self initLayoutConstraints];
}


- (void)initLayoutConstraints {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView":self.scrollView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView":self.scrollView}]];
    
    
    // Leading
    NSLayoutConstraint * layoutLeading = [NSLayoutConstraint constraintWithItem:self.stackView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.scrollView
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.
                                                                       constant:0];
    // Trailing
    NSLayoutConstraint * layoutTrailing = [NSLayoutConstraint constraintWithItem:self.stackView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.scrollView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.
                                                                        constant:0];
    
    // Top
    NSLayoutConstraint * layoutTop = [NSLayoutConstraint constraintWithItem:self.stackView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.scrollView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.
                                                                   constant:0];
    // Bottom
    NSLayoutConstraint * layoutBottom = [NSLayoutConstraint constraintWithItem:self.stackView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.scrollView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.
                                                                      constant:0];
    // Height
    self.layoutEqualHeight = [NSLayoutConstraint constraintWithItem:self.stackView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.
                                                           constant:0];
    // Equal Width
    self.layoutEqualWidht = [NSLayoutConstraint constraintWithItem:self.stackView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.scrollView
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.
                                                          constant:0];
    
    [self.scrollView addConstraints:@[layoutLeading, layoutTrailing, layoutTop, layoutBottom, self.layoutEqualHeight, self.layoutEqualWidht]];
    [self.scrollView setNeedsLayout];
}

#pragma mark - LifeCycle Function
- (void)initStackView {
    NSInteger numberOfRows = [self.dataSource numberOfRows:self];
    for(NSInteger i = 0; i < numberOfRows; i++){
        WVerticalProgressView * subView = (WVerticalProgressView*)[self.dataSource stackView:self cellForRowAtIndex:i];
        [self addCustomViewToStack:subView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark - External Function
- (void)setInnerViewSize:(CGSize)size{
    self.innerViewWidth = size.width;
    self.innerViewHeight = size.height;
}

- (void)addCustomViewToStack:(UIView *)view{
}


- (void)insertCustomViewToStack:(UIView *)view index:(NSInteger)index {
}

- (void)removeLastInnerView {
    UIView * removeView = self.stackView.arrangedSubviews.lastObject;
    if(removeView){
        [self.stackView removeArrangedSubview:removeView];
        [self.stackView removeFromSuperview];
    }
}

- (void)removeInnerViewAtIndex:(NSInteger)index{
    if(self.stackView.arrangedSubviews.count <= index) return;
    
    UIView * removeView = self.stackView.arrangedSubviews[index];
    if(removeView) {
        [self.stackView removeArrangedSubview:removeView];
        [self.stackView removeFromSuperview];
    }
}

- (NSInteger)getNumberOfSubViews {
    return self.stackView.arrangedSubviews.count;
}

- (WVerticalProgressView *)getSubViewWithIndex:(NSInteger)index{
    if(index >= self.stackView.arrangedSubviews.count) return nil;
    return self.stackView.arrangedSubviews[index];
}


#pragma mark -  function
- (void) addTapGestureToSubView:(UIView *)subView tag:(NSInteger)tag{
    UITapGestureRecognizer * tapHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tapHandler.delegate = self;
    subView.tag = tag;
    [subView addGestureRecognizer:tapHandler];
    
    UILongPressGestureRecognizer * longHandler = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longHandler.delegate = self;
    longHandler.minimumPressDuration = 1.0;
    [subView addGestureRecognizer:longHandler];
}


#pragma mark - UITapGestureRecognizerDelegate
- (void) tapHandler:(UITapGestureRecognizer*)sender {
    BOOL isSelected = NO;
    UIView * subView = nil;
    if([[sender.view class] isKindOfClass:[WVerticalProgressView class]]){
        WVerticalProgressView * item = (WVerticalProgressView *)sender.view;
        isSelected = subView.isSelected;
        subView = (UIView*)item;
    } else {
        subView = (UIView *)sender.view  ;
        isSelected = subView.isSelected;
//        subView = (UIView*)item;
    }
    
    if(subView){
        if(subView.isSelected) {
            // do unselect action
            if([self.delegate respondsToSelector:@selector(stackView:didDeSelectRowAtIndex:)]){
                [self.delegate stackView:self didSelectRowAtIndex:subView.tag];
            }
        } else {
            // do select action
            if([self.delegate respondsToSelector:@selector(stackView:didSelectRowAtIndex:)]) {
                [self.delegate stackView:self didSelectRowAtIndex:subView.tag];
            }
        }
        subView.isSelected =!subView.isSelected;
    }
}

- (void)longPressHandler:(UILongPressGestureRecognizer*)sender {
    WVerticalProgressView * subView = (WVerticalProgressView*)sender.view;
    if(subView){
        if([self.delegate respondsToSelector:@selector(stackView:didDeSelectRowAtIndex:)]){
            [self.delegate stackView:self didDeSelectRowAtIndex:subView.tag];
        }
    }
}

@end

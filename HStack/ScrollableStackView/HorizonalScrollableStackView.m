//
//  HorizonalScrollableStackView.m
//  HStack
//
//  Created by truwind on 2017. 9. 7..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "HorizonalScrollableStackView.h"

@interface HorizonalScrollableStackView() <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIStackView * stackView;
@property (assign, nonatomic) UILayoutConstraintAxis axis;
@property (assign, nonatomic) CGFloat innerViewWidth;
@property (assign, nonatomic) CGFloat innerViewHeight;
@property (strong, nonatomic) NSLayoutConstraint * layoutEqualWidht;

@end

@implementation HorizonalScrollableStackView

- (void) awakeFromNib {
    [super awakeFromNib];
    
    [self initialize:self.frame width:50];
}

- (instancetype)initWithFrame:(CGRect)frame innerWidth:(CGFloat)width{
    self = [super initWithFrame:frame];
    if(self){
        [self initialize:frame width:width];
    }
    
    return self;
}

- (void)initialize:(CGRect)frame width:(CGFloat)width {
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.layoutMargins = UIEdgeInsetsZero;
    [self addSubview:self.scrollView];
    
    NSLog(@"self.scrollView.bounds :%@", NSStringFromCGRect(self.scrollView.bounds));
    self.stackView = [[UIStackView alloc] initWithFrame:self.scrollView.bounds];
    // stackView axis default : Horizontal.
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    self.stackView.spacing = 0;
    
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.layoutMargins = UIEdgeInsetsZero;
    [self.scrollView addSubview:self.stackView];
    
    [self setInnerViewSize:CGSizeMake(width, frame.size.height)];
    
    [self initLayoutConstraints];
    
//    for(int i =0 ; i < 10; i++)
//        [self addUIViewToStack];
    
//    [self initStackView];
}

- (void)initLayoutConstraints {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[scrollView]-|" options:0 metrics:nil views:@{@"scrollView":self.scrollView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[scrollView]-|" options:0 metrics:nil views:@{@"scrollView":self.scrollView}]];


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
    NSLayoutConstraint * layoutHeight = [NSLayoutConstraint constraintWithItem:self.stackView
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

    [self.scrollView addConstraints:@[layoutLeading, layoutTrailing, layoutTop, layoutBottom, layoutHeight, self.layoutEqualWidht]];
    [self.scrollView setNeedsLayout];
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
    NSInteger numberOfRows = [self.dataSource numberOfRows:self];
    for(NSInteger i = 0; i < numberOfRows; i++){
        WVerticalProgressView * subView = [self.dataSource stackView:self cellForRowAtIndex:i];
        [self addCustomViewToStack:subView];
    }
}

#pragma mark - External Function
- (void)setInnerViewSize:(CGSize)size{
    self.innerViewWidth = size.width;
    self.innerViewHeight = size.height;
}

- (void)addCustomViewToStack:(UIView *)view{
    
    [view.widthAnchor constraintEqualToConstant:self.innerViewWidth].active = YES;
    [view.heightAnchor constraintEqualToConstant:self.innerViewHeight].active = YES;
    
    self.layoutEqualWidht.constant = self.innerViewWidth * (self.stackView.arrangedSubviews.count + 1);
    [self.stackView addArrangedSubview:view];
    [self.stackView  setNeedsLayout];
    
    [self addTapGestureToSubView:view tag:(self.stackView.arrangedSubviews.count - 1)];
}

- (void)insertCustomViewToStack:(UIView *)view index:(NSInteger)index {
    if(self.stackView.arrangedSubviews.count <= index) return;
    
    [view.widthAnchor constraintEqualToConstant:self.innerViewWidth].active = YES;
    [view.heightAnchor constraintEqualToConstant:self.innerViewHeight].active = YES;
    
    self.layoutEqualWidht.constant = self.innerViewWidth * (self.stackView.arrangedSubviews.count + 1);
    [self.stackView insertArrangedSubview:view atIndex:index];
    [self.stackView  setNeedsLayout];
    [self addTapGestureToSubView:view tag:(self.stackView.arrangedSubviews.count - 1)];
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

#pragma mark - Private function
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
    WVerticalProgressView * subView = (WVerticalProgressView *)sender.view;
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

/**
 * function for Test
 */
- (void)addUIViewToStack {
    UIView * newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.innerViewWidth, self.innerViewHeight)];
    UIColor *randomColor = [UIColor colorWithRed:(CGFloat)drand48() green:(CGFloat)drand48() blue:(CGFloat)drand48() alpha:1.0];
    //
    //newView.widthAnchor constraintEqualToConstant[].active = YES;로 설정해줘야 동적으로 subView를 추가할 수 있다..
    [newView.widthAnchor constraintEqualToConstant:self.innerViewWidth].active = YES;
    [newView.heightAnchor constraintEqualToConstant:self.innerViewHeight].active = YES;
    newView.backgroundColor = randomColor;
    
    self.layoutEqualWidht.constant = self.innerViewWidth * (self.stackView.arrangedSubviews.count + 1);
    [self.stackView addArrangedSubview:newView];
    [self.stackView  setNeedsLayout];
    
}

@end

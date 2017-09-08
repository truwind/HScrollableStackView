//
//  HorizonalScrollableStackView.m
//  HStack
//
//  Created by truwind on 2017. 9. 7..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "HorizonalScrollableStackView.h"

@interface HorizonalScrollableStackView()

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
    
    for(int i =0 ; i < 10; i++)
        [self addUIViewToStack];
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

- (void)setInnerViewSize:(CGSize)size{
    self.innerViewWidth = size.width;
    self.innerViewHeight = size.height;
}

- (void)setAxis:(UILayoutConstraintAxis)axis {
    self.axis = axis;
}

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

- (void)insertUIViewToStack:(NSInteger)index{
    
}

- (void)addCustomViewToStack:(UIView *)view{
    
}

- (void)insertCustomViewToStack:(UIView *)view index:(NSInteger)index{
    
}

- (void)removeInnerView{
    
}

- (void)removeInnerViewAtIndex:(NSInteger)index{
    
}

@end

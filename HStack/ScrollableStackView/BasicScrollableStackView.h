//
//  BasicScrollableStackView.h
//  HStack
//
//  Created by truwind on 2017. 9. 11..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollableStackViewDelegate.h"
#import "UIView+FMenu.h"
#import "HStack-Swift.h"

@interface BasicScrollableStackView : UIView <UIGestureRecognizerDelegate>

@property(nonatomic,assign) id<ScrollableStackViewDataSource> dataSource;
@property(nonatomic,assign) id<ScrollableStackViewDelegate> delegate;


@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIStackView * stackView;
@property (assign, nonatomic) UILayoutConstraintAxis axis;
@property (assign, nonatomic) CGFloat innerViewWidth;
@property (assign, nonatomic) CGFloat innerViewHeight;
@property (strong, nonatomic) NSLayoutConstraint * layoutEqualWidht;
@property (strong, nonatomic) NSLayoutConstraint * layoutEqualHeight;


- (instancetype)initWithFrame:(CGRect)frame innerViewsize:(CGFloat)size axis:(UILayoutConstraintAxis)axis;
- (void)initialize:(CGRect)frame axis:(UILayoutConstraintAxis)axis;

- (void)initStackView;

- (void)setInnerViewSize:(CGSize)size;

- (void)addCustomViewToStack:(UIView *)view;
- (void)insertCustomViewToStack:(UIView *)view index:(NSInteger)index;


- (void)removeLastInnerView;
- (void)removeInnerViewAtIndex:(NSInteger)index;

- (NSInteger)getNumberOfSubViews;
- (WVerticalProgressView *)getSubViewWithIndex:(NSInteger)index;

- (void) addTapGestureToSubView:(UIView *)subView tag:(NSInteger)tag;

@end

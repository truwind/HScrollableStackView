//
//  HorizonalScrollableStackView.h
//  HStack
//
//  Created by truwind on 2017. 9. 7..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WProgressView.h"
#import "HStack-Swift.h"

@class HorizonalScrollableStackView;

@protocol HorizonalScrollableStackViewDataSource <NSObject>

- (NSInteger)numberOfRows:(HorizonalScrollableStackView*)stackView;
- (WVerticalProgressView *)stackView:(HorizonalScrollableStackView*)stackView cellForRowAtIndex:(NSInteger)index;

@end


@protocol HorizonalScrollableStackViewDelegate <NSObject>

- (void)stackView:(HorizonalScrollableStackView*)stackView didSelectRowAtIndex:(NSInteger)index;
- (void)stackView:(HorizonalScrollableStackView*)stackView didDeSelectRowAtIndex:(NSInteger)index;

@end


@interface HorizonalScrollableStackView : UIView

@property(nonatomic,assign) id<HorizonalScrollableStackViewDataSource> dataSource;
@property(nonatomic,assign) id<HorizonalScrollableStackViewDelegate> delegate;


- (void)initStackView;
- (instancetype)initWithFrame:(CGRect)frame innerWidth:(CGFloat)width;

- (void)setInnerViewSize:(CGSize)size;
//- (void)setAxis:(UILayoutConstraintAxis)axis;
//- (void)addUIViewToStack;
//- (void)insertUIViewToStack:(NSInteger)index;

- (void)addCustomViewToStack:(UIView *)view;
- (void)insertCustomViewToStack:(UIView *)view index:(NSInteger)index;


- (void)removeLastInnerView;
- (void)removeInnerViewAtIndex:(NSInteger)index;

- (NSInteger)getNumberOfSubViews;
- (WVerticalProgressView *)getSubViewWithIndex:(NSInteger)index;
@end

//
//  HorizonalScrollableStackView.h
//  HStack
//
//  Created by truwind on 2017. 9. 7..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HorizonalScrollableStackView : UIView

- (instancetype)initWithFrame:(CGRect)frame innerWidth:(CGFloat)width;

- (void)setInnerViewSize:(CGSize)size;
- (void)setAxis:(UILayoutConstraintAxis)axis;

- (void)addUIViewToStack;
- (void)insertUIViewToStack:(NSInteger)index;

- (void)addCustomViewToStack:(UIView *)view;
- (void)insertCustomViewToStack:(UIView *)view index:(NSInteger)index;


- (void)removeInnerView;
- (void)removeInnerViewAtIndex:(NSInteger)index;
@end

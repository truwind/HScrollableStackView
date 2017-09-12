//
//  ScrollableStackViewDelegate.h
//  HStack
//
//  Created by truwind on 2017. 9. 11..
//  Copyright © 2017년 truwind. All rights reserved.
//

#ifndef ScrollableStackViewDelegate_h
#define ScrollableStackViewDelegate_h
#import "InnerView.h"

//@class WVerticalProgressView;
@class BasicScrollableStackView;

@protocol ScrollableStackViewDataSource <NSObject>

- (NSInteger)numberOfRows:(BasicScrollableStackView*)stackView;
- (UIView *)stackView:(BasicScrollableStackView*)stackView cellForRowAtIndex:(NSInteger)index;

@end


@protocol ScrollableStackViewDelegate <NSObject>

- (void)stackView:(BasicScrollableStackView*)stackView didSelectRowAtIndex:(NSInteger)index;
- (void)stackView:(BasicScrollableStackView*)stackView didDeSelectRowAtIndex:(NSInteger)index;

@end


#endif /* ScrollableStackViewDelegate_h */

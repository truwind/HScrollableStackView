//
//  VerticalScrollableStackView.h
//  HStack
//
//  Created by truwind on 2017. 9. 11..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicScrollableStackView.h"

@interface VerticalScrollableStackView : BasicScrollableStackView

- (instancetype)initWithFrame:(CGRect)frame innerHeight:(CGFloat)height;


@end

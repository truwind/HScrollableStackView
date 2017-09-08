//
//  WVProgressView.h
//  HStack
//
//  Created by truwind on 2017. 9. 8..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WVProgressView : UIView

- (BOOL)isSelected;
- (void)setSelect:(BOOL)isSelected;
- (void)setValue:(CGFloat)value;

@end

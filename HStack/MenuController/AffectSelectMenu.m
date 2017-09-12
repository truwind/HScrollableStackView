//
//  AffectSelectMenu.m
//  HStack
//
//  Created by truwind on 2017. 9. 12..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "AffectSelectMenu.h"
#import "HorizonalScrollableStackView.h"
#import "VerticalScrollableStackView.h"

@interface AffectSelectMenu () <ScrollableStackViewDelegate, ScrollableStackViewDataSource>
@property (weak, nonatomic) IBOutlet HorizonalScrollableStackView *vwCategoryContainer;
@property (weak, nonatomic) IBOutlet VerticalScrollableStackView *vwItemContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cItemContainerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cItemWidth;

@property (assign, nonatomic) CGFloat orginalItemHeight;

@property (assign, nonatomic) CGFloat innerViewWidth;
@property (assign, nonatomic) CGFloat innerViewHeight;
@end

@implementation AffectSelectMenu

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
    }
    return self;
}

- (void)initialzie {
    self.backgroundColor = [UIColor clearColor];
    self.innerViewWidth = 50;
    self.vwCategoryContainer.dataSource = self;
    self.vwCategoryContainer.delegate = self;
    [self.vwCategoryContainer setInnerViewSize:CGSizeMake(self.innerViewWidth, self.vwCategoryContainer.frame.size.height)];
    [self.vwCategoryContainer initStackView];
    
    self.innerViewHeight = 50;
    self.vwItemContainer.dataSource = self;
    self.vwItemContainer.delegate = self;
    [self.vwItemContainer setInnerViewSize:CGSizeMake(100, self.innerViewHeight)];
    [self.vwItemContainer initStackView];
    
    NSLog(@"self.vwCategoryContainer.frame : %@", NSStringFromCGRect(self.vwCategoryContainer.frame));
    self.orginalItemHeight  = self.vwItemContainer.frame.size.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - HorizonalScrollableStackViewDelegate
- (NSInteger)numberOfRows:(BasicScrollableStackView*)stackView {
    if(stackView == self.vwCategoryContainer)
        return 10;
    else
        return 10;
}

- (UIView *)stackView:(BasicScrollableStackView*)stackView cellForRowAtIndex:(NSInteger)index{
    if(stackView == self.vwCategoryContainer){
        WVerticalProgressView * subView = [[WVerticalProgressView alloc] initWithFrame:CGRectMake(0, 0, self.innerViewWidth, stackView.frame.size.height)];
        subView.layer.borderColor = [UIColor whiteColor].CGColor;
        subView.layer.borderWidth = 0.5;
        [subView setProgress:0.0];
        subView.backgroundColor = [UIColor yellowColor];
        return subView;
    } else {
        InnerView * subView = [[InnerView alloc] initWithFrame:CGRectMake(0, 0, 100, self.innerViewHeight)];
        subView.layer.borderColor = [UIColor whiteColor].CGColor;
        subView.layer.borderWidth = 0.5;
        subView.backgroundColor = [UIColor blackColor];
        
        return subView;
    }
}

#pragma mark - ScrollableStackViewDataSource
- (void)stackView:(BasicScrollableStackView*)stackView didSelectRowAtIndex:(NSInteger)index {
    if(stackView == self.vwCategoryContainer){
        NSLog(@"필터 카테고리 선택 : %d", index);
        //        [self.view layoutIfNeeded];
        
        // hide animation
        [UIView animateWithDuration:0.25 animations:^{
            self.vwItemContainer.transform = CGAffineTransformMakeScale(1, 0);
            //            self.cItemContainerHeight.constant = self.orginalItemHeight;
            //            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            //            [self.vwItemContainer setHidden:YES];
            
            [UIView animateWithDuration:0.25 animations:^{
                //                [self.vwItemContainer setHidden:NO];
                self.vwItemContainer.transform = CGAffineTransformIdentity;
                //                self.cItemContainerHeight.constant = 0;
                //                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
            }];
        }];
    } else {
        NSLog(@"Item 카테고리 선택 : %d", index);
    }
}

- (void)stackView:(BasicScrollableStackView*)stackView didDeSelectRowAtIndex:(NSInteger)index {
    if(stackView == self.vwCategoryContainer){
        NSLog(@"필터 카테고리 선택 해제: %d", index);
    } else {
        NSLog(@"Item 카테고리 선택 해제: %d", index);
    }
}

@end

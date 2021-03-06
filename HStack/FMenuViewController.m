//
//  FMenuViewController.m
//  HStack
//
//  Created by truwind on 2017. 9. 11..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "FMenuViewController.h"
#import "HorizonalScrollableStackView.h"
#import "VerticalScrollableStackView.h"

@interface FMenuViewController ()<ScrollableStackViewDelegate, ScrollableStackViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *vwMainContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cMainContainerHeight;
@property (weak, nonatomic) IBOutlet HorizonalScrollableStackView *vwCategoryContainer;
@property (weak, nonatomic) IBOutlet VerticalScrollableStackView *vwItemContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cItemContainerHeight;


@property (assign, nonatomic) CGFloat orginalMainMenuHeight;

@property (assign, nonatomic) CGFloat orginalItemHeight;

@property (assign, nonatomic) CGFloat innerViewWidth;
@property (assign, nonatomic) CGFloat innerViewHeight;

@property (assign, nonatomic) BOOL isLeftMenuShow;
@property (assign, nonatomic) BOOL isRightMenuShow;

@end

@implementation FMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.innerViewWidth = 50;
    self.vwCategoryContainer.dataSource = self;
    self.vwCategoryContainer.delegate = self;
    [self.vwCategoryContainer setInnerViewSize:CGSizeMake(self.innerViewWidth, self.vwCategoryContainer.frame.size.height)];
    [self.vwCategoryContainer initStackView];
    
    self.innerViewHeight = 50;
    self.vwItemContainer.dataSource = self;
    self.vwItemContainer.delegate = self;
    [self.vwItemContainer setInnerViewSize:CGSizeMake(self.vwItemContainer.frame.size.width, self.innerViewHeight)];
    [self.vwItemContainer initStackView];
    
    self.orginalMainMenuHeight = self.vwMainContainer.frame.size.height;
    self.orginalItemHeight  = self.vwItemContainer.frame.size.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onMenuClicked:(id)sender {
    [self.view layoutIfNeeded];
    self.isLeftMenuShow =! self.isLeftMenuShow;

    if(self.isLeftMenuShow) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.vwMainContainer setHidden:!self.isLeftMenuShow];
            self.cMainContainerHeight.constant = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.cMainContainerHeight.constant = self.orginalMainMenuHeight;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.vwMainContainer setHidden:!self.isLeftMenuShow];
            }];
        }];
    }
}

- (IBAction)onAffectClicked:(id)sender {
}

#pragma mark - HorizonalScrollableStackViewDelegate
- (NSInteger)numberOfRows:(BasicScrollableStackView*)stackView {
    if(stackView == self.vwCategoryContainer)
        return 3;
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
        InnerView * subView = [[InnerView alloc] initWithFrame:CGRectMake(0, 0, stackView.frame.size.width, self.innerViewHeight)];
        subView.layer.borderColor = [UIColor whiteColor].CGColor;
        subView.layer.borderWidth = 0.5;
        subView.backgroundColor = [UIColor clearColor];
        
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

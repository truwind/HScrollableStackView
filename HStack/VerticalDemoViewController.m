//
//  VerticalDemoViewController.m
//  HStack
//
//  Created by truwind on 2017. 9. 11..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "VerticalDemoViewController.h"
#import "VerticalScrollableStackView.h"

@interface VerticalDemoViewController ()<ScrollableStackViewDelegate, ScrollableStackViewDataSource>

@property (weak, nonatomic) IBOutlet VerticalScrollableStackView *vwMenuContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cBottomOfMenuView;
@property (assign, nonatomic) BOOL isShow;
@property (assign, nonatomic) CGFloat scrollViewHeight;

@end

@implementation VerticalDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isShow = YES;
    
    self.vwMenuContainer.dataSource = self;
    self.vwMenuContainer.delegate = self;
    [self.vwMenuContainer initStackView];
    
    self.scrollViewHeight = self.vwMenuContainer.frame.size.height;
    
    [self onShowMenuClicked:nil]
    ;
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
- (IBAction)onShowMenuClicked:(id)sender {
    [self.view layoutIfNeeded];
    self.isShow =! self.isShow;
    [UIView animateWithDuration:0.25 animations:^{
        if(self.isShow) {
            [self.vwMenuContainer setHidden:!self.isShow];
            self.cBottomOfMenuView.constant = 0;
        } else {
            self.cBottomOfMenuView.constant = self.scrollViewHeight;
        }
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(!self.isShow)
            [self.vwMenuContainer setHidden:!self.isShow];
    }];
}


#pragma mark - HorizonalScrollableStackViewDelegate
- (NSInteger)numberOfRows:(BasicScrollableStackView*)stackView {
    return 10;
}

- (UIView *)stackView:(BasicScrollableStackView*)stackView cellForRowAtIndex:(NSInteger)index{
    
    UIView * subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, stackView.frame.size.width, 50)];
    subView.backgroundColor = [UIColor lightGrayColor];
    subView.layer.borderColor = [UIColor redColor].CGColor;
    subView.layer.borderWidth = 0.5;
    return subView;
}

#pragma mark - ScrollableStackViewDataSource
- (void)stackView:(BasicScrollableStackView*)stackView didSelectRowAtIndex:(NSInteger)index {
    
}

- (void)stackView:(BasicScrollableStackView*)stackView didDeSelectRowAtIndex:(NSInteger)index {
    
}

@end

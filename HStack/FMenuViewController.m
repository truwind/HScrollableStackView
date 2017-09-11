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
@property (weak, nonatomic) IBOutlet HorizonalScrollableStackView *vwCategoryContainer;
@property (weak, nonatomic) IBOutlet VerticalScrollableStackView *vwItemContainer;

@end

@implementation FMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.vwCategoryContainer.dataSource = self;
    self.vwCategoryContainer.delegate = self;
    [self.vwCategoryContainer initStackView];
    
    self.vwItemContainer.dataSource = self;
    self.vwItemContainer.delegate = self;
    [self.vwItemContainer initStackView];


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
        WVerticalProgressView * subView = [[WVerticalProgressView alloc] initWithFrame:CGRectMake(0, 0, 50, stackView.frame.size.height)];
        subView.backgroundColor = [UIColor lightGrayColor];
        [subView setProgress:0.0];
        return subView;
    } else {
        UIView * subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, stackView.frame.size.width, 50)];
        subView.backgroundColor = [UIColor lightGrayColor];
        subView.layer.borderColor = [UIColor redColor].CGColor;
        subView.layer.borderWidth = 0.5;
        return subView;
    }
}

#pragma mark - ScrollableStackViewDataSource
- (void)stackView:(BasicScrollableStackView*)stackView didSelectRowAtIndex:(NSInteger)index {
    if(stackView == self.vwCategoryContainer){
        NSLog(@"필터 카테고리 선택 : %ld", index);
    } else {
        NSLog(@"Item 카테고리 선택 : %ld", index);
    }
}

- (void)stackView:(BasicScrollableStackView*)stackView didDeSelectRowAtIndex:(NSInteger)index {
    if(stackView == self.vwCategoryContainer){
        NSLog(@"필터 카테고리 선택 해제: %ld", index);
    } else {
        NSLog(@"Item 카테고리 선택 해제: %ld", index);
    }
}

@end

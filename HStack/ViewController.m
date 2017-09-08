//
//  ViewController.m
//  HStack
//
//  Created by truwind on 2017. 9. 6..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "ViewController.h"
#import "HorizonalScrollableStackView.h"
#import "HStack-Swift.h"

@interface ViewController () <HorizonalScrollableStackViewDelegate, HorizonalScrollableStackViewDataSource>


@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) NSLayoutConstraint * layoutEqualWidht;
@property (assign, nonatomic) CGFloat widthOfInnerView;
@property (weak, nonatomic) IBOutlet HorizonalScrollableStackView *hScrollStack;
@property (weak, nonatomic) IBOutlet UIView *vwBack2;


@property (assign, nonatomic) CGFloat progress;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.widthOfInnerView = 50;
    self.backView.backgroundColor = [UIColor lightGrayColor];
    self.hScrollStack.layer.borderWidth = 1.0;
    self.hScrollStack.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.hScrollStack.dataSource = self;
    self.hScrollStack.delegate = self;
    [self.hScrollStack initStackView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.widthOfInnerView = 30;
//    for(int i=0; i< 6; i++)
//        [self createRandomView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickedAddEntry:(id)sender {
    self.progress += 0.1;
    if(self.progress > 1.0) self.progress = 0.1;
    
    
}

- (void) createScrollableStackView {
    HorizonalScrollableStackView * stackView = [[HorizonalScrollableStackView alloc] initWithFrame:CGRectMake(10,
                                                                                                              50,
                                                                                                              [UIScreen mainScreen].bounds.size.width - 50,
                                                                                                              self.hScrollStack.frame.size.height) innerWidth:self.widthOfInnerView];
    
    stackView.dataSource = self;
    stackView.delegate = self;
    [self.vwBack2 addSubview:stackView];
}

- (IBAction)slideValueChanged:(id)sender {
    UISlider * slide = (UISlider *)sender;
    NSInteger numberOfSubViews = [self.hScrollStack getNumberOfSubViews];
    for(NSInteger index =0; index < numberOfSubViews; index++){
        WVerticalProgressView * subView = [self.hScrollStack getSubViewWithIndex:index];
        [subView setProgress:slide.value];
    }
}

#pragma mark - HorizonalScrollableStackViewDelegate
- (NSInteger)numberOfRows:(HorizonalScrollableStackView*)stackView {
    return 10;
}

- (WVerticalProgressView *)stackView:(HorizonalScrollableStackView*)stackView cellForRowAtIndex:(NSInteger)index{
    
    WVerticalProgressView * subView = [[WVerticalProgressView alloc] initWithFrame:CGRectMake(0, 0, self.widthOfInnerView, stackView.frame.size.height)];
//    UIColor *randomColor = [UIColor colorWithRed:(CGFloat)drand48() green:(CGFloat)drand48() blue:(CGFloat)drand48() alpha:1.0];
//    subView.backgroundColor = randomColor;
    subView.backgroundColor = [UIColor lightGrayColor];
    [subView setProgress:0.0];
    return subView;
}

#pragma mark - HorizonalScrollableStackViewDataSource
- (void)stackView:(HorizonalScrollableStackView*)stackView didSelectRowAtIndex:(NSInteger)index {
    
}

- (void)stackView:(HorizonalScrollableStackView*)stackView didDeSelectRowAtIndex:(NSInteger)index {
    
}


@end

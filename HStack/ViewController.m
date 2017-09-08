//
//  ViewController.m
//  HStack
//
//  Created by truwind on 2017. 9. 6..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "ViewController.h"
#import "HorizonalScrollableStackView.h"


@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) NSLayoutConstraint * layoutEqualWidht;
@property (assign, nonatomic) CGFloat widthOfInnerView;
@property (weak, nonatomic) IBOutlet HorizonalScrollableStackView *hScrollStack;
@property (weak, nonatomic) IBOutlet UIView *vwBack2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.widthOfInnerView = 50;
    self.backView.backgroundColor = [UIColor lightGrayColor];
    self.hScrollStack.layer.borderWidth = 1.0;
    self.hScrollStack.layer.borderColor = [UIColor darkGrayColor].CGColor;
#if 0
 
#endif
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
    [self createScrollableStackView];
}

- (void) createScrollableStackView {
    HorizonalScrollableStackView * stackView = [[HorizonalScrollableStackView alloc] initWithFrame:CGRectMake(10,
                                                                                                              50,
                                                                                                              [UIScreen mainScreen].bounds.size.width - 50,
                                                                                                              self.hScrollStack.frame.size.height) innerWidth:self.widthOfInnerView];
    
    [self.vwBack2 addSubview:stackView];
}


@end

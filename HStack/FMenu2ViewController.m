//
//  FMenu2ViewController.m
//  HStack
//
//  Created by truwind on 2017. 9. 12..
//  Copyright © 2017년 truwind. All rights reserved.
//

#import "FMenu2ViewController.h"
#import "FilterSelectMenu.h"
#import "AffectSelectMenu.h"

@interface FMenu2ViewController ()
@property (weak, nonatomic) IBOutlet UIView *vwMainContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cMainContainerHeight;
@property (strong, nonatomic) FilterSelectMenu * filterSelectMenuView;

@property (assign, nonatomic) BOOL isLeftMenuShow;
@property (assign, nonatomic) BOOL isRightMenuShow;

@property (assign, nonatomic) CGFloat orginalMainMenuHeight;

/// Affect Menu view
@property (weak, nonatomic) IBOutlet UIView *vwAffectContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cAffectContainerBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cAffectContainerLeading;
@property (strong, nonatomic) AffectSelectMenu * affectSelectMenuView;
@property (assign, nonatomic) CGFloat orginalAffectMenuHeight;
@property (assign, nonatomic) CGFloat orginalAffectMenuWidht;

@end

@implementation FMenu2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initFilterSelectView];
    [self hiddenMenu];

}

- (void) initFilterSelectView {
    self.filterSelectMenuView = [[[NSBundle mainBundle] loadNibNamed:@"FilterSelectMenu" owner:self options:nil] lastObject];
    [self.vwMainContainer addSubview:self.filterSelectMenuView];
    [self.vwMainContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[filterSelectMenuView]-0-|" options:0 metrics:nil views:@{@"filterSelectMenuView":self.filterSelectMenuView}]];
    [self.vwMainContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[filterSelectMenuView]-0-|" options:0 metrics:nil views:@{@"filterSelectMenuView":self.filterSelectMenuView}]];
    
    CGRect frame = self.filterSelectMenuView.frame;
    frame.size.height = self.vwMainContainer.frame.size.height;
    self.filterSelectMenuView.frame = frame;
    [self.filterSelectMenuView initialzie];
    self.orginalMainMenuHeight = self.vwMainContainer.frame.size.height;
    NSLog(@"self.vwMainContainer : %@", NSStringFromCGRect(self.vwMainContainer.frame));
    NSLog(@"self.filterSelectMenuView : %@", NSStringFromCGRect(self.filterSelectMenuView.frame));
}

- (void) initAffectSelectView {
    self.affectSelectMenuView = [[[NSBundle mainBundle] loadNibNamed:@"AffectSelectMenu" owner:self options:nil] lastObject];
    [self.vwAffectContainer addSubview:self.affectSelectMenuView];
    [self.vwAffectContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[affectSelectMenuView]-0-|" options:0 metrics:nil views:@{@"affectSelectMenuView":self.affectSelectMenuView}]];
    [self.vwAffectContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[affectSelectMenuView]-0-|" options:0 metrics:nil views:@{@"affectSelectMenuView":self.affectSelectMenuView}]];
    
    CGRect frame = self.affectSelectMenuView.frame;
    frame.size.height = self.vwAffectContainer.frame.size.height;
    self.affectSelectMenuView.frame = frame;
    [self.affectSelectMenuView initialzie];
    self.orginalAffectMenuWidht = self.vwAffectContainer.frame.size.width;
    self.orginalAffectMenuHeight = self.vwAffectContainer.frame.size.height;
    NSLog(@"self.vwMainContainer : %@", NSStringFromCGRect(self.vwAffectContainer.frame));
    NSLog(@"self.filterSelectMenuView : %@", NSStringFromCGRect(self.affectSelectMenuView.frame));
    
    self.affectSelectMenuView.backgroundColor = [UIColor clearColor];
    self.vwAffectContainer.backgroundColor = [UIColor clearColor];
}

- (void)hiddenMenu{
    self.isLeftMenuShow = NO;
    [self.vwMainContainer setHidden:YES];
    
    [self initAffectSelectView];
    self.isRightMenuShow = NO;
    [self.vwAffectContainer setHidden:YES];
    
    self.cMainContainerHeight.constant = self.orginalMainMenuHeight;
    self.cAffectContainerBottom.constant = self.orginalAffectMenuHeight;
    [self.view layoutIfNeeded];
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
    if(self.isRightMenuShow)
        [self onAffectClicked:nil];
    
    self.isLeftMenuShow =! self.isLeftMenuShow;
    [self showMenu:self.isLeftMenuShow];
}

- (IBAction)onAffectClicked:(id)sender {
    if(self.isLeftMenuShow)
        [self onMenuClicked:nil];

    self.isRightMenuShow =! self.isRightMenuShow;
    [self showRightMenu:self.isRightMenuShow];
}

- (void)showMenu:(BOOL)isShow {
    [self.view layoutIfNeeded];
    if(isShow) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.vwMainContainer setHidden:!isShow];
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
                [self.vwMainContainer setHidden:!isShow];
            }];
        }];
    }
}

- (void)showRightMenu:(BOOL)isShow {
    [self.view layoutIfNeeded];
#if 1
    if(isShow) {
        [UIView animateWithDuration:0.15 animations:^{
            [self.vwAffectContainer setHidden:!isShow];
            self.cAffectContainerLeading.constant = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.cAffectContainerBottom.constant = 0;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
            }];
        }];
    } else {
        [UIView animateWithDuration:0.15 animations:^{
            self.cAffectContainerBottom.constant = self.orginalAffectMenuHeight;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.cAffectContainerLeading.constant = self.orginalAffectMenuWidht;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    [self.vwAffectContainer setHidden:!isShow];
                }];
            }];
        }];
    }
    
#else

    if(isShow) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.vwAffectContainer setHidden:!isShow];
            self.cAffectContainerBottom.constant = 0;
            self.cAffectContainerLeading.constant = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.cAffectContainerBottom.constant = self.orginalAffectMenuHeight;
            self.cAffectContainerLeading.constant = self.orginalAffectMenuWidht;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.vwAffectContainer setHidden:!isShow];
            }];
        }];
    }

#endif
}
@end

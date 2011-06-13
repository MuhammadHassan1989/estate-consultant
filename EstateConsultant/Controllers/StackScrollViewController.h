//
//  StackScrollViewController.h
//  EstateConsultant
//
//  Created by farthinker on 5/28/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StackScrollViewController : UIViewController {
    NSMutableArray *_viewControllers;
    NSInteger _basePosition;
    UIViewController *_keyViewController;
    
    CGFloat _lastTransition;
    Boolean _panFlag;
}

@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, assign) NSInteger basePosition;
@property (nonatomic, assign) UIViewController *keyViewController;

- (void)pushViewController:(UIViewController *)viewController;
- (void)showViewAtIndex:(NSInteger)index;
- (void)expandViewWithSteps:(NSUInteger)step completion:(void (^)(void))completion;
- (void)collapseViewWithSteps:(NSUInteger)step completion:(void (^)(void))completion;
- (Boolean)isPositionStable;

@end


@interface StackScrollView : UIView {

}
@end

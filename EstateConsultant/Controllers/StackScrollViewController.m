//
//  StackScrollViewController.m
//  EstateConsultant
//
//  Created by farthinker on 5/28/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StackScrollViewController.h"

const float ANIMATION_STEP_DURATION = 0.2;


@implementation StackScrollViewController

@synthesize viewControllers = _viewControllers;
@synthesize basePosition = _basePosition;
@synthesize keyViewController = _keyViewController;

- (id)init
{
    self = [super init];
    if (self) {
        self.basePosition = 220;
        
        NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
        self.viewControllers = viewControllers;
        [viewControllers release];
    }
    return self;
}

- (void)dealloc
{
    [_viewControllers release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    StackScrollView *view = [[StackScrollView alloc] initWithFrame:frame];
    self.view = view;
    [view release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panGesture setMaximumNumberOfTouches:1];
    //[panGesture setDelaysTouchesBegan:TRUE];
    //[panGesture setDelaysTouchesEnded:TRUE];
    [panGesture setCancelsTouchesInView:TRUE];
    [self.view addGestureRecognizer:panGesture];
    [panGesture release];
    
    self.view.backgroundColor = [UIColor clearColor];
}


- (void)viewDidUnload
{
    [self setViewControllers:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark - event handlers

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:self.view];
    CGPoint velocity = [panGesture velocityInView:self.view];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        _lastTransition = 0;
        _panFlag = NO;
    }
    
    CGFloat increasment = (translation.x - _lastTransition) * 0.8;
    NSInteger keyIndex = [self.viewControllers indexOfObject:self.keyViewController];
    NSInteger startIndex = -1;
    if (velocity.x < 0) {
        CGFloat keyPosition = CGRectGetMinX(self.keyViewController.view.frame);
        if (keyPosition > 0) {
            startIndex = keyIndex;
        } else {
            if (keyIndex < self.viewControllers.count - 1) {
                startIndex = keyIndex + 1;
            } else {
                startIndex = keyIndex;
            }
        }
        
        UIViewController *startController = [self.viewControllers objectAtIndex:startIndex];
        CGFloat startPoisition = CGRectGetMinX(startController.view.frame);
        if (startPoisition + increasment < 0) {
            increasment = 0 - startPoisition;
            self.keyViewController = startController;
            _panFlag = YES;
        } else if ((startIndex == 0 && startPoisition < self.basePosition / 2)
                   || (startIndex > keyIndex && startPoisition < CGRectGetMidX(self.keyViewController.view.frame))) {
            _panFlag = NO;
        }
    } else if (velocity.x > 0) {
        if (keyIndex >= self.viewControllers.count - 1) {
            startIndex = keyIndex;
            if (keyIndex > 0) {
                self.keyViewController = [self.viewControllers objectAtIndex:keyIndex - 1];
            }
        } else {
            UIViewController *secondController = [self.viewControllers objectAtIndex:keyIndex + 1];
            CGFloat secondPosition = CGRectGetMinX(secondController.view.frame);
            CGFloat keyEndPosition = CGRectGetMaxX(self.keyViewController.view.frame);
            if (keyEndPosition - secondPosition > 0.5) {
                startIndex = keyIndex + 1;
                if (secondPosition + increasment > keyEndPosition) {
                    increasment = keyEndPosition - secondPosition;
                    _panFlag = YES;
                } else if (secondPosition > CGRectGetMidX(self.keyViewController.view.frame)) {
                    _panFlag = NO;
                }
            } else {
                startIndex = keyIndex;
                if (keyIndex > 0) {
                    self.keyViewController = [self.viewControllers objectAtIndex:keyIndex - 1];
                }
            } 
        }
    }
    
    if (startIndex >= 0) {
        for (int i = startIndex; i < self.viewControllers.count; i++) {
            UIView *view = [[self.viewControllers objectAtIndex:i] view];
            CGRect frame = view.frame;
            frame.origin.x = CGRectGetMinX(frame) + increasment;
            view.frame = frame;
        }        
    }

    if (panGesture.state == UIGestureRecognizerStateEnded) {        
        if ([self isPositionStable]) {
            if (velocity.x <= 0) {
                if (_panFlag) {
                    [self expandViewWithSteps:1 completion:nil];
                } else {
                    [self collapseViewWithSteps:1 completion:nil];                
                }
            } else if (velocity.x > 0) {
                if (_panFlag) {
                    [self collapseViewWithSteps:1 completion:nil];
                } else {
                    [self expandViewWithSteps:1 completion:nil];
                }
            }
        }
    }
    
    _lastTransition = translation.x;
}


#pragma mark - instance methods

- (void)pushViewController:(UIViewController *)viewController
{
    UIViewController *lastViewController = (UIViewController *)[self.viewControllers lastObject];
    CGRect frame = viewController.view.frame;
    if (lastViewController != nil) {
        frame.origin.x = CGRectGetMaxX(lastViewController.view.frame);
    } else {
        frame.origin.x = self.basePosition;
        self.keyViewController = viewController;
    }
    frame.origin.y = 0;
    frame.size.height = CGRectGetHeight(self.view.frame);

    [viewController.view setFrame:frame];
    [self.view addSubview:viewController.view];
    [self.viewControllers addObject:viewController];
    [self showViewAtIndex:self.viewControllers.count - 1];
}

- (void)showViewAtIndex:(NSInteger)indexToShow
{
    UIViewController *viewController = [self.viewControllers objectAtIndex:indexToShow];
    NSInteger keyIndex = [self.viewControllers indexOfObject:self.keyViewController];
    
    if (indexToShow == keyIndex) {
        if (keyIndex >= self.viewControllers.count - 1) {
            return;
        }
        
        UIView *secondView = [[self.viewControllers objectAtIndex:keyIndex + 1] view];
        if (CGRectGetMinX(secondView.frame) < CGRectGetMaxX(self.keyViewController.view.frame)) {
            [self expandViewWithSteps:1 completion:^{
                [self showViewAtIndex:indexToShow];
            }];
        } else {
            return;
        }
    } else if (indexToShow < keyIndex) {
        [self expandViewWithSteps:1 completion:^{
            [self showViewAtIndex:indexToShow];
        }];
    } else if(CGRectGetMaxX(viewController.view.frame) > CGRectGetWidth(self.view.frame)) {
        [self collapseViewWithSteps:1 completion:^{
            [self showViewAtIndex:indexToShow];
        }];
    }
}

- (void)expandViewWithSteps:(NSUInteger)step completion:(void (^)(void))completion
{
    if (step > 1) {
        for (int i = 1; i <= step; i++) {
            if (i == step) {
                [self expandViewWithSteps:1 completion:completion];
            } else {
                [self expandViewWithSteps:1 completion:nil];            
            }
        }
    }
    
    if (completion == nil) {
        completion = ^{};
    }
    
    NSInteger keyIndex = [self.viewControllers indexOfObject:self.keyViewController];
    CGFloat keyPosition = CGRectGetMinX(self.keyViewController.view.frame); 
    CGFloat containerWidth = CGRectGetWidth(self.view.frame);
    NSInteger startIndex;
    __block CGFloat position;
    UIViewController *viewControllerToExpand;
    
    if (keyIndex < self.viewControllers.count - 1) {
        UIView *secondView = [[self.viewControllers objectAtIndex:keyIndex + 1] view];
        UIView *lastView = [[self.viewControllers lastObject] view];
        CGFloat secondPosition = CGRectGetMinX(secondView.frame);
        CGFloat lastEndPosition = CGRectGetMaxX(lastView.frame);
        CGFloat keyEndPosition = CGRectGetMaxX(self.keyViewController.view.frame);
        if (keyEndPosition - secondPosition > 0.5) {
            if (lastEndPosition < containerWidth && keyEndPosition + lastEndPosition - secondPosition > containerWidth) {
                position = containerWidth - (lastEndPosition - secondPosition);
            } else {
                position = keyEndPosition;
            }
            startIndex = keyIndex + 1;
            viewControllerToExpand = self.keyViewController;
        } else if (keyIndex > 0) {
            startIndex = keyIndex;
            viewControllerToExpand = [self.viewControllers objectAtIndex:keyIndex - 1];
            position = CGRectGetMaxX(viewControllerToExpand.view.frame);
        } else {
            startIndex = keyIndex;
            viewControllerToExpand = self.keyViewController;
            position = self.basePosition;
        }
    } else if (keyIndex > 0) {
        startIndex = keyIndex;
        viewControllerToExpand = [self.viewControllers objectAtIndex:keyIndex - 1];
        
        CGFloat keyWidth = CGRectGetWidth(self.keyViewController.view.frame);
        if (CGRectGetMaxX(viewControllerToExpand.view.frame) + keyWidth > containerWidth) {
            position = containerWidth - keyWidth;
        } else {
            position = CGRectGetMaxX(viewControllerToExpand.view.frame);
        }
    } else if (keyPosition < self.basePosition) {
        startIndex = keyIndex;
        viewControllerToExpand = self.keyViewController;
        position = self.basePosition;
    } else {
        completion();
        return;
    }
    
    [UIView animateWithDuration:ANIMATION_STEP_DURATION
                          delay:0
                        options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         for (int i = startIndex; i < self.viewControllers.count; i++) {
                             UIView *view = [[self.viewControllers objectAtIndex:i] view];
                             CGRect frame = view.frame;
                             frame.origin.x = position;
                             view.frame = frame;
                             position += CGRectGetWidth(frame);
                         }
                     }
                     completion:^(BOOL finished){
                         self.keyViewController = viewControllerToExpand;
                         completion();
                     }];
}

- (void)collapseViewWithSteps:(NSUInteger)step completion:(void (^)(void))completion
{
    if (step > 1) {
        for (int i = 1; i <= step; i++) {
            if (i == step) {
                [self collapseViewWithSteps:1 completion:completion];
            } else {
                [self collapseViewWithSteps:1 completion:nil];            
            }
        }
    }
    
    if (completion == nil) {
        completion = ^{};
    }
    
    NSInteger keyIndex = [self.viewControllers indexOfObject:self.keyViewController];
    CGFloat keyPosition = CGRectGetMinX(self.keyViewController.view.frame);
    UIViewController *lastViewController = [self.viewControllers lastObject];
    CGFloat rightEndPosition = CGRectGetMaxX(lastViewController.view.frame);
    CGFloat containerWidth = CGRectGetWidth(self.view.frame);
    UIViewController *newKeyController = self.keyViewController;
    NSInteger startIndex;
    __block CGFloat position;
    
    if (keyPosition == 0) {
        if (keyIndex >= self.viewControllers.count - 1) {
            completion();
            return;
        } else {
            startIndex = keyIndex + 1;
            UIViewController *secondViewController = [self.viewControllers objectAtIndex:keyIndex + 1];
            if (rightEndPosition - CGRectGetMinX(secondViewController.view.frame) <= containerWidth) {
                position = containerWidth - (rightEndPosition - CGRectGetMinX(secondViewController.view.frame));
            } else {
                position = keyPosition;
                newKeyController = secondViewController;
            }
        }
    } else if (keyPosition > self.basePosition) {
        startIndex = keyIndex;
        position = self.basePosition;
    } else {
        if (rightEndPosition - keyPosition > containerWidth - self.basePosition) {
            startIndex = keyIndex;
            position = 0;
        } else {
            startIndex = keyIndex;
            position = self.basePosition;
        }
    }
    
    [UIView animateWithDuration:ANIMATION_STEP_DURATION
                          delay:0
                        options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         for (int i = startIndex; i < self.viewControllers.count; i++) {
                             UIView *view = [[self.viewControllers objectAtIndex:i] view];
                             CGRect frame = view.frame;
                             frame.origin.x = position;
                             view.frame = frame;
                             position += CGRectGetWidth(frame);
                         }
                     }
                     completion:^(BOOL finished) {
                         self.keyViewController = newKeyController;
                         completion();
                     }];
    
}

- (Boolean)isPositionStable
{
    NSInteger keyIndex = [self.viewControllers indexOfObject:self.keyViewController];
    CGFloat keyPosition = CGRectGetMinX(self.keyViewController.view.frame);
    UIView *lastView = [[self.viewControllers lastObject] view];
    
    UIView *secondView = nil;
    if (keyIndex < self.viewControllers.count - 1) {
        secondView = [[self.viewControllers objectAtIndex:keyIndex + 1] view];
    }
    
    if (keyIndex == 0) {
        if (keyPosition > self.basePosition) {
            [self collapseViewWithSteps:1 completion:^{
                [self isPositionStable];
            }];
            return NO;
        } else if (keyPosition < self.basePosition 
                   && (CGRectGetMaxX(lastView.frame) < CGRectGetWidth(self.view.frame) - self.basePosition)) {
            [self expandViewWithSteps:1 completion:^{
                [self isPositionStable];
            }];
            return NO;
        }
    }
        
    if ((CGRectGetMaxX(lastView.frame) < CGRectGetWidth(self.view.frame))
        && ((secondView != nil && CGRectGetMinX(secondView.frame) < CGRectGetMaxX(self.keyViewController.view.frame))
            || keyIndex > 0)) {
        [self expandViewWithSteps:1 completion:^{
            [self isPositionStable];
        }];
        return NO;
    }
    
    return YES;
}

@end


@implementation StackScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

@end


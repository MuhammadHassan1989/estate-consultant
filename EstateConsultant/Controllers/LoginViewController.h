//
//  LoginViewController.h
//  EstateConsultant
//
//  Created by farthinker on 6/30/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController {
    UIImageView *_logoView;
    UIView *_loginBox;
    UITextField *_emailField;
    UITextField *_passwordField;
    UIButton *_tryButton;
}

@property (nonatomic, retain) IBOutlet UIImageView *logoView;
@property (nonatomic, retain) IBOutlet UIView *loginBox;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UIButton *tryButton;

- (IBAction)tryDemo:(id)sender;


@end

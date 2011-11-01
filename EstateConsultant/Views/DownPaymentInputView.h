//
//  DownPaymentInputView.h
//  EstateConsultant
//
//  Created by farthinker on 5/25/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DownPaymentInputView : UIView {
    UITextField *_textfield;
    NSInteger _totalPrice;
}

@property (nonatomic, assign) UITextField *textfield;
@property (nonatomic, assign) NSInteger totalPrice;

- (IBAction)numberTapped:(UIButton *)sender;
- (IBAction)deleteTapped:(id)sender;
- (IBAction)clearTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;
- (IBAction)downPaymentTapped:(UIButton *)sender;

@end

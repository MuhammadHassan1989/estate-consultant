//
//  DiscountInputView.h
//  EstateConsultant
//
//  Created by farthinker on 6/27/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiscountInputView : UIView {
    UITextField *_textfield;
    NSInteger _totalPrice;
}

@property (nonatomic, retain) UITextField *textfield;
@property (nonatomic, assign) NSInteger totalPrice;

- (IBAction)numberTapped:(UIButton *)sender;
- (IBAction)deleteTapped:(id)sender;
- (IBAction)clearTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;
- (IBAction)discountTapped:(UIButton *)sender;

@end

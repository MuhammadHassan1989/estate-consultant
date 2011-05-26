//
//  NumberInputView.h
//  EstateConsultant
//
//  Created by farthinker on 5/25/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NumberInputView : UIView {
    UITextField *_textfield;
}

@property (nonatomic, retain) UITextField *textfield;

- (IBAction)numberTapped:(UIButton *)sender;
- (IBAction)deleteTapped:(id)sender;
- (IBAction)clearTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;


@end

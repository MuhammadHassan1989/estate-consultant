//
//  NumberInputView.m
//  EstateConsultant
//
//  Created by farthinker on 5/25/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "NumberInputView.h"


@implementation NumberInputView

@synthesize textfield = _textfield;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)dealloc
{
    [_textfield release];
    [super dealloc];
}

- (IBAction)numberTapped:(UIButton *)sender {
    NSString *number = sender.titleLabel.text;
    NSRange range = NSMakeRange([self.textfield.text length], 0);
    if (self.textfield.delegate && 
        [self.textfield.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] &&
        ![self.textfield.delegate textField:self.textfield shouldChangeCharactersInRange:range replacementString:number]) {
        return;
    }
    
    self.textfield.text = [self.textfield.text stringByReplacingCharactersInRange:range withString:number];
    
}

- (IBAction)deleteTapped:(id)sender {
    NSInteger length = [self.textfield.text length];
    if (length < 1) {
        return;
    }
    
    NSRange range = NSMakeRange(length - 1, 1);
    if (self.textfield.delegate && 
        [self.textfield.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] &&
        ![self.textfield.delegate textField:self.textfield shouldChangeCharactersInRange:range replacementString:@""]) {
        return;
    }
    
    self.textfield.text = [self.textfield.text stringByReplacingCharactersInRange:range withString:@""];
}

- (IBAction)clearTapped:(id)sender {
    if (self.textfield.delegate && 
        [self.textfield.delegate respondsToSelector:@selector(textFieldShouldClear:)] &&
        ![self.textfield.delegate textFieldShouldClear:self.textfield]) {
        return;
    }
    self.textfield.text = @"";
}

- (IBAction)doneTapped:(id)sender {
    if (self.textfield.delegate && 
        [self.textfield.delegate respondsToSelector:@selector(textFieldShouldReturn:)] &&
        ![self.textfield.delegate textFieldShouldReturn:self.textfield]) {
        return;
    }
}

@end

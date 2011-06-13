//
//  SingleSelectControl.m
//  EstateConsultant
//
//  Created by farthinker on 6/5/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "SingleSelectControl.h"


@implementation SingleSelectControl

@synthesize items = _items;
@synthesize selectedIndex = _selectedIndex;
@synthesize defaultBackground = _defaultBackground;
@synthesize selectedBackground = _selectedBackground;
@synthesize buttonGap = _buttonGap;
@synthesize delegate = _delegate;
@synthesize titleFont = _titleFont;
@synthesize titleColor = _titleColor;
@synthesize titleShadowColor = _titleShadowColor;
@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize selectedTitleShadowColor = _selectedTitleShadowColor;
@synthesize titleShadowOffset = _titleShadowOffset;
@synthesize selectedTitleShadowOffset = _selectedTitleShadowOffset;
@synthesize contentEdgeInsets = _contentEdgeInsets;
@synthesize selectedContentEdgeInsets = _selectedContentEdgeInsets;

- (void)customInit
{
    self.buttonGap = 10;
    self.selectedIndex = -1;
    
    UIImage *defaultBackground = [UIImage imageNamed:@"single-select-button.png"];
    UIImage *selectedBackground = [UIImage imageNamed:@"single-select-button-selected.png"];
    self.defaultBackground = [defaultBackground stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    self.selectedBackground = [selectedBackground stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    self.titleColor = [UIColor blackColor];
    self.titleShadowColor = [UIColor colorWithWhite:0 alpha:1.0];
    self.selectedTitleColor = [UIColor colorWithWhite:0.35 alpha:1.0];
    self.selectedTitleShadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.titleShadowOffset = CGSizeMake(0, 0);
    self.selectedTitleShadowOffset = CGSizeMake(0, 0);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.selectedContentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _buttons = [[NSMutableArray alloc] init];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
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
    [_items release];
    [_defaultBackground release];
    [_selectedBackground release];
    [_buttons release];
    [_titleFont release];
    [_titleColor release];
    [_titleShadowColor release];
    [_selectedTitleColor release];
    [_selectedTitleShadowColor release];
    [super dealloc];
}

- (void)setItems:(NSArray *)items
{
    if (items == _items) {
        return;
    }
    
    [_buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_buttons removeAllObjects];
    
    NSInteger index = 0;
    for (id item in items) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonWidth = (CGRectGetWidth(self.frame) - self.buttonGap * (items.count - 1)) / items.count;
        button.frame = CGRectMake(index * (buttonWidth + self.buttonGap), 0, buttonWidth, CGRectGetHeight(self.frame));
        
        if ([item isKindOfClass:[NSString class]]) {
            [button setTitle:item forState:UIControlStateNormal];
        } else if ([item isKindOfClass:[UIImage class]]) {
            [button setImage:item forState:UIControlStateNormal];
        } else {
            [button setTitle:@"" forState:UIControlStateNormal];
        }
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleShadowColor:self.titleShadowColor forState:UIControlStateNormal];
        [button setContentEdgeInsets:self.contentEdgeInsets];
        [button.titleLabel setShadowOffset:self.titleShadowOffset];
        [button setBackgroundImage:self.defaultBackground forState:UIControlStateNormal];
        [button setAdjustsImageWhenDisabled:NO];
        [button setAdjustsImageWhenHighlighted:NO];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchDown];
        
        if ([self.delegate respondsToSelector:@selector(singleSelect:willDisplayButton:)]) {
            [self.delegate singleSelect:self willDisplayButton:button];
        }
        
        [self addSubview:button];
        [_buttons addObject:button];
        
        index++;
    }
    
    [_items release];
    _items = [items retain];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex == _selectedIndex) {
        return;
    }
    
    NSInteger index = 0;
    for (UIButton *button in _buttons) {
        if (index == selectedIndex) {
            [button setBackgroundImage:self.selectedBackground forState:UIControlStateNormal];
            [button setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
            [button setTitleShadowColor:self.selectedTitleShadowColor forState:UIControlStateNormal];
            [button.titleLabel setShadowOffset:self.selectedTitleShadowOffset];
            [button setContentEdgeInsets:self.selectedContentEdgeInsets];
        } else {
            [button setBackgroundImage:self.defaultBackground forState:UIControlStateNormal];
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            [button setTitleShadowColor:self.titleShadowColor forState:UIControlStateNormal];
            [button.titleLabel setShadowOffset:self.titleShadowOffset];
            [button setContentEdgeInsets:self.contentEdgeInsets];
        }
        index++;
    }
    
    _selectedIndex = selectedIndex;
}

- (void)selectButton:(UIButton *)sender
{
    NSInteger index = [_buttons indexOfObject:sender];
    if (index > -1 && index != self.selectedIndex) {
        self.selectedIndex = index;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end

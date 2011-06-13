//
//  SingleSelectControl.h
//  EstateConsultant
//
//  Created by farthinker on 6/5/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleSelectControl;


@protocol SingleSelectControlDelegate <NSObject>
@optional
- (void)singleSelect:(SingleSelectControl *)singleSelectControl willDisplayButton:(UIButton *)button;
@end


@interface SingleSelectControl : UIControl {
    NSArray *_items;
    UIImage *_defaultBackground;
    UIImage *_selectedBackground;
    NSUInteger _selectedIndex;
    NSUInteger _buttonGap;
    NSMutableArray *_buttons;
    id<SingleSelectControlDelegate> _delegate;
    UIFont *_titleFont;
    UIColor *_titleColor;
    UIColor *_titleShadowColor;
    UIColor *_selectedTitleColor;
    UIColor *_selectedTitleShadowColor;
    CGSize _titleShadowOffset;
    CGSize _selectedTitleShadowOffset;
    UIEdgeInsets _contentEdgeInsets;
    UIEdgeInsets _selectedContentEdgeInsets;
}

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) UIImage *defaultBackground;
@property (nonatomic, retain) UIImage *selectedBackground;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *selectedTitleColor;
@property (nonatomic, retain) UIColor *titleShadowColor;
@property (nonatomic, retain) UIColor *selectedTitleShadowColor;
@property (nonatomic, assign) CGSize titleShadowOffset;
@property (nonatomic, assign) CGSize selectedTitleShadowOffset;
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets selectedContentEdgeInsets;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) NSUInteger buttonGap;
@property (nonatomic, assign) IBOutlet id<SingleSelectControlDelegate> delegate;

- (void)customInit;

@end

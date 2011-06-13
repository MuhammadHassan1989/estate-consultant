//
//  HouseItemView.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@interface HouseItemView : UIView {
    House *_house;
    UILabel *_floorLabel;
    UILabel *_statusLabel;
    UILabel *_numberLabel;
    UILabel *_priceLabel;
    UILabel *_totalPriceLabel;
    UILabel *_followLabel;
    UIImageView *_backgroundImage;
}

@property (nonatomic, retain) House *house;
@property (nonatomic, retain) IBOutlet UILabel *floorLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *followLabel;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;

- (IBAction)showCalculator:(id)sender;

@end

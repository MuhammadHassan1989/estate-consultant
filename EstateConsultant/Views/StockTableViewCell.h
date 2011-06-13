//
//  StockTableViewCell.h
//  EstateConsultant
//
//  Created by farthinker on 5/18/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface StockTableViewCell : UITableViewCell {
    House *_house;
    UILabel *_floorLabel;
    UILabel *_numberLabel;
    UILabel *_priceLabel;
    UILabel *_totalPriceLabel;
    UILabel *_statusLabel;
    UILabel *_followLabel;
}

@property (nonatomic, retain) House *house;
@property (nonatomic, retain) IBOutlet UILabel *floorLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UILabel *followLabel;

- (IBAction)showCalculator:(id)sender;

@end

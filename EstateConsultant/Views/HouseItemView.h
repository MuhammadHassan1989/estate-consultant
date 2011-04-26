//
//  HouseItemView.h
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface HouseItemView : UIView {
}

@property (nonatomic, retain) House *house;
@property (nonatomic, retain) IBOutlet UILabel *floorLabel;
@property (nonatomic, retain) IBOutlet UILabel *numLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

@end

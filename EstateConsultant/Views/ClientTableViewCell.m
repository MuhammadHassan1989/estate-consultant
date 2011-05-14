//
//  ClientTableViewCell.m
//  EstateConsultant
//
//  Created by farthinker on 5/2/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientTableViewCell.h"


@implementation ClientTableViewCell

@synthesize starView = _starView;
@synthesize nameLabel = _nameLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize client = _client;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.nameLabel.highlighted = selected;
    self.phoneLabel.highlighted = selected;
    self.starView.highlighted = selected;
}

- (void)setClient:(Client *)client
{
    if (_client == client) {
        return;
    }
    
    NSString *imagePath;
    if (client.starred) {
        imagePath = [[NSBundle mainBundle] pathForResource:@"star-on.png" ofType:nil];
    } else {
        imagePath = [[NSBundle mainBundle] pathForResource:@"star.png" ofType:nil];
    }
    
    UIImage *starImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    [self.starView setImage:starImage];
    [starImage release];
    
    if (client.sex.intValue == 0) {
        self.nameLabel.text = [client.name stringByAppendingString:@" 女士"];
    } else if (client.sex.intValue == 1) {
        self.nameLabel.text = [client.name stringByAppendingString:@" 先生"];        
    }
    
    self.phoneLabel.text = client.phone;
    
    [self setNeedsDisplay];
    [_client release];
    _client = [client retain];
}

- (void)dealloc
{
    [_starView release];
    [_nameLabel release];
    [_phoneLabel release];
    [_client release];
    [super dealloc];
}

@end

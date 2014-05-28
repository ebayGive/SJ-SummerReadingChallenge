//
//  PrizesFooterView.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/20/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "PrizesFooterView.h"
#import "PrizeType.h"

@interface PrizesFooterView ()

@property PrizeType *prizeType;

@property (weak, nonatomic) IBOutlet UIButton *prize1;
@property (weak, nonatomic) IBOutlet UIButton *prize2;
@property (weak, nonatomic) IBOutlet UIButton *prize3;
@property (weak, nonatomic) IBOutlet UIButton *prize4;
@property (weak, nonatomic) IBOutlet UIButton *prize5;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation PrizesFooterView

-(void)setupViewWithPrizeType:(PrizeType *)prizeType
{
    self.prizeType = prizeType;
    self.title.text = @"Prizes";
    [self.prize1 setBackgroundImage:[UIImage imageNamed:@"PRIZES_1_0"] forState:UIControlStateNormal];
    [self.prize2 setBackgroundImage:[UIImage imageNamed:@"PRIZES_2_0"] forState:UIControlStateNormal];
    [self.prize3 setBackgroundImage:[UIImage imageNamed:@"PRIZES_3_0"] forState:UIControlStateNormal];
    [self.prize4 setBackgroundImage:[UIImage imageNamed:@"PRIZES_4_0"] forState:UIControlStateNormal];
    [self.prize5 setBackgroundImage:[UIImage imageNamed:@"PRIZES_5_0"] forState:UIControlStateNormal];
}

- (IBAction)prizeButtonClicked:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        default:
            break;
    }
}


@end

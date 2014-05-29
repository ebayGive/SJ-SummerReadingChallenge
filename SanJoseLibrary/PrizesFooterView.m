//
//  PrizesFooterView.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/20/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "PrizesFooterView.h"
#import "PrizeType.h"
#import "Prize.h"
#import "Utillities.h"

@interface PrizesFooterView ()

@property PrizeType *prizeType;
@property NSArray *userPrizes;

@property (weak, nonatomic) IBOutlet UIButton *prize1;
@property (weak, nonatomic) IBOutlet UIButton *prize2;
@property (weak, nonatomic) IBOutlet UIButton *prize3;
@property (weak, nonatomic) IBOutlet UIButton *prize4;
@property (weak, nonatomic) IBOutlet UIButton *prize5;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation PrizesFooterView

-(void)setupViewWithPrizeType:(PrizeType *)prizeType userPrizeStatus:(NSArray *)userPrizes
{
    self.userPrizes = userPrizes;
    self.prizeType = prizeType;
    self.title.text = @"Prizes";
    
    Prize *p = [self.userPrizes objectAtIndex:0];
    NSString *imgName = [NSString stringWithFormat:@"PRIZES_1_%d",p.state];
    [self.prize1 setBackgroundImage:[UIImage imageNamed:imgName]
                           forState:UIControlStateNormal];
    
    p = [self.userPrizes objectAtIndex:1];
    imgName = [NSString stringWithFormat:@"PRIZES_2_%d",p.state];
    [self.prize2 setBackgroundImage:[UIImage imageNamed:imgName]
                           forState:UIControlStateNormal];
    
    p = [self.userPrizes objectAtIndex:2];
    imgName = [NSString stringWithFormat:@"PRIZES_3_%d",p.state];
    [self.prize3 setBackgroundImage:[UIImage imageNamed:imgName]
                           forState:UIControlStateNormal];
    
    p = [self.userPrizes objectAtIndex:3];
    imgName = [NSString stringWithFormat:@"PRIZES_4_%d",p.state];
    [self.prize4 setBackgroundImage:[UIImage imageNamed:imgName]
                           forState:UIControlStateNormal];
    
    p = [self.userPrizes objectAtIndex:5];
    imgName = [NSString stringWithFormat:@"PRIZES_5_%d",p.state];
    [self.prize5 setBackgroundImage:[UIImage imageNamed:imgName]
                           forState:UIControlStateNormal];
}

- (IBAction)prizeButtonClicked:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1:
            [self showActivityDescription:self.prizeType.prize1];
            break;
        case 2:
            [self showActivityDescription:self.prizeType.prize2];
            break;
        case 3:
            [self showActivityDescription:self.prizeType.prize3];
            break;
        case 4:
            [self showActivityDescription:self.prizeType.prize4];
            break;
        case 5:
            [self showActivityDescription:self.prizeType.prize5];
            break;
        default:
            break;
    }
}

- (void)showActivityDescription:(NSString *)prizeText
{
    NSString *msg = [NSString stringWithFormat:@"Complete 5 squares in a row to win '%@'",prizeText];
    UIAlertView *alert = [Utillities alertViewWithTitle:@"Prize"
                                   message:msg
                                  delegate:self
                         cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.tag = 1;
    [alert show];
}

@end

//
//  GridActivityViewController.m
//  SanJoseLibrary
//
//  Created by Himanshu Tantia on 5/9/14.
//  Copyright (c) 2014 Himanshu Tantia. All rights reserved.
//

#import "ActivityViewController.h"
#import "ContainerViewController.h"

#define IndexActivityGrid 0
#define IndexReadingLog 1
#define IndexInformation 2

#define SegueIdentifierActivityGrid @"ActivityGridViewController"
#define SegueIdentifierReadingLog @"ReadingLogViewController"
#define SegueIdentifierInformation @"InformationViewController"

@interface ActivityViewController ()

@property (weak, nonatomic) ContainerViewController *containerViewController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *swapViewsSegment;

@end

@implementation ActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)updateView:(UISegmentedControl *)sender {
    [self.containerViewController swapSegueWithIdentifier:[self segueIdentifierForCurrentView:sender.selectedSegmentIndex]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ContainerViewController"]) {
        self.containerViewController = segue.destinationViewController;
        [self.containerViewController setCurrentUser:self.currentUser];
    }
}

- (NSString *)segueIdentifierForCurrentView:(NSInteger)index
{
    NSString *identifier = nil;
    switch (index) {
        case IndexActivityGrid:
            identifier = SegueIdentifierActivityGrid;
            break;

        case IndexReadingLog:
            identifier = SegueIdentifierReadingLog;
            break;

        case IndexInformation:
            identifier = SegueIdentifierInformation;
            break;
    }
    return identifier;
}

@end
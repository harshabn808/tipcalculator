//
//  SettingsViewController.m
//  Tip Calculator
//
//  Created by Harsha Badami Nagaraj on 6/5/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "SettingsViewController.h"


@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (atomic, copy) NSArray *tipArray;

- (IBAction)onSave:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        float defaultTip = [defaults floatForKey:@"defaultTip"];
        if (!defaultTip) {
            [defaults setFloat:0.1 forKey:@"defaultTip"];
        }
        self.tipArray = @[@"0.10", @"0.15", @"0.20"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Settings";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float defaultTip = [defaults floatForKey:@"defaultTip"];
    
    int arrayIndex = [self.tipArray indexOfObject:[NSString stringWithFormat:@"%0.2f", defaultTip]];
    
    self.defaultTipControl.selectedSegmentIndex = arrayIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSave:(id)sender {
    float defaultTipValue = [self.tipArray[self.defaultTipControl.selectedSegmentIndex] floatValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setFloat:defaultTipValue forKey:@"defaultTip"];
}
@end

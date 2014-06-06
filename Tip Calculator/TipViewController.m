//
//  TipViewController.m
//  Tip Calculator
//
//  Created by Harsha Badami Nagaraj on 6/4/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentField;
@property (atomic, copy) NSArray *tipArray;


- (IBAction)onTap:(id)sender;
- (IBAction)onBillAmountChange:(id)sender;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    self.tipArray = @[@"0.10", @"0.15", @"0.20"];
    
    [self setDefaultTipPercentage];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self setDefaultTipPercentage];
}

- (void)setDefaultTipPercentage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float defaultTip = [defaults floatForKey:@"defaultTip"];
    
    NSString *value = [NSString stringWithFormat:@"%0.2f", defaultTip];
    int arrayIndex = [self.tipArray indexOfObject:value];
    
    self.tipControl.selectedSegmentIndex = arrayIndex;
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onBillAmountChange:(id)sender {
    [self updateValues];
}


- (void)updateValues {
    float billValue = [self.billField.text floatValue];
    float tipAmount = [self.tipArray[self.tipControl.selectedSegmentIndex] floatValue] * billValue;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%s%0.2f", "$", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%s%0.2f", "$", tipAmount + billValue];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end

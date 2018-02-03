//
//  PMBirthViewController.m
//  KVCAndKVOTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "PMBirthViewController.h"

@interface PMBirthViewController ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation PMBirthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat: @"dd MMMM yyyy"];
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleDone target: self action: @selector(actionBirthDone:)];
    
    [self.navigationItem setRightBarButtonItem: buttonDone];
    
    if (![self.date isEqualToString:@""]) {
        
        NSDate *date = [self.dateFormatter dateFromString: self.date];
        [self.datePiker setDate: date];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionBirthDone: (UIBarButtonItem *) sender {
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) actionValueChanged: (UIDatePicker *) sender {
    
    NSString *itemToPassBack = [self.dateFormatter stringFromDate: sender.date];
    [self.delegate birthViewController: self didChangeDatePiker: itemToPassBack];
}

@end

//
//  ViewController.m
//  KVCAndKVOTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "ViewController.h"
#import "PMStudent.h"
#import "PMBirthViewController.h"

@interface ViewController () <PMBirthViewControllerDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIPopoverPresentationController *popover;

@property (strong, nonatomic) PMStudent *student;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PMStudent *student = [PMStudent randomStudent];
    
    self.firstNameField.text = student.firstName;
    self.lastNameField.text = student.lastName;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"dd MMMM yyyy"];
    
    self.birthField.text = [dateFormatter stringFromDate: student.dateOfBirthday];

    if (student.gender == PMGenderFemale) {
        self.genderControl.selectedSegmentIndex = PMGenderFemale;
    } else {
        self.genderControl.selectedSegmentIndex = PMGenderMale;
    }
    
    self.gradeField.text = [NSString stringWithFormat:@"%f", student.grade];
    
    self.student = student;

    [self.firstNameField becomeFirstResponder];
    
    [self.student addObserver: self forKeyPath: @"firstName" options: NSKeyValueObservingOptionNew context: nil];
    [self.student addObserver: self forKeyPath: @"lastName" options: NSKeyValueObservingOptionNew context: nil];
    [self.student addObserver: self forKeyPath: @"dateOfBirthday" options: NSKeyValueObservingOptionNew context: nil];
    [self.student addObserver: self forKeyPath: @"gender" options: NSKeyValueObservingOptionNew context: nil];
    [self.student addObserver: self forKeyPath: @"grade" options: NSKeyValueObservingOptionNew context: nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Observing

- (void) observeValueForKeyPath: (NSString *) keyPath ofObject: (id) object change: (NSDictionary *) change context: (void *) context {
    
     if ([keyPath isEqualToString: @"firstName"]) {
         NSLog(@"New firstName: %@", [change objectForKey: NSKeyValueChangeNewKey]);
     } else if ([keyPath isEqualToString: @"lastName"]) {
         NSLog(@"New lastName: %@", [change objectForKey: NSKeyValueChangeNewKey]);
     } else if ([keyPath isEqualToString: @"dateOfBirthday"]) {
         NSLog(@"New dateOfBirthday: %@", [change objectForKey: NSKeyValueChangeNewKey]);
     } else if ([keyPath isEqualToString: @"gender"]) {
         NSLog(@"New gender: %@", [change objectForKey: NSKeyValueChangeNewKey]);
     } else if ([keyPath isEqualToString: @"grade"]) {
         NSLog(@"New grade: %@", [change objectForKey: NSKeyValueChangeNewKey]);
     } else {
         [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
     }

}

#pragma mark - Actions

- (IBAction) actionGenderChanged: (UISegmentedControl *) sender {
    
    self.student.gender = (PMGender)sender.selectedSegmentIndex;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual: self.firstNameField] || [textField isEqual: self.lastNameField] ) {
        NSCharacterSet *validationSet = [[NSCharacterSet letterCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet: validationSet];
        
        if ([components count] > 1) {
            return NO;
        } else {
            return YES;
        }
    } else if([textField isEqual: self.gradeField]) {
        NSCharacterSet *validationSet = [[NSCharacterSet characterSetWithCharactersInString: @"0123456789."] invertedSet];
        
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            validationSet = [[NSCharacterSet characterSetWithCharactersInString: @"0123456789"] invertedSet];
        }
        
        NSArray *components = [string componentsSeparatedByCharactersInSet: validationSet];
        
        if ([components count] > 1) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (void) textFieldDidEndEditing: (UITextField *) textField {
    
    if ([textField isEqual: self.firstNameField]) {
        self.student.firstName = textField.text;
    } else if ([textField isEqual: self.lastNameField]) {
        self.student.lastName = textField.text;
    } else if ([textField isEqual: self.gradeField]) {
        self.student.grade = [textField.text floatValue];
    }
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField {

    
    if ([textField isEqual: self.firstNameField]) {
        [self.lastNameField becomeFirstResponder];
    } else if ([textField isEqual: self.lastNameField]) {
        [self.gradeField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL) textFieldShouldBeginEditing: (UITextField *) textField {
    
    if ([textField isEqual: self.birthField]) {
        
        PMBirthViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier: @"PMBirthViewController"];
        vc.delegate = self;
        
        // init popover
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: vc];
        
        vc.preferredContentSize = CGSizeMake(400, 200);
        nav.modalPresentationStyle = UIModalPresentationPopover;
        self.popover = nav.popoverPresentationController;
        self.popover.delegate = self;
        self.popover.sourceView = self.view;
        
        self.popover.sourceRect = CGRectMake(textField.frame.origin.x, textField.frame.origin.y + 140, CGRectGetWidth(textField.frame), CGRectGetHeight(textField.frame));
        
        if (textField.text) {
            vc.date = textField.text;
        }
        
        [self presentViewController: nav animated: YES completion: nil];
        
        return NO;
        
    } else {
        
        return YES;
    }
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (void) popoverPresentationControllerDidDismissPopover: (UIPopoverPresentationController *) popoverPresentationController {
    
    self.popover = nil;
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController *) controller {
    
    return UIModalPresentationNone;
}

#pragma mark - PMBirthViewControllerDelegate

- (void) birthViewController: (PMBirthViewController *) controller didChangeDatePiker: (NSString *) itemDate {
    
    self.birthField.text = itemDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"dd MMMM yyyy"];
    
    self.student.dateOfBirthday = [dateFormatter dateFromString: itemDate];
}


@end

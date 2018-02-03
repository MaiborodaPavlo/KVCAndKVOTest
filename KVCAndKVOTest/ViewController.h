//
//  ViewController.h
//  KVCAndKVOTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *birthField;
@property (weak, nonatomic) IBOutlet UITextField *gradeField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;

- (IBAction)actionGenderChanged:(UISegmentedControl *)sender;

@end


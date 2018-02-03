//
//  PMBirthViewController.h
//  KVCAndKVOTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMBirthViewController;

@protocol PMBirthViewControllerDelegate <NSObject>

- (void) birthViewController: (PMBirthViewController *) controller didChangeDatePiker: (NSString *) item;

@end

@interface PMBirthViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePiker;
@property (weak, nonatomic) id <PMBirthViewControllerDelegate> delegate;

@property (strong, nonatomic) NSString *date;

- (IBAction) actionValueChanged: (UIDatePicker *) sender;

@end

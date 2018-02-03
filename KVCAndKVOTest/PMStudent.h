//
//  PMStudent.h
//  KVCAndKVOTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    PMGenderMale,
    PMGenderFemale
} PMGender;

@interface PMStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSDate *dateOfBirthday;
@property (assign, nonatomic) PMGender gender;
@property (assign, nonatomic) CGFloat grade;

+ (PMStudent *) randomStudent;

- (void) removeAllProperties;

@end

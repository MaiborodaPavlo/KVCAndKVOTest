//
//  PMStudent.m
//  KVCAndKVOTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "PMStudent.h"
#import "NSDate+RandomDate.h"

@implementation PMStudent

static NSString *firstManNames[] = {@"Абрам", @"Аваз", @"Августин", @"Авраам", @"Агап", @"Агапит", @"Агафон", @"Адам", @"Адриан", @"Азамат", @"Азат", @"Айдар", @"Айрат", @"Акакий", @"Аким", @"Алан", @"Александр", @"Алексей", @"Али", @"Алик", @"Алихан", @"Алмаз", @"Альберт", @"Амир", @"Амирам", @"Анар", @"Анастасий", @"Анатолий", @"Ангел", @"Андрей", @"Анзор", @"Антон", @"Анфим", @"Арам", @"Аристарх", @"Аркадий", @"Арман", @"Армен", @"Арсен", @"Арсений", @"Арслан", @"Артём", @"Артемий", @"Артур", @"Архип", @"Аскар", @"Асхан", @"Ахмет", @"Ашот", @"Сергей"};

static NSString *firstWomanNames[] = {@"Юнона", @"Ульяна", @"Лариса", @"Эмилия", @"Ника", @"Полина", @"Ефросинья", @"Изольда", @"Каролина", @"Алла", @"Виктория", @"Клара", @"Марта", @"Ксения", @"Лада", @"Дарья", @"Марфа", @"Алиса", @"Таисия", @"Елена", @"Доминика", @"Василиса", @"Лиана", @"Регина", @"Евдокия", @"Лидия", @"Светлана", @"Ярослава", @"Зинаида", @"Арина", @"Стела", @"Розалия", @"Валентина", @"Нина", @"Берта", @"Маргарита", @"Анфиса", @"Дина", @"Рада", @"Анисья", @"Надежда", @"Екатерина", @"Алина", @"Варвара", @"Эльвира", @"Римма", @"Ирина", @"Агния", @"Зоя", @"Софья"};

static NSString *lastManNames[] = {@"Абрамов", @"Авдеев", @"Агафонов", @"Аксёнов", @"Александров", @"Алексеев", @"Андреев", @"Анисимов", @"Антонов", @"Артемьев", @"Архипов", @"Афанасьев", @"Баранов", @"Белов", @"Белозёров", @"Белоусов", @"Беляев", @"Беляков", @"Беспалов", @"Бирюков", @"Блинов", @"Блохин", @"Бобров", @"Бобылёв", @"Богданов", @"Большаков", @"Борисов", @"Брагин", @"Буров", @"Быков", @"Васильев", @"Веселов", @"Виноградов", @"Вишняков", @"Владимиров", @"Власов", @"Волков", @"Воробьёв", @"Воронов", @"Воронцов", @"Гаврилов", @"Галкин", @"Герасимов", @"Голубев", @"Горбачёв", @"Горбунов", @"Гордеев", @"Горшков", @"Григорьев", @"Гришин"};

static NSString *lastWomanNames[] = {@"Салехова", @"Маланова", @"Завражина", @"Другакова", @"Луговая", @"Онегина", @"Ягофарова", @"Ельчукова", @"Усилова", @"Приказчикова", @"Корнейчук", @"Обухова", @"Бичурина", @"Пыжалова", @"Потрепалова", @"Ясырева", @"Зууфина", @"Бибикова", @"Ваенга", @"Яковкина", @"Радченко", @"Ярощука", @"Кирхенштейна", @"Ютилова", @"Кудяева", @"Антимонова", @"Герцая", @"Янкова", @"Семянина", @"Унтилова", @"Коротченко", @"Порсева", @"Салтанова", @"Коржукова", @"Мяукина", @"Маркина", @"Лапина", @"Елизарова", @"Углицкая", @"Деменок", @"Пономарёва", @"Бормотова", @"Кокорина", @"Сафошкина", @"Павленко", @"Чемерис", @"Гусарова", @"Цой", @"Уланова", @"Кудрова"};

static int namesCount = 50;


+ (PMStudent *) randomStudent {
    
    PMStudent *student = [[PMStudent alloc] init];
    
    student.dateOfBirthday = [[NSDate new] randomDateForStudent];
    
    student.gender = arc4random() % 2;
    
    if (student.gender == PMGenderFemale) {
        student.firstName = firstWomanNames[arc4random() % namesCount];
        student.lastName = lastWomanNames[arc4random() % namesCount];
        
    } else {
        student.firstName = firstManNames[arc4random() % namesCount];
        student.lastName = lastManNames[arc4random() % namesCount];
    }
    
    student.grade = (arc4random() % 401) / 100.f + 2;
    
    return student;
}

- (void) removeAllProperties {
    
    [self willChangeValueForKey: @"firstName"];
    _firstName = @"";
    [self didChangeValueForKey: @"firstName"];
    
    [self willChangeValueForKey: @"lastName"];
    _lastName = @"";
    [self didChangeValueForKey: @"lastName"];
    
    [self willChangeValueForKey: @"dateOfBirthday"];
    _dateOfBirthday = nil;
    [self didChangeValueForKey: @"dateOfBirthday"];
    
    [self willChangeValueForKey: @"gender"];
    _gender = 2;
    [self didChangeValueForKey: @"gender"];
    
    [self willChangeValueForKey: @"grade"];
    _grade = 0;
    [self didChangeValueForKey: @"grade"];
    
}

@end

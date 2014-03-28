//
//  DataManager.m
//  TestViewController
//
//  Created by Alexander on 20.03.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "DataManager.h"

@interface DataManager()
{
    NSInteger stopOperationCount;
}
@end

@implementation DataManager

+ (instancetype)sharedInstance
{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (void)getAsyncAvatarWithSender:(id)sender selector:(SEL)selector
{
    int startStopCount = stopOperationCount;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(startStopCount != stopOperationCount)
            return;
        
        [sender performSelector:selector withObject:[UIImage imageNamed:@"avatar"]];
    });
}

- (void)getAsyncInfoWithSender:(id)sender selector:(SEL)selector
{
    int startStopCount = stopOperationCount;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(startStopCount != stopOperationCount)
            return;
        
        NSDictionary *responce = @{@"name" : @"Alexandr Sidorov", @"status" : @"offline", @"city" : @"Kazan"};
        [sender performSelector:selector withObject:responce];
    });
}

- (void)getAsyncWallDataWithSender:(id)sender selector:(SEL)selector
{
    int startStopCount = stopOperationCount;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(startStopCount != stopOperationCount)
            return;
        
        NSArray *responce = @[@{@"sender" : @"Alex", @"sender_ava" : [UIImage imageNamed:@"ava1"], @"message" : @"Читаем, смотрим и просвещаемся) Читать конечно многовато, ни каждый смогёт, но стараемся. На крайний случай переходите на скролл-стайл) ну и клик-клик, лайки, хаски"},
                              @{@"sender" : @"Anna", @"sender_ava" : [UIImage imageNamed:@"ava2"], @"message" : @"Если бы у вас был выбор, написать веб-приложение или сходить на свидание, с чего бы вы начали его писать, с фронтенда или бэкенда?"},
                              @{@"sender" : @"Alex", @"sender_ava" : [UIImage imageNamed:@"ava1"], @"message" : @"Xабр упал. Пишут, что он под DDOS'ом ещё с ночи. Программисты, чем будем заниматься на работе?\nUPD: Хабр подняли, советуем убедиться самостоятельно."},
                              @{@"sender" : @"Alex Gray", @"sender_ava" : [UIImage imageNamed:@"ava3"], @"message" : @"Интересный факт:\nБлюда из гречки намного полезней, чем твой диплом о высшем образовании."},
                              @{@"sender" : @"Noname", @"sender_ava" : [UIImage imageNamed:@"ava4"], @"message" : @"Если я встал посреди ночи- значит меня ктото разбудил. Если меня ктото разбудил- значит дело срочное. Итак, кот, я слушаю тебя!"},
                              @{@"sender" : @"Noname", @"sender_ava" : [UIImage imageNamed:@"ava4"], @"message" : @"Ваш пароль должен содержать цифры, буквы, знаки пунктуации, завязку, развитие, кульминацию и неожиданный финал."}];
        
        [sender performSelector:selector withObject:responce];
    });
}

- (void)stopAsyncOperations
{
    stopOperationCount++;
}

@end

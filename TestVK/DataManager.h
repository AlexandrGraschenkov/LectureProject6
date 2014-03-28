//
//  DataManager.h
//  TestViewController
//
//  Created by Alexander on 20.03.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)sharedInstance;

/**
 Call selector with UIImage
 */
- (void)getAsyncAvatarWithSender:(id)sender selector:(SEL)selector;


/**
 Call selector with dictionary:
 @{@"name" : @"Alexandr Sidorov", @"status" : @"offline", @"city" : @"Kazan"}
 */
- (void)getAsyncInfoWithSender:(id)sender selector:(SEL)selector;

/**
 Call selector with array of dictionary:
 @{@"sender" : @"Anna", @"sender_ava" : UIImage, @"message" : @"..."}
 */
- (void)getAsyncWallDataWithSender:(id)sender selector:(SEL)selector;

- (void)stopAsyncOperations;

@end

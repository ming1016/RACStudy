//
//  SMCreditSubject.h
//  HomePageTest
//
//  Created by DaiMing on 16/5/27.
//

#import <Foundation/Foundation.h>

@interface SMCreditSubject : NSObject

typedef void(^SubscribeNextActionBlock)(NSUInteger credit);

+ (SMCreditSubject *)create;

- (SMCreditSubject *)sendNext:(NSUInteger)credit;
- (SMCreditSubject *)subscribeNext:(SubscribeNextActionBlock)block;

@end

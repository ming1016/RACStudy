//
//  SMStudent.h
//  HomePageTest
//
//  Created by DaiMing on 16/5/27.
//

#import <Foundation/Foundation.h>
#import "SMCreditSubject.h"

typedef NS_ENUM(NSUInteger, SMStudentGender) {
    SMStudentGenderMale,
    SMStudentGenderFemale
};

typedef BOOL(^SatisfyActionBlock)(NSUInteger credit);

@interface SMStudent : NSObject

@property (nonatomic, strong) SMCreditSubject *creditSubject;

@property (nonatomic, assign) BOOL isSatisfyCredit;

+ (SMStudent *)create;
- (SMStudent *)name:(NSString *)name;
- (SMStudent *)gender:(SMStudentGender)gender;
- (SMStudent *)studentNumber:(NSUInteger)number;

//积分相关
- (SMStudent *)sendCredit:(NSUInteger(^)(NSUInteger credit))updateCreditBlock;
- (SMStudent *)filterIsASatisfyCredit:(SatisfyActionBlock)satisfyBlock;

@end

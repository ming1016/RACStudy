//
//  SMCreditSubject.m
//  HomePageTest
//
//  Created by DaiMing on 16/5/27.
//

#import "SMCreditSubject.h"

@interface SMCreditSubject()

@property (nonatomic, assign) NSUInteger credit;
@property (nonatomic, strong) SubscribeNextActionBlock subscribeNextBlock;
@property (nonatomic, strong) NSMutableArray *blockArray;

@end

@implementation SMCreditSubject

+ (SMCreditSubject *)create {
    SMCreditSubject *subject = [[self alloc] init];
    return subject;
}

- (SMCreditSubject *)sendNext:(NSUInteger)credit {
    self.credit = credit;
    if (self.blockArray.count > 0) {
        for (SubscribeNextActionBlock block in self.blockArray) {
            block(self.credit);
        }
    }
    return self;
}

- (SMCreditSubject *)subscribeNext:(SubscribeNextActionBlock)block {
    if (block) {
        block(self.credit);
    }
    [self.blockArray addObject:block];
    return self;
}

#pragma mark - Getter
- (NSMutableArray *)blockArray {
    if (!_blockArray) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}

@end

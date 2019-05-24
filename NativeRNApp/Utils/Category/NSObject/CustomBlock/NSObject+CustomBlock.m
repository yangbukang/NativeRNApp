//
//  NSObject+WBCustomBlock.m
//  AppFrame
//
//  Created by Jingyuzhao on 2017/10/14.
//  Copyright © 2017年 Jingyuzhao. All rights reserved.
//

#import "NSObject+CustomBlock.h"
#import <objc/runtime.h>
@implementation NSObject (CustomBlock)
+(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block1();
        dispatch_async(dispatch_get_main_queue(),^{
            block2();
        });
    });
}
-(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block1();
        dispatch_async(dispatch_get_main_queue(),^{
            block2();
        });
    });
}

const char ObjectStoreKey;
-(void)setObject:(id)obj
{
    objc_setAssociatedObject(self, &ObjectStoreKey, obj, OBJC_ASSOCIATION_COPY);
}

-(id)getObject
{
    return objc_getAssociatedObject(self, &ObjectStoreKey);
}

const char ObjectDefaultEvent;
-(void)handlerDefaultEventwithBlock:(id)block
{
    objc_setAssociatedObject(self, &ObjectDefaultEvent, block, OBJC_ASSOCIATION_COPY);
}
-(id)blockForDefaultEvent
{
    return objc_getAssociatedObject(self,&ObjectDefaultEvent);
}
const char ObjectSingleObjectEvent;
-(void)receiveObject:(void(^)(id object))sendObject
{
    objc_setAssociatedObject(self,
                             &ObjectSingleObjectEvent,
                             sendObject,
                             OBJC_ASSOCIATION_RETAIN);
}
-(void)sendObject:(id)object
{
    void(^block)(id object) = objc_getAssociatedObject(self,&ObjectSingleObjectEvent);
    if(block != nil) block(object);
}


@end

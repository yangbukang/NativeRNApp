//
//  NSObject+CustomBlock.h
//  AppFrame
//
//  Created by Jingyuzhao on 2017/10/14.
//  Copyright © 2017年 Jingyuzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CustomBlock)
/**
 在block2异步执行完后，在主线程执行block1
 类方法
 @param block1 任务1
 @param block2 任务2
 */
+(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2;

/**
 在block2异步执行完后，在主线程执行block1
 实例方法
 @param block1 任务1
 @param block2 任务2
 */
-(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2;

//use Object to deliver param(copy)

/**
 增加一个默认属性，这个属性的值为obj
 
 @param obj ob
 */
-(void)setObject:(id)obj;

/**
 获取默认属性的值
 
 @return 属性值
 */
-(id)getObject;

/**
 给对象增加一个block回调
 
 @param block 回调事件
 */
-(void)handlerDefaultEventwithBlock:(id)block;
-(id)blockForDefaultEvent;


/**
 消息传递
 
 @param sendObject 接收消息
 */
-(void)receiveObject:(void(^)(id object))sendObject;

/**
 消息传递
 
 @param object 发送的消息
 */
-(void)sendObject:(id)object;


@end

//
//  ViewController.m
//  testGCD
//
//  Created by Wanlei on 2017/4/7.
//  Copyright © 2017年 organizer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(atomic ,strong) dispatch_queue_t queue;
@property(atomic, strong) dispatch_source_t source;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //移除timer测试的入口
//    [self testTimer];
    
    
}


- (void)testTimer
{
    NSLog(@"Start Timer: %@, Thread: %@", [NSDate date], [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    _queue = queue;
    
    _source = CreateDispatchTimer((int64_t)(5* NSEC_PER_SEC), 0, queue, ^{
        
        [self handler];
    });
}

- (void)handler
{
    NSLog(@"Timer executed: %@, Thread: %@", [NSDate date], [NSThread currentThread]);
}


dispatch_source_t CreateDispatchTimer(uint64_t interval,
                                      uint64_t leeway,
                                      dispatch_queue_t queue,
                                      dispatch_block_t block)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                                     0, 0, queue);
    
    
    if (timer)
    {
//        dispatch_time_t startTime = dispatch_walltime(NULL, 0);
        
        dispatch_time_t startTime = DISPATCH_TIME_NOW;
        
        
        dispatch_source_set_timer(timer, startTime, interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}


@end

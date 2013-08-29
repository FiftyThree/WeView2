//
//  DemoViewController.m
//  WeViews2DemoApp
//
//  Copyright (c) 2013 Charles Matthew Chen. All rights reserved.
//

#import "WeView2.h"
#import "DemoViewController.h"
#import "WeView2Macros.h"
#import "WeView2DemoConstants.h"

@interface DemoViewController ()

@property (nonatomic) WeView2 *rootView;
@property (nonatomic) UIView *resizeHandle;

@property (nonatomic) DemoModel *demoModel;
//@property (nonatomic) Demo *demo;
//@property (nonatomic) UIView *demoView;

@end

#pragma mark -

@implementation DemoViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleSelectionAltered:)
                                                     name:NOTIFICATION_SELECTION_ALTERED
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleSelectionAltered:(NSNotification *)notification {
    NSLog(@"tree handleSelectionAltered");
    [self.rootView setNeedsLayout];
//    self.currentView = notification.object;
//    //    [self updateState];
//    [self updateContent];
}

- (void)loadView
{
    self.rootView = [[[WeView2 alloc] init]
                     setVLinearLayout];
    self.rootView.margin = 40;
    self.rootView.opaque = YES;
    self.rootView.backgroundColor = [UIColor whiteColor];
    self.rootView.debugName = @"DemoViewController.rootView";
    self.view = self.rootView;

    [self.rootView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handlePan:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan ||
        sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint rootViewCenter = [self.rootView convertPoint:self.rootView.center
                                                    fromView:self.rootView.superview];
        CGPoint gesturePoint = [sender locationInView:self.rootView];
        CGPoint distance = CGPointAbs(CGPointSubtract(rootViewCenter, gesturePoint));

        [self.rootView setNoopLayout];
        self.demoModel.rootView.size = CGSizeRound(CGSizeMake(distance.x * 2.f,
                                                              distance.y * 2.f));
        [self.demoModel.rootView centerHorizontallyInSuperview];
        [self.demoModel.rootView centerVerticallyInSuperview];
        //        DebugRect(@"self.demoModel.rootView", self.demoModel.rootView.frame);
    }
}

- (void)displayDemo:(Demo *)demo
{
    [self.rootView removeAllSubviews];
    [self.rootView setHLinearLayout];
    self.demoModel = [demo demoModel];
    [self.rootView addSubviews:@[
     self.demoModel.rootView,
     ]];
}

- (void)viewWillLayoutSubviews
{
}

- (void)viewDidLayoutSubviews
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self.delegate demoViewChanged:self.rootView];
        //        [self.delegate demoViewChanged:self.demoModel.rootView];

        NSLog(@"viewDidLayoutSubviews: %@ %d",
              [self.demoModel.rootView debugName],
              [self.demoModel.rootView.subviews count]);
        [self.delegate demoModelChanged:self.demoModel];
    });
}

@end

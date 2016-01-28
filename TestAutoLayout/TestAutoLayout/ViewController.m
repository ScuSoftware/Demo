//
//  ViewController.m
//  TestAutoLayout
//
//  Created by zyma on 1/18/16.
//  Copyright © 2016 zyma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;

@property (strong, nonatomic) UIView *item1;
@property (strong, nonatomic) UIView *item2;
@property (strong, nonatomic) UIView *item3;

@property (strong, nonatomic) UIButton *button1;

@end

static const CGFloat view_padding = 30.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setLayout];
}

- (void)setLayout{
    _view1 = [[UIView alloc] init];
    _view2 = [[UIView alloc] init];
    
    _item1 = [[UIView alloc] init];
    _item2 = [[UIView alloc] init];
    _item3 = [[UIView alloc] init];
    
    _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button1 setTitle:@"按钮" forState:UIControlStateNormal];
    
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    
    [_view1 addSubview:_button1];
    
    [_view1 addSubview:_item1];
    [_view1 addSubview:_item2];
    [_view1 addSubview:_item3];
    
    [_view1 setBackgroundColor:[UIColor grayColor]];
    [_view2 setBackgroundColor:[UIColor purpleColor]];
    
    [_item1 setBackgroundColor:[UIColor yellowColor]];
    [_item2 setBackgroundColor:[UIColor redColor]];
    [_item3 setBackgroundColor:[UIColor blueColor]];
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_view1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_view2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_item1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_item2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_item3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSMutableArray *view_constraints = [NSMutableArray array];
    NSMutableArray *item1_constraints = [NSMutableArray array];
    NSMutableArray *item2_constraints = [NSMutableArray array];
    NSMutableArray *item3_constraints = [NSMutableArray array];
    
    [view_constraints addObjectsFromArray:
     @[
       //view1 constraint
       [NSLayoutConstraint constraintWithItem:_view1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:view_padding],
       [NSLayoutConstraint constraintWithItem:_view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-view_padding],
       [NSLayoutConstraint constraintWithItem:_view1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:view_padding],
       [NSLayoutConstraint constraintWithItem:_view1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-view_padding],
       
       //view2 constraint
       [NSLayoutConstraint constraintWithItem:_view2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:view_padding],
       [NSLayoutConstraint constraintWithItem:_view2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-view_padding*10],
       [NSLayoutConstraint constraintWithItem:_view2 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeLeading multiplier:1.0 constant:view_padding],
       [NSLayoutConstraint constraintWithItem:_view2 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-view_padding]
     ]];
    
    [self.view addConstraints:view_constraints];
    
    [item1_constraints addObjectsFromArray:
     @[
       //subview item constraint item1
       [NSLayoutConstraint constraintWithItem:_item1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:view_padding],
       [NSLayoutConstraint constraintWithItem:_item1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeWidth multiplier:1.0/3 constant:0],
       [NSLayoutConstraint constraintWithItem:_item1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0],
       [NSLayoutConstraint constraintWithItem:_item1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]
     ]];
    
    //"view1.attr1 = view2.attr2 * multiplier + constant"
    [item2_constraints addObjectsFromArray:
     @[
       //subview item constraint item2
       [NSLayoutConstraint constraintWithItem:_item2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_item1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0],
       [NSLayoutConstraint constraintWithItem:_item2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_item1 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
       [NSLayoutConstraint constraintWithItem:_item2 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_item1 attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0],
       [NSLayoutConstraint constraintWithItem:_item2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]
    ]];
    
    [item3_constraints addObjectsFromArray:
     @[
       //subview item constraint item1
       [NSLayoutConstraint constraintWithItem:_item3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:view_padding],
       [NSLayoutConstraint constraintWithItem:_item3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeWidth multiplier:1.0/3 constant:0],
       [NSLayoutConstraint constraintWithItem:_item3 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0],
       [NSLayoutConstraint constraintWithItem:_item3 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]
    ]];
    
    [self.view1 addConstraints:item1_constraints];
    [self.view1 addConstraints:item2_constraints];
    [self.view1 addConstraints:item3_constraints];
    
//    //Visual formate language
//    NSDictionary *planetsAndGuides = @{@"item1":_item1,
//                                       @"item2":_item2,
//                                       @"item3":_item3,
//                                       };
//    
//    [self.view1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[item1(==30)]"
//                                                                       options:0
//                                                                       metrics:0
//                                                                         views:planetsAndGuides]];
//    
    
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

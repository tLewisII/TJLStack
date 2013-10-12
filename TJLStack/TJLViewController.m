//
//  TJLViewController.m
//  TJLStack
//
//  Created by Terry Lewis II on 10/12/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TJLViewController.h"
#import "TJLStack.h"
@interface TJLViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TJLStack *stack;
@property (strong, nonatomic) NSArray *stackArray;
@end

@implementation TJLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
	self.stack = [TJLStack new];
    for(NSUInteger i = 0; i < 20; i ++) {
        [self.stack push:@(i)];
    }
    self.stackArray = [self.stack toArray];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stack.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.stackArray[indexPath.row]];
    
    return cell;
}
@end

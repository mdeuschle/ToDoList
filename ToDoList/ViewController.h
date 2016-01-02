//
//  ViewController.h
//  ToDoList
//
//  Created by Matt Deuschle on 1/1/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)onSwipe:(UISwipeGestureRecognizer *)sender;

// array for todo items
@property NSMutableArray *toDoArray;

@end


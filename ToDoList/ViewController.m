//
//  ViewController.m
//  ToDoList
//
//  Created by Matt Deuschle on 1/1/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // alloc and init array
    self.toDoArray = [NSMutableArray new];

    // add objects to array
    self.toDoArray = [NSMutableArray arrayWithObjects:
                      [NSString stringWithFormat:@"Eat Dinner"],
                      [NSString stringWithFormat:@"Wash Dishes"],
                      [NSString stringWithFormat:@"Clean Windows"],
                      [NSString stringWithFormat:@"Take Out Trash"], nil];

    // user can't edit when view loads
    self.editing = false;
}

-(void)addToDo
{
    // create alertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add To Do" message:nil preferredStyle:UIAlertControllerStyleAlert];

    // add text to alertController
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Add item";
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        // when add item is added
        UITextField *textField1 = alertController.textFields[0];
        [self.toDoArray addObject:textField1.text];
        [self.tableView reloadData];
    }];

    // add variables to alert controller
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];

    // present alertcontroller by calling method presentVC
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // create instance of cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    // display title in array of cell
    cell.textLabel.text = [self.toDoArray objectAtIndex:indexPath.row];
    return cell;
}

// give user ability to remove todo item
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // add "are you sure?" when user deletes item
    UIAlertController *delete = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.toDoArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];

    [self presentViewController:delete animated:true completion:nil];
    [delete addAction:deleteAction];
    [delete addAction:cancelAction];
    [self.tableView reloadData];
}

// awesome method lets user move rows in tableview
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //grab instance of title that was removed
    NSString *titlesItem  = [self.toDoArray objectAtIndex:sourceIndexPath.row];

    // remove item
    [self.toDoArray removeObject:titlesItem];

    // insert item
    [self.toDoArray insertObject:titlesItem atIndex:destinationIndexPath.row];

    // reload to refresh data
    [self.tableView reloadData];
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)editButton {

    // edit / done toggle
    if (self.editing) {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        editButton.style = UIBarButtonItemStylePlain;
        editButton.title = @"Edit";
    }
    else
    {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        editButton.style = UIBarButtonItemStyleDone;
        editButton.title = @"Done";
    }
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)addButton {
    [self addToDo];
}

- (IBAction)onSwipe:(UISwipeGestureRecognizer *)swipe {

    CGPoint point = [swipe locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    // change text color priority on swipe
    if (cell.textLabel.textColor == [UIColor blackColor]) {
        cell.textLabel.textColor = [UIColor greenColor];
    } else if (cell.textLabel.textColor == [UIColor greenColor]) {
        cell.textLabel.textColor = [UIColor yellowColor];
    } else if (cell.textLabel.textColor == [UIColor yellowColor]) {
        cell.textLabel.textColor = [UIColor redColor];
    } else if (cell.textLabel.textColor == [UIColor redColor]) {
        cell.textLabel.textColor = [UIColor blackColor];
    }
}

@end

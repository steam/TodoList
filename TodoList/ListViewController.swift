import UIKit

class ListViewController: UITableViewController, NewTodoDelegate {

    var items = ["Mow the lawn", "Get a haircut", "Take a nap"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        self.title = "gTodo"
        setupNavItems()
    }

    func setupNavItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editTableTapped:")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItemTapped:")
    }

    @IBAction func editTableTapped(AnyObject) {        
        tableView.setEditing(!tableView.editing, animated: true)
    }

    @IBAction func addItemTapped(AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navController: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("NewTodoViewController") as UINavigationController
        let todoController: NewTodoViewController =  navController.topViewController as NewTodoViewController
        todoController.delegate = self

        presentViewController(navController, animated: true, completion: nil)
    }

    func todoSaved(todo: String) {
        items.insert(todo, atIndex: 0)

        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Top)
        tableView.endUpdates()
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ListCell")

        cell.textLabel.text = items[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        switch editingStyle {
        case .Delete:
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        case .Insert, .None:
            println("Nothing to do")
        }
    }

    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!) {
        let toDo = items[sourceIndexPath.row]
        items.removeAtIndex(sourceIndexPath.row)
        items.insert(toDo, atIndex: destinationIndexPath.row)
    }
}
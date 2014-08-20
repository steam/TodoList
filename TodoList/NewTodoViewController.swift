import UIKit

protocol NewTodoDelegate {
    func todoSaved(todo:String)
}

class NewTodoViewController: UIViewController {

    @IBOutlet var input: UITextField!
    var delegate:NewTodoDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Todo"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelTapped:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveTapped:")
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        input.becomeFirstResponder()
    }

    @IBAction func cancelTapped(AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveTapped(AnyObject) {
        if let totoDelegate = delegate {
            delegate.todoSaved(input.text)
        }
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.delegate = nil
        })
    }
}
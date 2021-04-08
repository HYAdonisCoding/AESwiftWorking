// MIT license. Copyright (c) 2021 SwiftyFORM. All rights reserved.
import UIKit

open class FormViewController: UIViewController {
	public var dataSource: TableViewSectionArray?
	public var keyboardHandler: KeyboardHandler?
    private(set) public var tableViewStyle: FormTableViewStyle

    public init() {
        SwiftyFormLog("super init")
        self.tableViewStyle = .grouped
        super.init(nibName: nil, bundle: nil)
    }

    public init(style tableViewStyle: FormTableViewStyle) {
		SwiftyFormLog("super init")
        self.tableViewStyle = tableViewStyle
		super.init(nibName: nil, bundle: nil)
	}

	required public init?(coder aDecoder: NSCoder) {
		SwiftyFormLog("super init")
        self.tableViewStyle = .grouped
		super.init(coder: aDecoder)
	}

	override open func loadView() {
		SwiftyFormLog("super loadview")
		view = tableView
		keyboardHandler = KeyboardHandler(tableView: tableView)
		populateAndSetup()
	}

	open func populateAndSetup() {
		populate(formBuilder)
		title = formBuilder.navigationTitle
		dataSource = formBuilder.result(self)
		tableView.dataSource = dataSource
		tableView.delegate = dataSource
	}

	open func reloadForm() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.formBuilder.removeAll()
            DispatchQueue.main.async {
                self.populateAndSetup()
                self.tableView.reloadData()
            }
        }
	}

	open func populate(_ builder: FormBuilder) {
		SwiftyFormLog("subclass must implement populate()")
	}

	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		keyboardHandler?.addObservers()

		// Fade out, so that the user can see what row has been updated
		if let indexPath = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: indexPath, animated: true)
		}
	}

	override open func viewDidDisappear(_ animated: Bool) {
		self.keyboardHandler?.removeObservers()
		super.viewDidDisappear(animated)
	}

	public lazy var formBuilder: FormBuilder = FormBuilder()

	public lazy var tableView: FormTableView = FormTableView(style: tableViewStyle)
}

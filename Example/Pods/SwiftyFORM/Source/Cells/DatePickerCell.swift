// MIT license. Copyright (c) 2021 SwiftyFORM. All rights reserved.
import UIKit

struct DatePickerCellConstants {
	struct CellExpanded {
		static let height: CGFloat = 216
	}
}

public class DatePickerCellModel {
	var title: String = ""
	var datePickerMode: UIDatePicker.Mode = .dateAndTime
	var locale: Locale? // default is Locale.current, setting nil returns to default
	var minimumDate: Date? // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
	var maximumDate: Date? // default is nil
	var minuteInterval: Int = 1
	var date: Date = Date()
	var expandCollapseWhenSelectingRow = true
	var selectionStyle = UITableViewCell.SelectionStyle.default
    var titleFont = UIFont.preferredFont(forTextStyle: .body)
    var detailFont = UIFont.preferredFont(forTextStyle: .body)
    var titleTextColor = Colors.text
    var detailTextColor = Colors.secondaryText

	var valueDidChange: (Date) -> Void = { (date: Date) in
		SwiftyFormLog("date \(date)")
	}

	var resolvedLocale: Locale {
		return locale ?? Locale.current
	}
}

/**
# Date picker toggle-cell

### Tap this row to toggle

This causes the inline date picker to expand/collapse
*/
public class DatePickerToggleCell: UITableViewCell, SelectRowDelegate, DontCollapseWhenScrolling, AssignAppearance {
    
	weak var expandedCell: DatePickerExpandedCell?
	public let model: DatePickerCellModel

	public init(model: DatePickerCellModel) {
		/*
		Known problem: UIDatePickerModeCountDownTimer is buggy and therefore not supported
		
		UIDatePicker has a bug in it when used in UIDatePickerModeCountDownTimer mode. The picker does not fire the target-action
		associated with the UIControlEventValueChanged event the first time the user changes the value by scrolling the wheels.
		It works fine for subsequent changes.
		http://stackoverflow.com/questions/20181980/uidatepicker-bug-uicontroleventvaluechanged-after-hitting-minimum-internal
		http://stackoverflow.com/questions/19251803/objective-c-uidatepicker-uicontroleventvaluechanged-only-fired-on-second-select
		
		Possible work around: Continuously poll for changes.
		*/
		assert(model.datePickerMode != .countDownTimer, "CountDownTimer is not supported")

		self.model = model
		super.init(style: .value1, reuseIdentifier: nil)
		selectionStyle = model.selectionStyle
		textLabel?.text = model.title
        textLabel?.font = model.titleFont
        detailTextLabel?.font = model.detailFont
        
		updateValue()

		assignDefaultColors()
	}

	public required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

	public func obtainDateStyle(_ datePickerMode: UIDatePicker.Mode) -> DateFormatter.Style {
		switch datePickerMode {
		case .time:
			return .none
		case .date:
			return .long
		case .dateAndTime:
			return .short
		case .countDownTimer:
			return .none
        @unknown default:
            SwiftyFormLog("WARNING - unknown UIDatePicker.Mode '\(datePickerMode)', not displaying date")
            return .none
		}
	}

	public func obtainTimeStyle(_ datePickerMode: UIDatePicker.Mode) -> DateFormatter.Style {
		switch datePickerMode {
		case .time:
			return .short
		case .date:
			return .none
		case .dateAndTime:
			return .short
		case .countDownTimer:
			return .short
        @unknown default:
            SwiftyFormLog("WARNING - unknown UIDatePicker.Mode '\(datePickerMode)', not displaying time")
            return .none
		}
	}

	public var humanReadableValue: String {
		if model.datePickerMode == .countDownTimer {
			return "Unsupported"
		}
		let date = model.date
		//SwiftyFormLog("date: \(date)")
		let dateFormatter = DateFormatter()
		dateFormatter.locale = model.resolvedLocale
		dateFormatter.dateStyle = obtainDateStyle(model.datePickerMode)
		dateFormatter.timeStyle = obtainTimeStyle(model.datePickerMode)
		return dateFormatter.string(from: date)
	}

	public func updateValue() {
		detailTextLabel?.text = humanReadableValue
	}

	func setDateWithoutSync(_ date: Date, animated: Bool) {
		SwiftyFormLog("set date \(date), animated \(animated)")
		model.date = date
		updateValue()

		expandedCell?.datePicker.setDate(model.date, animated: animated)
	}

	public func form_cellHeight(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        60
	}

	public func form_didSelectRow(indexPath: IndexPath, tableView: UITableView) {
		if model.expandCollapseWhenSelectingRow == false {
			//print("cell is always expanded")
			return
		}

		if isExpandedCellVisible {
			_ = resignFirstResponder()
		} else {
			_ = becomeFirstResponder()
		}
		form_deselectRow()
	}

	// MARK: UIResponder

	public override var canBecomeFirstResponder: Bool {
		if model.expandCollapseWhenSelectingRow == false {
			return false
		}
		return true
	}

	public override func becomeFirstResponder() -> Bool {
		if !super.becomeFirstResponder() {
			return false
		}
		expand()
		return true
	}

	public override func resignFirstResponder() -> Bool {
		collapse()
		return super.resignFirstResponder()
	}

	// MARK: Expand collapse

	var isExpandedCellVisible: Bool {
		guard let sectionArray = form_tableView()?.dataSource as? TableViewSectionArray else {
			return false
		}
		guard let expandedItem = sectionArray.findItem(expandedCell) else {
			return false
		}
		if expandedItem.hidden {
			return false
		}
		return true
	}

	func toggleExpandCollapse() {
		guard let tableView = form_tableView() else {
			return
		}
		guard let sectionArray = tableView.dataSource as? TableViewSectionArray else {
			return
		}
		guard let expandedCell = expandedCell else {
			return
		}
		ToggleExpandCollapse.execute(
			toggleCell: self,
			expandedCell: expandedCell,
			tableView: tableView,
			sectionArray: sectionArray
		)
	}

	func expand() {
		if isExpandedCellVisible {
			assignTintColors()
		} else {
			toggleExpandCollapse()
		}
	}

	func collapse() {
		if isExpandedCellVisible {
			toggleExpandCollapse()
		}
	}

	// MARK: AssignAppearance

	public func assignDefaultColors() {
        textLabel?.textColor = model.titleTextColor
        detailTextLabel?.textColor = model.detailTextColor
	}

	public func assignTintColors() {
		textLabel?.textColor = tintColor
		detailTextLabel?.textColor = tintColor
	}
}

/**
# Date picker expanded-cell

Row containing only a `UIDatePicker`
*/
public class DatePickerExpandedCell: UITableViewCell, CellHeightProvider, WillDisplayCellDelegate, ExpandedCell {
	weak var collapsedCell: DatePickerToggleCell?

	public var toggleCell: UITableViewCell? {
        collapsedCell
	}

	public var isCollapsable: Bool {
        collapsedCell?.model.expandCollapseWhenSelectingRow ?? false
	}

	public func form_cellHeight(indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        DatePickerCellConstants.CellExpanded.height
	}

	public func form_willDisplay(tableView: UITableView, forRowAtIndexPath indexPath: IndexPath) {
		if let model = collapsedCell?.model {
			configure(model)
		}
	}

	lazy var datePicker: UIDatePicker = {
		let instance = UIDatePicker()
		instance.addTarget(self, action: #selector(DatePickerExpandedCell.valueChanged), for: .valueChanged)
		return instance
	}()

	func configure(_ model: DatePickerCellModel) {
		datePicker.datePickerMode = model.datePickerMode
		datePicker.minimumDate = model.minimumDate
		datePicker.maximumDate = model.maximumDate
		datePicker.minuteInterval = model.minuteInterval
		datePicker.locale = model.resolvedLocale
		datePicker.date = model.date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }

	@objc public func valueChanged() {
		guard let collapsedCell = collapsedCell else {
			return
		}
		let model = collapsedCell.model
		let date = datePicker.date
		model.date = date

		collapsedCell.updateValue()

		model.valueDidChange(date)
	}

	public init() {
		super.init(style: .default, reuseIdentifier: nil)
        contentView.addSubview(datePicker)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		datePicker.frame = bounds
	}
}

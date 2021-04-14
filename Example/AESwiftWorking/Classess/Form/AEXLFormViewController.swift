//
//  AEXLFormViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import XLForm

class AEXLFormViewController: XLFormViewController {

    var modelProerty = AETestModel()
    
    var struProerty = AETestStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        do {
            let arr = try modelProerty.allProperties()
            for (i, item) in arr.enumerated() {
                print("i-\(i) item--\(item)")
                modelProerty.setValue(item.key, forKey: item.key)
            }

        } catch _ {

        }

        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed(_:)))
        
    }
    
    fileprivate struct Tags {
        static let Push = "selectorPush"
        static let Popover = "selectorPopover"
        static let ActionSheet = "selectorActionSheet"
        static let AlertView = "selectorAlertView"
        static let PickerView = "selectorPickerView"
        static let Picker = "selectorPicker"
        static let PickerViewInline = "selectorPickerViewInline"
        static let MultipleSelector = "multipleSelector"
        static let MultipleSelectorPopover = "multipleSelectorPopover"
        static let DynamicSelectors = "dynamicSelectors"
        static let CustomSelectors = "customSelectors"
        static let SelectorWithSegueId = "selectorWithSegueId"
        static let SelectorWithSegueClass = "selectorWithSegueClass"
        static let SelectorWithNibName = "selectorWithNibName"
        static let SelectorWithStoryboardId = "selectorWithStoryboardId"
        
        static let TextView = "selectorTextView"

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
      }


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
      }

      func initializeForm() {
        // Implementation details covered in the next section.
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "")
        section = XLFormSectionDescriptor.formSection(withTitle: "Selectors")
        form.addFormSection(section)
        

        row = XLFormRowDescriptor(tag: modelProerty.type, rowType: XLFormRowDescriptorTypeRate, title: "发布类型")
        row.value = 1
        section.addFormRow(row)
        
        // Selector Push
        row = XLFormRowDescriptor(tag: modelProerty.type, rowType:XLFormRowDescriptorTypeSelectorPickerView, title:"发布类型")
//        row.selectorOptions = [XLFormOptionsObject(value: 0, displayText: "提醒类")!,
//                                    XLFormOptionsObject(value: 1, displayText:"业绩类")!,
//                                    XLFormOptionsObject(value: 2, displayText:"管理类")!,
//                                    XLFormOptionsObject(value: 3, displayText:"其他")!
//                                    ]
        row.value = XLFormOptionsObject(value: 0, displayText:"业绩类")
        row.action.formBlock = { [weak self] (sender: XLFormRowDescriptor!) -> Void in
            print("`11111")
        }
        section.addFormRow(row)

      
    
        // Selector Action Sheet
        row = XLFormRowDescriptor(tag :Tags.ActionSheet, rowType:XLFormRowDescriptorTypeSelectorActionSheet, title:"Sheet")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
        row.value = "Option 3"
        section.addFormRow(row)
        
        
        
        // Selector Alert View
        row = XLFormRowDescriptor(tag: Tags.AlertView, rowType:XLFormRowDescriptorTypeSelectorAlertView, title:"Alert View")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
        row.value = "Option 3"
        section.addFormRow(row)
        
        // Selector Picker View
        row = XLFormRowDescriptor(tag: Tags.PickerView, rowType:XLFormRowDescriptorTypeSelectorPickerView, title:"Picker View")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
        row.value = "Option 4"
        section.addFormRow(row)
        
        
        // --------- Fixed Controls
        section = XLFormSectionDescriptor.formSection(withTitle: "Fixed Controls")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.Picker, rowType:XLFormRowDescriptorTypePicker)
        row.selectorOptions = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
        row.value = "Option 1"
        section.addFormRow(row)
        
        // --------- Inline Selectors
        section = XLFormSectionDescriptor.formSection(withTitle: "Inline Selectors")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.MultipleSelector, rowType:XLFormRowDescriptorTypeSelectorPickerViewInline, title:"Inline Picker View")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"]
        row.value = "Option 6"
        section.addFormRow(row)
        
        // --------- MultipleSelector
        section = XLFormSectionDescriptor.formSection(withTitle: "Multiple Selectors")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.MultipleSelector, rowType:XLFormRowDescriptorTypeMultipleSelector, title:"Multiple Selector")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"]
        row.value = ["Option 1", "Option 3", "Option 4", "Option 5", "Option 6"]
        section.addFormRow(row)
        
        
        // Multiple selector with value tranformer
        row = XLFormRowDescriptor(tag: Tags.MultipleSelector, rowType:XLFormRowDescriptorTypeMultipleSelector, title:"Multiple Selector")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"]
        row.value = ["Option 1", "Option 3", "Option 4", "Option 5", "Option 6"]
//        row.valueTransformer = NSArrayValueTrasformer.self
        section.addFormRow(row)
        
        
        // Language multiple selector
        row = XLFormRowDescriptor(tag: Tags.MultipleSelector, rowType:XLFormRowDescriptorTypeMultipleSelector, title:"Multiple Selector")
        row.selectorOptions = Locale.isoLanguageCodes
        row.selectorTitle = "Languages"
        row.valueTransformer = ISOLanguageCodesValueTranformer.self
        row.value = Locale.preferredLanguages
        section.addFormRow(row)

    
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Language multiple selector popover
            row = XLFormRowDescriptor(tag: Tags.MultipleSelectorPopover, rowType:XLFormRowDescriptorTypeMultipleSelectorPopover, title:"Multiple Selector PopOver")
            row.selectorOptions = Locale.isoLanguageCodes
            row.valueTransformer = ISOLanguageCodesValueTranformer.self
            row.value = Locale.preferredLanguages
            section.addFormRow(row)
        }
        
    
    
        // --------- Dynamic Selectors
        section = XLFormSectionDescriptor.formSection(withTitle: "Dynamic Selectors")
        form.addFormSection(section)

        row = XLFormRowDescriptor(tag: Tags.DynamicSelectors, rowType:XLFormRowDescriptorTypeButton, title:"Dynamic Selectors")
        row.action.viewControllerClass = AEFormViewController.self
        section.addFormRow(row)
        
        
    
        // --------- Custom Selectors
        section = XLFormSectionDescriptor.formSection(withTitle: "Custom Selectors")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.CustomSelectors, rowType:XLFormRowDescriptorTypeButton, title:"Custom Selectors")
        row.action.formBlock = { (descriptor)in
            print("descriptor ---- \(descriptor)")
        }
        section.addFormRow(row)
        

        // --------- Selector definition types
        section = XLFormSectionDescriptor.formSection(withTitle: "Selectors")
        form.addFormSection(section)
        
        // selector with segue class
        row = XLFormRowDescriptor(tag: Tags.TextView, rowType: XLFormRowDescriptorTypeTextView)
        section.addFormRow(row)

        
        self.form = form
      }

    @objc func savePressed(_ button: UIBarButtonItem)
    {
        let validationErrors : Array<NSError> = self.formValidationErrors() as! Array<NSError>
        if (validationErrors.count > 0){
            self.showFormValidationError(validationErrors.first)
            return
        }
        self.tableView.endEditing(true)
        print("\(String(describing: self.form.formValues().keys.first))")
    }
}

class ISOLanguageCodesValueTranformer : ValueTransformer {
 
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        if let stringValue = value as? String {
            return (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.languageCode, value: stringValue)
        }
        return nil
    }
}

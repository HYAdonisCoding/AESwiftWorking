// MIT license. Copyright (c) 2021 SwiftyFORM. All rights reserved.
import Foundation

class ReloadPersistentValidationStateVisitor: FormItemVisitor {

	class func validateAndUpdateUI(_ items: [FormItem]) {
		let visitor = ReloadPersistentValidationStateVisitor()
		for item in items {
			item.accept(visitor: visitor)
		}
	}

	func visit(object: TextFieldFormItem) {
		object.reloadPersistentValidationState()
	}

	func visit(object: AttributedTextFormItem) {}
	func visit(object: ButtonFormItem) {}
	func visit(object: CustomFormItem) {}
	func visit(object: DatePickerFormItem) {}
	func visit(object: MetaFormItem) {}
	func visit(object: OptionPickerFormItem) {}
	func visit(object: OptionRowFormItem) {}
	func visit(object: PickerViewFormItem) {}
	func visit(object: PrecisionSliderFormItem) {}
	func visit(object: SectionFooterTitleFormItem) {}
	func visit(object: SectionFooterViewFormItem) {}
	func visit(object: SectionFormItem) {}
	func visit(object: SectionHeaderTitleFormItem) {}
	func visit(object: SectionHeaderViewFormItem) {}
	func visit(object: SegmentedControlFormItem) {}
	func visit(object: SliderFormItem) {}
	func visit(object: StaticTextFormItem) {}
	func visit(object: StepperFormItem) {}
	func visit(object: SwitchFormItem) {}
	func visit(object: TextViewFormItem) {}
	func visit(object: ViewControllerFormItem) {}
}

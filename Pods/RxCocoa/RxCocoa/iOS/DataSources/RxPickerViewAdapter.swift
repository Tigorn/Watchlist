//
//  RxPickerViewAdapter.swift
//  RxCocoa
//
//  Created by Sergey Shulga on 12/07/2017.
//  Copyright © 2017 Krunoslav Zaher. All rights reserved.
//

#if os(iOS)
    import UIKit
    #if !RX_NO_MODULE
        import RxSwift
    #endif

    class RxPickerViewArrayDataSource<T>: NSObject, UIPickerViewDataSource, SectionedViewDataSourceType {
        fileprivate var items: [T] = []

        func model(at indexPath: IndexPath) throws -> Any {
            guard items.indices ~= indexPath.row else {
                throw RxCocoaError.itemsNotYetBound(object: self)
            }
            return items[indexPath.row]
        }

        func numberOfComponents(in _: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
            return items.count
        }
    }

    class RxPickerViewSequenceDataSource<S: Sequence>
        : RxPickerViewArrayDataSource<S.Iterator.Element>, RxPickerViewDataSourceType {
        typealias Element = S

        func pickerView(_ pickerView: UIPickerView, observedEvent: Event<S>) {
            Binder(self) { dataSource, items in
                dataSource.items = items
                pickerView.reloadAllComponents()
            }
            .on(observedEvent.map(Array.init))
        }
    }

    final class RxStringPickerViewAdapter<S: Sequence>
        : RxPickerViewSequenceDataSource<S>, UIPickerViewDelegate {

        typealias TitleForRow = (Int, S.Iterator.Element) -> String?
        private let titleForRow: TitleForRow

        init(titleForRow: @escaping TitleForRow) {
            self.titleForRow = titleForRow
            super.init()
        }

        func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
            return titleForRow(row, items[row])
        }
    }

    final class RxAttributedStringPickerViewAdapter<S: Sequence>: RxPickerViewSequenceDataSource<S>, UIPickerViewDelegate {
        typealias AttributedTitleForRow = (Int, S.Iterator.Element) -> NSAttributedString?
        private let attributedTitleForRow: AttributedTitleForRow

        init(attributedTitleForRow: @escaping AttributedTitleForRow) {
            self.attributedTitleForRow = attributedTitleForRow
            super.init()
        }

        func pickerView(_: UIPickerView, attributedTitleForRow row: Int, forComponent _: Int) -> NSAttributedString? {
            return attributedTitleForRow(row, items[row])
        }
    }

    final class RxPickerViewAdapter<S: Sequence>: RxPickerViewSequenceDataSource<S>, UIPickerViewDelegate {
        typealias ViewForRow = (Int, S.Iterator.Element, UIView?) -> UIView
        private let viewForRow: ViewForRow

        init(viewForRow: @escaping ViewForRow) {
            self.viewForRow = viewForRow
            super.init()
        }

        func pickerView(_: UIPickerView, viewForRow row: Int, forComponent _: Int, reusing view: UIView?) -> UIView {
            return viewForRow(row, items[row], view)
        }
    }

#endif

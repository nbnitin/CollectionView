////
////  CustomCollectionView.swift
////  BubbleViewCollectionView
////
////  Created by Nitin Bhatia on 20/04/23.
////
//
//import UIKit
//
//protocol CaCollectionBubbleCellDelegate: AnyObject {
//
//    func onChange(id: Int, selected: Bool)
//}
//
//protocol CaCollectionBubbleDelegate: AnyObject {
//
//    var countItems: Int {get}
//
//    func setItem(width: CGFloat, forKey: Int)
//
//    func setItem(selected: Bool, forKey: Int)
//
//    func setItem(enabled: Bool, forKey: Int)
//
//    func setItem(alignment: CaCollectionBubbleAlignment, forKey: Int)
//
//    func getItem(forKey: Int) -> CaCollectionBubbleItem?
//}
//
//enum CaCollectionBubbleAlignment {
//    case center
//    case left(offset: CGFloat)
//    case right(offset: CGFloat)
//}
//
//protocol CaCollectionBubbleItem {
//    func getWidth() -> CGFloat?
//    func getTitle() -> String
//    func getAlignment() -> CaCollectionBubbleAlignment?
//    func isSelected() -> Bool
//    func isEnabled() -> Bool
//}
//
//
//class CaCollectionBubbleView:
//    UICollectionView,
//    UICollectionViewDataSource,
//    UICollectionViewDelegate,
//    UICollectionViewDelegateFlowLayout,
//    CaCollectionBubbleCellDelegate
//{
//    enum RowConfiguration {
//        case above1_below1
//        case above2_below1
//        case above3_below2
//        case above4_below3
//        case above5_below4
//
//        static func getConfiguration(forNumberOfRows: Int) -> RowConfiguration {
//            switch forNumberOfRows {
//                case 1: return RowConfiguration.above1_below1
//                case 2: return RowConfiguration.above2_below1
//                case 3: return RowConfiguration.above3_below2
//                case 4: return RowConfiguration.above4_below3
//                case 5: return RowConfiguration.above5_below4
//                default:return RowConfiguration.above1_below1
//            }
//        }
//    }
//
//    weak var output: CaCollectionBubbleDelegate?
//
//    let cellHeight: CGFloat = 50.0
//    var configuration: RowConfiguration = .above3_below2
//
//    private var sizeChanged: Bool = false
//    private var cellsAbove: Int {
//        switch configuration {
//            case .above1_below1: return 1
//            case .above2_below1: return 2
//            case .above3_below2: return 3
//            case .above4_below3: return 4
//            case .above5_below4: return 5
//        }
//    }
//    private var cellsBelow: Int {
//        switch configuration {
//            case .above1_below1: return 1
//            case .above2_below1: return 1
//            case .above3_below2: return 2
//            case .above4_below3: return 3
//            case .above5_below4: return 4
//        }
//    }
//
//    lazy private var cellId: String = {
//        return NSUUID().uuidString
//    }()
//
//    private var fontSize: CGFloat = 16
//
//    convenience init(frameWidth: CGFloat, output: CaCollectionBubbleDelegate?) {
//        var cols: Int?
//        var font: CGFloat?
//
//        if let items = output?.countItems, items > 0 {
//            let maxFontSize = 17
//            let minFontSize = 11
//            let maxColsNumber = min(5, items)
//            let minColsNumber = 1
//            let cellMargin: CGFloat = 16
//            let cellPadding: CGFloat = 16
//            var longestItem = (width: CGFloat(0), text: NSString(string: ""))
//
//            for i in 0..<items {
//                if let item = output?.getItem(forKey: i) {
//                    let size = (item.getTitle() as NSString).size(
//                        withAttributes: [.font: UIFont.systemFont(ofSize: 17)]
//                    )
//
//                    if size.width > longestItem.width {
//                        longestItem.width = size.width
//                        longestItem.text = item.getTitle() as NSString
//                    }
//                }
//            }
//
//            outerLoop: for colsNumber in stride(
//                from: maxColsNumber,
//                through: minColsNumber,
//                by: -1
//            ) {
//                for fontSize in stride(
//                    from: maxFontSize,
//                    through: minFontSize,
//                    by: -1
//                ) {
//                    let size = longestItem.text.size(
//                        withAttributes: [
//                            .font: UIFont.systemFont(ofSize: CGFloat(fontSize))
//                        ]
//                    )
//
//                    let cellWidth = frameWidth / CGFloat(colsNumber)
//                        - cellMargin
//                        - cellPadding
//
//                    if size.width < cellWidth {
//                        cols = colsNumber
//                        font = CGFloat(fontSize)
//                        break outerLoop
//                    }
//                }
//            }
//        }
//
//        let config = RowConfiguration.getConfiguration(
//            forNumberOfRows: cols ?? 0
//        )
//
//        self.init(
//            configuration: config,
//            output: output,
//            fontSize: font ?? 16
//        )
//    }
//
//    convenience init(
//        configuration: RowConfiguration,
//        output: CaCollectionBubbleDelegate?,
//        fontSize: CGFloat
//    ) {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 0.0
//        layout.minimumLineSpacing = 0.0
//        layout.sectionInset = UIEdgeInsets(
//            top: 0.0,
//            left: 0.0,
//            bottom: 0.0,
//            right: 0.0
//        )
//
//        self.init(frame: .zero, collectionViewLayout: layout)
//        self.output = output
//        self.configuration = configuration
//        self.fontSize = fontSize
//
//        delegate = self
//        dataSource = self
//        backgroundColor = UIColor.clear
//
//        isScrollEnabled = false
//        
//        register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//        
//    }
//
//    var rowsNumber: Int {
//        let cells = cellsAbove + cellsBelow
//        let count = output?.countItems ?? 0
//        let full = Int(CGFloat(count / cells).rounded(.down))
//        var rows = full * 2
//        let rest = count - cells * full
//
//        if rest > 0 && rest <= cellsAbove {
//            rows += 1
//        }
//        else if rest > cellsAbove {
//            rows += 2
//        }
//
//        return rows
//    }
//
//    func onChange(id: Int, selected: Bool) {
//        output?.setItem(selected: selected, forKey: id)
//        reloadData()
//    }
//
//    // MARK: UICollectionView delegate
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int
//    ) -> Int {
//        return output?.countItems ?? 0
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: "cell",
//            for: indexPath
//        ) as! CustomCollectionViewCell
//
//        guard let item = output?.getItem(forKey: indexPath.row) else {
//            return cell
//        }
//
//        let value = CustomCollectionViewCell.Value(
//            id: indexPath.row,
//            title: item.getTitle(),
//            selected: item.isSelected(),
//            enabled: item.isEnabled()
//        )
//
//        cell.delegate = self
//
//        if let width = item.getWidth() {
//            cell.setup(
//                value: value,
//                width: width,
//                align: item.getAlignment() ?? .center
//            )
//        } else {
//            cell.setup(value: value)
//        }
//
//        cell.button?.fontSize = fontSize
//
//        return cell
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        if let item = output?.getItem(forKey: indexPath.row) {
//            let value = CaCollectionBubbleCell.Value(
//                id: indexPath.row,
//                title: item.getTitle(),
//                selected: item.isSelected(),
//                enabled: item.isEnabled()
//            )
//            if value.enabled == false {
//                return
//            }
//            self.onChange(id: value.id, selected: !value.selected)
//        }
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//
//        let width: CGFloat
//        let key = indexPath.row
//        let row = key % (cellsAbove + cellsBelow)
//        let offset: CGFloat = 8.0
//
//        switch row {
//        case 0..<cellsAbove:
//            width = floor(frame.size.width / CGFloat(cellsAbove))
//            output?.setItem(alignment: .center, forKey: key)
//            output?.setItem(width: width - offset * 2, forKey: key)
//
//        case cellsAbove..<(cellsAbove + cellsBelow):
//            switch configuration {
//            case .above1_below1:
//                width = floor(frame.size.width / CGFloat(cellsAbove))
//                output?.setItem(alignment: .center, forKey: key)
//                output?.setItem(width: width - offset * 2, forKey: key)
//
//            default:
//                width = floor(frame.size.width / CGFloat(cellsAbove - 1))
//                output?.setItem(
//                    width: output?.getItem(forKey: 0)?.getWidth() ?? 0,
//                    forKey: key
//                )
//            }
//
//            switch configuration {
//            case .above3_below2:
//                switch row {
//                case 3:
//                    output?.setItem(alignment: .right(offset: offset), forKey: key)
//                case 4:
//                    output?.setItem(alignment: .left(offset: offset), forKey: key)
//                default:
//                    output?.setItem(alignment: .center, forKey: key)
//                }
//            case .above4_below3:
//                switch row {
//                case 4:
//                    output?.setItem(alignment: .right(offset: 0), forKey: key)
//                case 5:
//                    output?.setItem(alignment: .center, forKey: key)
//                case 6:
//                    output?.setItem(alignment: .left(offset: 0), forKey: key)
//                default:
//                    output?.setItem(alignment: .center, forKey: key)
//                }
//            case .above5_below4:
//                switch row {
//                case 5:
//                    output?.setItem(alignment: .right(offset: -offset), forKey: key)
//                case 6:
//                    output?.setItem(alignment: .right(offset: offset), forKey: key)
//                case 7:
//                    output?.setItem(alignment: .left(offset: offset), forKey: key)
//                case 8:
//                    output?.setItem(alignment: .left(offset: -offset), forKey: key)
//                default:
//                    output?.setItem(alignment: .center, forKey: key)
//                }
//            default:
//                output?.setItem(alignment: .center, forKey: key)
//            }
//
//        default:
//            width = 0.0
//        }
//
//        return CGSize(width: width, height: cellHeight)
//    }
//
//    // MARK: UIViewController events delegate
//
//    func viewWillTransition() {
//        sizeChanged = true
//    }
//
//    func viewWillLayoutSubviews() {
//        if sizeChanged {
//            collectionViewLayout.invalidateLayout()
//        }
//    }
//
//    func viewDidLayoutSubviews() {
//        if sizeChanged {
//            sizeChanged = false
//            performBatchUpdates({}, completion: nil)
//        }
//    }
//
//    // Error message
//
//    var message: UILabel?
//
//    private func createMessage(text: String) -> UILabel {
//        let message = UILabel()
//        message.text = text
//        message.textColor = .red
//        message.font = UIFont(name: "Helvetica Neue", size: 12)!
//        message.translatesAutoresizingMaskIntoConstraints = false
//        message.numberOfLines = 2
//        return message
//    }
//
//    func setError(_ text: String) {
//        message?.removeFromSuperview()
//        message = superview?.add(createMessage(text: text))
//        message?.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(snp.bottom).offset(0)
//            make.height.equalTo(28)
//        }
//    }
//
//    func clearError() {
//        message?.removeFromSuperview()
//    }
//}

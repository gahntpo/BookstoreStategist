//
//  MacContentView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 20.07.23.
//

import SwiftUI

struct MacContentView: View {
    
    enum NavigationSelection {
        case recentSales
        case salesPerWeekday
        case salesePerCategory
        case expenses
    }
    
    @StateObject var salesViewModel: SalesViewModel = .preview
    @StateObject var expensesViewModel: ExpenseViewModel = .preview
    
    @State private var navigationSelection: NavigationSelection? = .recentSales
    
    var body: some View {
        NavigationSplitView {
            List(selection: $navigationSelection) {
                Group {
                    SimpleBookSalesView(salesViewModel: salesViewModel)
                        .tag(NavigationSelection.recentSales)
                    SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                        .tag(NavigationSelection.salesPerWeekday)
                    SimpleSalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
                        .tag(NavigationSelection.salesePerCategory)
                    SimpleExpensesLineChartView(expensesViewModel: expensesViewModel)
                        .tag(NavigationSelection.expenses)
                }
                .listRowInsets(.init(top: 10, leading: 10, bottom: 50, trailing: 10))
            }
        } detail: {
            switch navigationSelection {
                case .recentSales:
                    DetailBookSalesView(salesViewModel: salesViewModel)
                case .salesPerWeekday:
                    SalesByWeekdayView(salesViewModel: salesViewModel)
                case .salesePerCategory:
                    SalesPerBookCategoryView(salesViewModel: salesViewModel)
                case .expenses:
                    DetailExpensesView(expensesViewModel: expensesViewModel)
                default:
                    Text("Placeholder")
            }
            
        }
        
      
    }
}

#Preview {
    MacContentView()
}

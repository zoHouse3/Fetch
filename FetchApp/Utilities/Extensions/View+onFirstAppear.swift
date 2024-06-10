//
//  View+onFirstAppear.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/10/24.
//

/*
  - Custom onFirstAppear implementation to 'simulate UIKit's viewDidLoad method'
 */
import SwiftUI

public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> ()
    
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            // if view has 'already appeared' before, skip action
            guard !hasAppeared else { return }
            
            hasAppeared = true
            action()
        }
    }
}

//
//  WordDetailView.swift
//  IsaacDemo
//
//  Created by Park Kangwook on 2022/05/26.
//

import SwiftUI

struct WordDetailView: View {
    @Binding var word: String
    
    var body: some View {
        Text(word)
    }
}


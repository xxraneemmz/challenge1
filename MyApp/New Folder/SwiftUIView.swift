//
//  SwiftUIView.swift
//  MyApp
//
//  Created by Raneem Marzouq Albogami on 09/05/1448 AH.
//

import SwiftUI

struct SwiftUIView: View {
    
    var body: some View {
        VStack{
            Image(.raneem)
                .resizable()
                .frame(width: 120,height: 120)
                .clipShape(.circle)
            
            Text("Raneem,25")
                .font(.title)
                .fontWeight(.semibold)
        }
        
        Section{
            Text("i love me")
        }header: {
            Text("about")
        }
        
   
            
            
        }
    }


#Preview {
    SwiftUIView()
}

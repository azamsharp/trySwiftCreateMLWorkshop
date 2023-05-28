//
//  ContentView.swift
//  HelloCoreML
//
//  Created by Mohammad Azam on 5/19/23.
//

import SwiftUI
import CoreML
import PhotosUI

struct ProbabilityListView: View {
    
    let probs: [Dictionary<String, Double>.Element]
    
    var body: some View {
        List(probs, id: \.key) { (key, value) in
            
            HStack {
                Text(key)
                Text(NSNumber(value: value), formatter: NumberFormatter.percentage)
            }
        }
    }
}

struct ContentView: View {
    
    @State private var probs: [String: Double] = [: ]
    @State private var uiImage: UIImage?
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var isCameraSelected: Bool = false
    
    var sortedProbs: [Dictionary<String, Double>.Element] {
        
        let probsArray = Array(probs)
        return probsArray.sorted { lhs, rhs in
            lhs.value > rhs.value
        }
    }
    
    var body: some View {
        
        VStack {
            
            Image(uiImage: uiImage ?? UIImage(named: "placeholder")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .aspectRatio(contentMode: .fit)
            
            
            HStack {
                
                PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                   Text("Select a Photo")
                }
                
                Button("Camera") {
                    isCameraSelected = true
                }.buttonStyle(.bordered)
            }
            
            Button("Predict") {
                
                
                
            }.buttonStyle(.borderedProminent)
            
            ProbabilityListView(probs: sortedProbs)
        }
        .onChange(of: selectedPhotoItem, perform: { selectedPhotoItem in
            selectedPhotoItem?.loadTransferable(type: Data.self, completionHandler: { result in
                print(result)
                switch result {
                    case .success(let data):
                        if let data {
                            uiImage = UIImage(data: data)
                        }
                            
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            })
        })
        .sheet(isPresented: $isCameraSelected, content: {
            ImagePicker(image: $uiImage, sourceType: .camera)
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

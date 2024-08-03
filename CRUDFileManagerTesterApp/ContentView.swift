//
//  ContentView.swift
//  CRUDFileManagerTesterApp
//
//  Created by Mr. Kavinda Dilshan on 2024-08-03.
//

import SwiftUI
import CRUDFileManager

struct ContentView: View {
    
    enum SubDirectories: String {
        case folder1
        case folder2
    }
    
    let fileManager = CRUDFileManager<SubDirectories>()
    let fileName: String = "text.txt"
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Create Directory") {
                Task {
                    do {
                        let url: URL = try await fileManager.createDirectory(
                            directory: .documentDirectory,
                            subDirectories: [.folder1, .folder2]
                        )
                        
                        print("\(url)\n")
                    } catch {
                        print(error.localizedDescription+"\n")
                    }
                }
            }
            
            Button("Create a File") {
                guard let data: Data = UUID().uuidString.data(using: .utf8) else {
                    print("Error parsing String to Data.\n")
                    return
                }
                
                Task {
                    do {
                        let url: URL = try await fileManager.createFile(
                            directory: .documentDirectory,
                            subDirectories: [.folder1, .folder2],
                            nameWithExt: fileName,
                            contents: data
                        )
                        
                        print("File created successfully.: \(url)\n")
                    } catch {
                        print(error.localizedDescription+"\n")
                    }
                }
            }
            
            Button("Update the File") {
                guard let data: Data = "Updated Data: \(UUID().uuidString)".data(using: .utf8) else {
                    print("Error parsing String to Data.\n")
                    return
                }
                
                Task {
                    do {
                        try await fileManager.updateFile(
                            directory: .documentDirectory,
                            subDirectories: [.folder1, .folder2],
                            nameWithExt: fileName,
                            contents: data
                        )
                        
                        print("File update successful.\n")
                    } catch {
                        print(error.localizedDescription+"\n")
                    }
                }
            }
            
            Button("Read the File") {
                Task {
                    do {
                        let data: Data = try await fileManager.readFile(
                            directory: .documentDirectory,
                            subDirectories: [.folder1, .folder2],
                            nameWithExt: fileName
                        )
                        
                        guard let string: String = String(data: data, encoding: .utf8) else {
                            print("Error parsing Data to String.\n")
                            return
                        }
                        
                        print(string+"\n")
                    } catch {
                        print(error.localizedDescription+"\n")
                    }
                }
            }
            
            Button("Delete the File") {
                Task {
                    do {
                        try await fileManager.deleteFile(
                            directory: .documentDirectory,
                            subDirectories: [.folder1, .folder2],
                            nameWithExt: fileName
                        )
                        
                        print("File deleted successfully.")
                    } catch {
                        print(error.localizedDescription+"\n")
                    }
                }
            }
            
            Button("Delete the Directory") {
                Task {
                    do {
                        try await fileManager.deleteDirectory(
                            directory: .documentDirectory,
                            subDirectories: [.folder1, .folder2]
                        )
                        
                        print("Directory deleted successfully.\n")
                    } catch {
                        print(error.localizedDescription+"\n")
                    }
                }
            }
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

#Preview {
    ContentView()
}

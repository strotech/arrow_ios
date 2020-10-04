//Created by me on 02/10/20

import SwiftUI

struct AddMemberView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name=""
    @State private var alterEgo=""
    @State private var otherAffiliations="Bratva"
    var listOfAffiliations=["Bratva","ARGUS","Legends"]
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Name",text:$name)
                    TextField("Alter Ego",text:$alterEgo)
                    
                    Picker("Other Affiliation",selection: $otherAffiliations){
                        ForEach(listOfAffiliations,id:\.self){ affiliation in
                            Text(affiliation)
                        }
                    }
                    
                }
                Button("Add Member") {
                    let newMember=Member(context:self.moc)
                    newMember.name=self.name
                    newMember.alterEgo=self.alterEgo
                    newMember.otherAffiliations=self.otherAffiliations
                    
                    do {
                        try self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Whoops \(error.localizedDescription)")
                    }
                }
            }.navigationBarTitle("New member")
        }
    }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}

Alias:   SCT = http://snomed.info/sct

RuleSet: Question(context, linkId, text, type, repeats)
* {context}item[+].linkId = "{linkId}"
* {context}item[=].text = "{text}"
* {context}item[=].type = #{type}
* {context}item[=].repeats = {repeats}


RuleSet: VSCodeDef(system,code,display)
* compose.include[+].system = {system} 
* compose.include[=].concept[+].code = #{code}
* compose.include[=].concept[=].display = "{display}"



Instance: FoodAllergyVS-cont
InstanceOf: ValueSet
Description: "Food Allergy ValueSet"
Title: "Food Allergy ValueSet"
Usage: #inline
* name = "FoodAllergyVS"
* id = "vs-food-allergy-cont"
* status = #active
* insert VSCodeDef($SCT,91935009,Allergy to peanut)
* insert VSCodeDef($SCT,48821000119104,Allergy to tree nut)
* insert VSCodeDef($SCT,782555009,Allergy to cow’s milk protein)
* insert VSCodeDef($SCT,213020009,Allergy to egg protein)
* insert VSCodeDef($SCT,417532002,Allergy to fish)
* insert VSCodeDef($SCT,300913006,Allergy to shellfish)
* insert VSCodeDef($SCT,782594005,Allergy to soy protein)
* insert VSCodeDef($SCT,260167008,Sesame seed) // note that this is not the correct code – one couldn’t be found
* insert VSCodeDef($SCT,21191000122102,Allergy to mustard)
* insert VSCodeDef($SCT,712843002,Allergy to celery)
* insert VSCodeDef($SCT,782575000,Allergy to lupine seed)


Instance: FoodAllergyVerificationStatusVS-cont
InstanceOf: ValueSet
Description: "Food Allergy verification status ValueSet"
Title: "Food Allergy verification status ValueSet"
Usage: #inline
* name = "FoodAllergyVerificationStatusVS"
* id = "vs-food-allergy-verifstatus-cont"
* status = #active
* insert VSCodeDef($SCT,410605003,Confirmed present)
* insert VSCodeDef($SCT,415684004,Suspected)


Instance: FoodAllergyClinicalStatusVS-cont
InstanceOf: ValueSet
Description: "Food Allergy clinical status ValueSet"
Title: "Food Allergy clinical status ValueSet"
Usage: #inline
* name = "FoodAllergyVS"
* id = "vs-food-allergy-clinstatus-cont"
* status = #active
* insert VSCodeDef($SCT,723506003,Resolved)
* insert VSCodeDef($SCT,55561003,Active)













Instance: food-allergy-questionnaire
//InstanceOf: sdc-questionnaire-extract
InstanceOf: Questionnaire
Description: "Self-reported food allergy Form"
Title: "Self-reported food allergy Form"
Usage: #definition

* contained[+] = FoodAllergyVS-cont
* contained[+] = FoodAllergyVerificationStatusVS-cont
* contained[+] = FoodAllergyClinicalStatusVS-cont

* title = "Food Allergy self-report"
* description = "A form for self-reported food allergies, including the basic information and contained valuesets"
* name = "FoodAllergyQuestionnaire"
* version = "2022"
* status = #draft
* subjectType = #Patient
* language = #en
* status = #draft

* url = "http://openhie.org/fhir/food-allergy/Questionnaire/food-allergy-questionnaire"

* item[+].linkId = "title"
* item[=].text = "Food Allergy report"
* item[=].type = #display
* item[+].linkId = "instructions"
* item[=].text = "Reporting instructions: Please report any allergy or allergic reaction"
* item[=].type = #display


* insert Question(,patient,Patient ID,string,false)
* insert Question(,allergen,Substance that the person is allergic to,choice,false)
* item[=].answerValueSet = Canonical(vs-food-allergy-cont)
* insert Question(,clinicalStatus,Status of the allergy - active or resolved,choice,false)
* item[=].answerValueSet = Canonical(vs-food-allergy-clinstatus-cont)
* insert Question(,verificationStatus,Verification status of the allergy - confirmed or suspected or refuted,choice,false)
* item[=].answerValueSet = Canonical(vs-food-allergy-verifstatus-cont)
* insert Question(,recordedDate,When was it reported,date,false)
* insert Question(,recorder,Who recorded the allergy,string,false)
* insert Question(,asserter,Who asserted the allergy,string,false)
* insert Question(,reactions,Reactions,group,false)
* insert Question(item[=].,substance,Substance that is thought to have triggered the reaction,string,false)
* insert Question(item[=].,manifestation,Manifestation,string,false)
//  * certitude 0..1 CodeableConcept "How certain we are that the cause of the reaction was the allergen indicated" "How certain we are that the cause of the reaction was the allergen indicated"
//  * exposure 0..1 CodeableConcept "The exposure route to the substance" "The exposure route to the substance"
* insert Question(item[=].,note,Note,string,false)










//
//  WhoWeAreController.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/18/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit
import Firebase

class WhoWeAreController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    
    let whoWeAreOptions: [WhoWeAreOption] = {
        return [WhoWeAreOption(name: "Todd LeVasseur", profileImage: "todd", description: "Todd LeVasseur is a visiting professor in religious studies. He also teaches within the Environmental and Sustainability Studies Program. His focus as a scholar involves the interface of religious beliefs/experiences/institutional identities/practices and cultural narratives and how these shape and are shaped by the natural world.", position: "SLI Director", color: Color.blue)
        ]
    }()
    
    
//    let whoWeAreOptions: [WhoWeAreOption] = {
//        return [WhoWeAreOption(name: "Todd LeVasseur", profileImage: "fellows", description: "Todd LeVasseur is a visiting professor in religious studies. He also teaches within the Environmental and Sustainability Studies Program. His focus as a scholar involves the interface of religious beliefs/experiences/institutional identities/practices and cultural narratives and how these shape and are shaped by the natural world.", position: "SLI Director", color: Color.blue),
//                WhoWeAreOption(name: "Steve Jaumé", profileImage: "todd", description: "Professor Steve Jaumé is an earthquake seismologist with strong interests in how societies adapt to both chronic and extreme natural hazards. He is a native of New Orleans, Louisiana (“the inevitable city on the impossible site”, Peirce Lewis, 1976), who watched one of his nightmares come true on TV in August 2005 as Hurricane Katrina flooded his hometown. At the College of Charleston he teaches environmental geology, natural hazards, geophysics and seismology. He studies earthquake hazards in the greater Charleston region, reviews seismic safety of proposed nuclear power stations, and has recently begun working with economists in the School of Business examining the impact of induced earthquakes on housing prices in Oklahoma. He is also a member of the Lowcountry Hazards Center and the Charleston Resilience Network.", position: "Faculty Development Fellow", color: Color.green),
//                WhoWeAreOption(name: "Lindsey Beard", profileImage: "todd", description: "Lindsey is a Master of Environmental Studies graduate student at the College of Charleston. Her research interests include analytical water chemistry and freshwater systems. Before attending College of Charleston, she was an analytical water chemistry analyst at a state regulatory lab in Greenville, SC. She obtained a Bachelor of Science in Earth and Environmental Science from Furman University. She is currently the Graduate Assistant for the Faculty Development Fellow for the Sustainability Literacy Institute. After graduate school, she hopes to pursue a career in water quality management.", position: "Faculty Development GA", color: Color.yellow),
//                WhoWeAreOption(name: "David Hansen", profileImage: "todd", description: "David Hansen is an Associate Professor of Entrepreneurship in the Department of Management and Marketing. His primary research is aimed at better understanding the process of how ideas are conceived and developed into new products and new businesses through a theoretical lens of creativity. Additionally, he has examined how opportunity has been defined and operationalized in the literature. His secondary research focuses on the interface between marketing and entrepreneurship. His research has been published in entrepreneurship journals including Journal of Small Business Management, International Journal of Entrepreneurial Behaviour &amp; Research, and International Entrepreneurship Management Journal. He is an Associate Editor for the Journal of Research in Marketing and Entrepreneurship and a board member for the Global Research Symposium on Marketing and Entrepreneurship. He primarily teaches entrepreneurship courses including New Venture Modeling, Ecopreneurship (a course he created) and Social Entrepreneurship. In addition, he regularly works with undergrad and graduate students on thesis projects related to sustainable business and/or entrepreneurship.", position: "Innovation Fellow", color: Color.blue),
//                WhoWeAreOption(name: "Eunice Catindig", profileImage: "todd", description: "Eunice Catindig received her Bachelor of Science in Business Administration major in Management (BSBAM) from the University of Asia and the Pacific, Philippines. She was honed holistically through the major courses in Management as well as in the Liberal Arts courses. She gained professional work experience in United Laboratories, Inc. the biggest pharmaceutical company in the Philippines as a Marketing and events specialist. She handled both business to business and direct to consumer brand marketing as well as planning large scale events to promote the brand. Eunice was also given a variety of special projects, which included collaborating with different employees from different brands to handle company events and improving the division’s internal process systems. Eunice is currently pursuing her M.B.A. with a concentration in Marketing from the College of Charleston. She also serves as a dream team member at the Seacoast church at the pre-school department.", position: "Innovation GA", color: Color.green),
//                WhoWeAreOption(name: "Caroline Foster", profileImage: "todd", description: "Professor Foster is a visiting assistant professor teaching in the Department of Communication. She specializes in mass communication and journalism. Formerly the editor at South Carolina Wildlife magazine, Foster also worked as a research assistant at the University of South Carolina. Foster has published health- and science-focused research in Health Promotion Practice, the Journal of Health Communication and Science Communication, among other field-specific journals.", position: "Outreach and Communications Fellow", color: Color.yellow),
//                WhoWeAreOption(name: "Zachary T. Stephens", profileImage: "zach", description: "Zachary is a Masters of Environmental Studies student here at The College of Charleston. He completed his undergraduate degree at The University of Alabama in Environmental Sciences specializing in water policy, law, and management. His research interests include corporate sustainability, urban resilience, and state water law. Zachary is currently the Graduate Assistant for Outreach and Communication for The Sustainability Literacy Institute and serves as the Greek Liaison for the Institute. Zachary is an active leader within the campus community currently serving his term as the President of the Graduate Student Association. After graduation, he seeks to become a Chief Sustainability Officer or Manager in the public or private sector.", position: "Outreach and Communications GA", color: Color.blue),
//                WhoWeAreOption(name: "Barry Stiefel", profileImage: "todd", description: "Professor Barry L. Stiefel teaches in the Historic Preservation and Community Planning Program, and the joint graduate program in historic preservation with Clemson University. He earned his Ph.D. in historic preservation from Tulane University, Master of Urban Planning from the University of Michigan, Graduate Certificate in Historic Preservation from Eastern Michigan University, and a B.S. in environmental policy (with a minor in anthropology) from Michigan State University. Stiefel’s research interests pertain principally to how the sum of local preservation efforts affect regional, national and multinational policies within the field of cultural resource management and heritage conservation.", position: "Student Engagement Fellow", color: Color.green),
//                WhoWeAreOption(name: "Brittney Parker", profileImage: "todd", description: "Brittney Parker is a graduate student in the Master’s of Environmental Studies Program. She is currently researching microplastic ingestion rates in locally important fish species. Brittney is a native of Hilton Head Island, SC and completed her undergraduate degree at the University of Connecticut in natural resources management with a focus on wildlife and fisheries conservation. After graduation she worked in the Bahamas as a sea turtle research technician and science research methods teacher. After moving back to the United States, she decided to return to South Carolina to pursue her masters research on an ecosystem that is close to her heart.", position: "Student Engagement GA", color: Color.yellow),
//                WhoWeAreOption(name: "Connelly Rhodin", profileImage: "todd", description: "Connelly, or Callie, Rhodin is an alumna of the College of Charleston. During her time as a student, she studied Urban and Environmental Studies in hopes of equipping herself with the knowledge and skills to address systematic issues with holistic solutions in both environments. As an alumna, she is taking steps towards achieving that goal in her role as administrative assistant to the Sustainability Literacy Institute. Her goal is to make sure everyone involved with the QEP SLI is fully prepared and abetted in their efforts to make College of Charleston more resilient.", position: "Administrative Assistant", color: Color.blue)*/
//        ]
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = "Members"
        collectionView?.register(WhoWeAreCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
    
    func handleFullBio(fellow: WhoWeAreOption) {
        let fellowController = FellowController()
        fellowController.navigationItem.title = "Full Biography"
        fellowController.fellow = fellow
        navigationController?.pushViewController(fellowController, animated: true)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WhoWeAreCell
        let whoWeAreOption = whoWeAreOptions[indexPath.row]
        cell.whoWeAreOption = whoWeAreOption
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var fellow = whoWeAreOptions[indexPath.row]
        handleFullBio(fellow: fellow)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return whoWeAreOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 185)
    }
}

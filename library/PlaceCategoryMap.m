/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "PlaceCategoryMap.h"

@implementation PlaceCategoryMap

static const NSDictionary *map;

+ (NSDictionary*)initializeMap {
    NSMutableDictionary *categoryMap = [[NSMutableDictionary alloc] init];
    categoryMap[@(-1)] = @"InaccurateOriginalCategory";
    categoryMap[@(2)] = @"Automotive";
    categoryMap[@(3)] = @"Car Appraisers";
    categoryMap[@(4)] = @"Car Dealers and Leasing";
    categoryMap[@(5)] = @"Used Cars";
    categoryMap[@(6)] = @"Car Parts and Accessories";
    categoryMap[@(7)] = @"Car Wash and Detail";
    categoryMap[@(8)] = @"Classic and Antique Car";
    categoryMap[@(9)] = @"Maintenance and Repair";
    categoryMap[@(10)] = @"Oil and Lube";
    categoryMap[@(11)] = @"Smog Check";
    categoryMap[@(12)] = @"Tires";
    categoryMap[@(13)] = @"Transmissions";
    categoryMap[@(14)] = @"Motorcycles, Mopeds and Scooters";
    categoryMap[@(15)] = @"Repair";
    categoryMap[@(16)] = @"Sales";
    categoryMap[@(17)] = @"RVs and Motor Homes";
    categoryMap[@(18)] = @"Salvage Yards";
    categoryMap[@(19)] = @"Towing";
    categoryMap[@(20)] = @"Community and Government";
    categoryMap[@(21)] = @"Animal Shelters and Humane Societies";
    categoryMap[@(22)] = @"Cemeteries";
    categoryMap[@(23)] = @"Day Care and Preschools";
    categoryMap[@(24)] = @"Disabled Persons Services";
    categoryMap[@(25)] = @"Drug and Alcohol Services";
    categoryMap[@(26)] = @"Education";
    categoryMap[@(27)] = @"Adult Education";
    categoryMap[@(28)] = @"Art Lessons and Schools";
    categoryMap[@(29)] = @"Colleges and Universities";
    categoryMap[@(30)] = @"Computer Training";
    categoryMap[@(31)] = @"Culinary Lessons and Schools";
    categoryMap[@(32)] = @"Driving Schools";
    categoryMap[@(33)] = @"Fraternities and Sororities";
    categoryMap[@(34)] = @"Primary and Secondary Schools";
    categoryMap[@(35)] = @"Tutoring and Educational Services";
    categoryMap[@(36)] = @"Vocational Schools";
    categoryMap[@(37)] = @"Government Departments and Agencies";
    categoryMap[@(38)] = @"Government Lobbyists";
    categoryMap[@(39)] = @"Housing Assistance and Shelters";
    categoryMap[@(40)] = @"Law Enforcement and Public Safety";
    categoryMap[@(41)] = @"Rescue Services";
    categoryMap[@(42)] = @"Fire Stations";
    categoryMap[@(43)] = @"Police Stations";
    categoryMap[@(44)] = @"Libraries";
    categoryMap[@(45)] = @"Military";
    categoryMap[@(46)] = @"Bases";
    categoryMap[@(47)] = @"Organizations and Associations";
    categoryMap[@(48)] = @"Charities and Non-Profits";
    categoryMap[@(49)] = @"Environmental";
    categoryMap[@(50)] = @"Youth Organizations";
    categoryMap[@(51)] = @"Post Offices";
    categoryMap[@(52)] = @"Public and Social Services";
    categoryMap[@(53)] = @"Religious";
    categoryMap[@(54)] = @"Buddhist Temples";
    categoryMap[@(55)] = @"Churches";
    categoryMap[@(56)] = @"Hindu Temples";
    categoryMap[@(57)] = @"Mosques";
    categoryMap[@(58)] = @"Synagogues";
    categoryMap[@(59)] = @"Senior Citizen Services";
    categoryMap[@(60)] = @"Retirement";
    categoryMap[@(61)] = @"Utility Companies";
    categoryMap[@(62)] = @"Healthcare";
    categoryMap[@(63)] = @"AIDS Resources";
    categoryMap[@(64)] = @"Assisted Living Services";
    categoryMap[@(65)] = @"Home Health Care Services";
    categoryMap[@(66)] = @"Facilities and Nursing Homes";
    categoryMap[@(67)] = @"Blood Banks and Centers";
    categoryMap[@(68)] = @"Chiropractors";
    categoryMap[@(69)] = @"Dentists";
    categoryMap[@(70)] = @"Emergency Services";
    categoryMap[@(71)] = @"Ambulance";
    categoryMap[@(72)] = @"Holistic, Alternative and Naturopathic Medicine";
    categoryMap[@(73)] = @"Acupuncture";
    categoryMap[@(74)] = @"Hospitals, Clinics and Medical Centers";
    categoryMap[@(75)] = @"Medical Supplies and Labs";
    categoryMap[@(76)] = @"Mental Health";
    categoryMap[@(77)] = @"Counseling and Therapy";
    categoryMap[@(78)] = @"Psychologists";
    categoryMap[@(79)] = @"Nurses";
    categoryMap[@(80)] = @"Pharmacies";
    categoryMap[@(81)] = @"Physical Therapy and Rehabilitation";
    categoryMap[@(82)] = @"Sports Medicine";
    categoryMap[@(83)] = @"Physicians";
    categoryMap[@(84)] = @"Anesthesiologists";
    categoryMap[@(85)] = @"Cardiologists";
    categoryMap[@(86)] = @"Dermatologists";
    categoryMap[@(87)] = @"Ear, Nose and Throat";
    categoryMap[@(88)] = @"Family Medicine";
    categoryMap[@(89)] = @"Gastroenterologists";
    categoryMap[@(90)] = @"General Surgery";
    categoryMap[@(91)] = @"Internal Medicine";
    categoryMap[@(92)] = @"Neurologists";
    categoryMap[@(93)] = @"Obstetricians and Gynecologists";
    categoryMap[@(94)] = @"Oncologists";
    categoryMap[@(95)] = @"Ophthalmologists";
    categoryMap[@(96)] = @"Orthopedic Surgeons";
    categoryMap[@(97)] = @"Pathologists";
    categoryMap[@(98)] = @"Pediatricians";
    categoryMap[@(99)] = @"Plastic Surgeons";
    categoryMap[@(100)] = @"Psychiatrists";
    categoryMap[@(101)] = @"Radiologists";
    categoryMap[@(102)] = @"Respiratory";
    categoryMap[@(103)] = @"Urologists";
    categoryMap[@(104)] = @"Podiatrists";
    categoryMap[@(105)] = @"Pregnancy and Sexual Health";
    categoryMap[@(106)] = @"Weight Loss and Nutritionists";
    categoryMap[@(107)] = @"Landmarks";
    categoryMap[@(108)] = @"Buildings and Structures";
    categoryMap[@(109)] = @"Gardens";
    categoryMap[@(110)] = @"Historic and Protected Sites";
    categoryMap[@(111)] = @"Monuments and Memorials";
    categoryMap[@(112)] = @"Natural";
    categoryMap[@(113)] = @"Beaches";
    categoryMap[@(114)] = @"Mountains";
    categoryMap[@(115)] = @"Forests";
    categoryMap[@(116)] = @"Lakes";
    categoryMap[@(117)] = @"Rivers";
    categoryMap[@(118)] = @"Parks";
    categoryMap[@(119)] = @"Natural Parks";
    categoryMap[@(120)] = @"Picnic Areas";
    categoryMap[@(121)] = @"Playgrounds";
    categoryMap[@(122)] = @"Urban Parks";
    categoryMap[@(123)] = @"Retail";
    categoryMap[@(124)] = @"Adult";
    categoryMap[@(125)] = @"Antiques";
    categoryMap[@(126)] = @"Arts and Crafts";
    categoryMap[@(127)] = @"Auctions";
    categoryMap[@(128)] = @"Beauty Products";
    categoryMap[@(129)] = @"Bicycles";
    categoryMap[@(130)] = @"Bookstores";
    categoryMap[@(131)] = @"Cards and Stationery";
    categoryMap[@(132)] = @"Children";
    categoryMap[@(133)] = @"Computers and Electronics";
    categoryMap[@(134)] = @"Cameras";
    categoryMap[@(135)] = @"Mobile Phones";
    categoryMap[@(136)] = @"Video Games";
    categoryMap[@(137)] = @"Construction Supplies";
    categoryMap[@(138)] = @"Convenience Stores";
    categoryMap[@(139)] = @"Costumes";
    categoryMap[@(140)] = @"Dance and Music";
    categoryMap[@(141)] = @"Department Stores";
    categoryMap[@(142)] = @"Fashion";
    categoryMap[@(143)] = @"Clothing and Accessories";
    categoryMap[@(144)] = @"Jewelry and Watches";
    categoryMap[@(145)] = @"Shoes";
    categoryMap[@(146)] = @"Swimwear";
    categoryMap[@(147)] = @"Flea Markets";
    categoryMap[@(148)] = @"Florists";
    categoryMap[@(149)] = @"Food and Beverage";
    categoryMap[@(150)] = @"Beer, Wine and Spirits";
    categoryMap[@(151)] = @"Candy Stores";
    categoryMap[@(152)] = @"Cheese";
    categoryMap[@(153)] = @"Chocolate";
    categoryMap[@(154)] = @"Farmers' Markets";
    categoryMap[@(155)] = @"Health and Diet Food";
    categoryMap[@(156)] = @"Kosher";
    categoryMap[@(157)] = @"Furniture and Decor";
    categoryMap[@(158)] = @"Gift and Novelty";
    categoryMap[@(159)] = @"Glasses";
    categoryMap[@(160)] = @"Hobby and Collectibles";
    categoryMap[@(161)] = @"Luggage";
    categoryMap[@(162)] = @"Music, Video and DVD";
    categoryMap[@(163)] = @"Newsstands";
    categoryMap[@(164)] = @"Nurseries and Garden Centers";
    categoryMap[@(165)] = @"Outlet";
    categoryMap[@(166)] = @"Pawn Shops";
    categoryMap[@(167)] = @"Pets";
    categoryMap[@(168)] = @"Photos and Frames";
    categoryMap[@(169)] = @"Shopping Centers and Malls";
    categoryMap[@(170)] = @"Sporting Goods";
    categoryMap[@(171)] = @"Supermarkets and Groceries";
    categoryMap[@(172)] = @"Tobacco";
    categoryMap[@(173)] = @"Toys";
    categoryMap[@(174)] = @"Vintage and Thrift";
    categoryMap[@(175)] = @"Warehouses and Wholesale Stores";
    categoryMap[@(176)] = @"Wedding and Bridal";
    categoryMap[@(177)] = @"Businesses and Services";
    categoryMap[@(178)] = @"Business and Strategy Consulting";
    categoryMap[@(179)] = @"Industrial Machinery and Vehicles";
    categoryMap[@(180)] = @"Logging and Sawmills";
    categoryMap[@(181)] = @"Metals";
    categoryMap[@(182)] = @"Packaging";
    categoryMap[@(183)] = @"Petroleum";
    categoryMap[@(184)] = @"Plastics";
    categoryMap[@(185)] = @"Refrigeration and Ice";
    categoryMap[@(186)] = @"Rubber";
    categoryMap[@(187)] = @"Scientific";
    categoryMap[@(188)] = @"Security and Safety";
    categoryMap[@(189)] = @"Telecommunication Services";
    categoryMap[@(190)] = @"Textiles";
    categoryMap[@(191)] = @"Water and Waste Management";
    categoryMap[@(192)] = @"Welding";
    categoryMap[@(193)] = @"Advertising and Marketing";
    categoryMap[@(194)] = @"Advertising Agencies and Media Buyers";
    categoryMap[@(195)] = @"Creative Services";
    categoryMap[@(196)] = @"Direct Mail and Email Marketing Services";
    categoryMap[@(197)] = @"Market Research and Consulting";
    categoryMap[@(198)] = @"Online Advertising";
    categoryMap[@(199)] = @"Print, TV, Radio and Outdoor Advertising";
    categoryMap[@(200)] = @"Promotional Items";
    categoryMap[@(201)] = @"Public Relations";
    categoryMap[@(202)] = @"Search Engine Marketing and Optimization";
    categoryMap[@(203)] = @"Writing, Copywriting and Technical Writing";
    categoryMap[@(204)] = @"Agriculture and Forestry";
    categoryMap[@(205)] = @"Art Restoration";
    categoryMap[@(206)] = @"Audiovisual";
    categoryMap[@(207)] = @"Automation and Control Systems";
    categoryMap[@(208)] = @"Chemicals and Gasses";
    categoryMap[@(209)] = @"Computers";
    categoryMap[@(210)] = @"Corporate HQ";
    categoryMap[@(211)] = @"Electrical Equipment";
    categoryMap[@(212)] = @"Employment Agencies";
    categoryMap[@(213)] = @"Engineering";
    categoryMap[@(214)] = @"Entertainment";
    categoryMap[@(215)] = @"Media";
    categoryMap[@(216)] = @"Equipment Rental";
    categoryMap[@(217)] = @"Events and Event Planning";
    categoryMap[@(218)] = @"ATMs";
    categoryMap[@(219)] = @"Financial";
    categoryMap[@(220)] = @"Accounting and Bookkeeping";
    categoryMap[@(221)] = @"Banking and Finance";
    categoryMap[@(222)] = @"Business Brokers and Franchises";
    categoryMap[@(223)] = @"Check Cashing";
    categoryMap[@(224)] = @"Collections";
    categoryMap[@(225)] = @"Financial Planning and Investments";
    categoryMap[@(226)] = @"Fund Raising";
    categoryMap[@(227)] = @"Loans and Mortgages";
    categoryMap[@(228)] = @"Stock Brokers";
    categoryMap[@(229)] = @"Student Aid and Grants";
    categoryMap[@(230)] = @"Food and Beverage";
    categoryMap[@(231)] = @"Catering";
    categoryMap[@(232)] = @"Distribution";
    categoryMap[@(233)] = @"Funeral Services";
    categoryMap[@(234)] = @"Geological";
    categoryMap[@(235)] = @"Home Improvement";
    categoryMap[@(236)] = @"Architects";
    categoryMap[@(237)] = @"Carpenters";
    categoryMap[@(238)] = @"Carpet and Flooring";
    categoryMap[@(239)] = @"Contractors";
    categoryMap[@(240)] = @"Bathrooms";
    categoryMap[@(241)] = @"Deck and Patio";
    categoryMap[@(242)] = @"Sewer";
    categoryMap[@(243)] = @"Doors and Windows";
    categoryMap[@(244)] = @"Electricians";
    categoryMap[@(245)] = @"Fences, Fireplaces and Garage Doors";
    categoryMap[@(246)] = @"Hardware and Services";
    categoryMap[@(247)] = @"Heating, Ventilating and Air Conditioning";
    categoryMap[@(248)] = @"Home Appliances";
    categoryMap[@(249)] = @"Home Inspection Services";
    categoryMap[@(250)] = @"Housewares";
    categoryMap[@(251)] = @"Interior Design";
    categoryMap[@(252)] = @"Kitchens";
    categoryMap[@(253)] = @"Landscaping and Gardeners";
    categoryMap[@(254)] = @"Lighting Fixtures";
    categoryMap[@(255)] = @"Mobile Homes";
    categoryMap[@(256)] = @"Movers";
    categoryMap[@(257)] = @"Painting";
    categoryMap[@(258)] = @"Pest Control";
    categoryMap[@(259)] = @"Plumbing";
    categoryMap[@(260)] = @"Pools and Spas";
    categoryMap[@(261)] = @"Roofers";
    categoryMap[@(262)] = @"Storage";
    categoryMap[@(263)] = @"Swimming Pool Maintenance and Services";
    categoryMap[@(264)] = @"Tree Service";
    categoryMap[@(265)] = @"Upholstery";
    categoryMap[@(266)] = @"Human Resources";
    categoryMap[@(267)] = @"Import and Export";
    categoryMap[@(268)] = @"Leather";
    categoryMap[@(269)] = @"Legal";
    categoryMap[@(270)] = @"Credit Counseling and Bankruptcy Services";
    categoryMap[@(271)] = @"Immigration";
    categoryMap[@(272)] = @"Insurance";
    categoryMap[@(273)] = @"Machine Shops";
    categoryMap[@(274)] = @"Management";
    categoryMap[@(275)] = @"Manufacturing";
    categoryMap[@(276)] = @"Paper";
    categoryMap[@(277)] = @"Personal Care";
    categoryMap[@(278)] = @"Dry Cleaning, Ironing and Laundry";
    categoryMap[@(279)] = @"Hair Removal";
    categoryMap[@(280)] = @"Beauty Salons and Barbers";
    categoryMap[@(281)] = @"Manicures and Pedicures";
    categoryMap[@(282)] = @"Massage Clinics and Therapists";
    categoryMap[@(283)] = @"Piercing";
    categoryMap[@(284)] = @"Skin Care";
    categoryMap[@(285)] = @"Spas";
    categoryMap[@(286)] = @"Tanning Salons";
    categoryMap[@(287)] = @"Tattooing";
    categoryMap[@(288)] = @"Printing, Copying and Signage";
    categoryMap[@(289)] = @"Professional Cleaning";
    categoryMap[@(290)] = @"Publishing";
    categoryMap[@(291)] = @"Real Estate";
    categoryMap[@(292)] = @"Property Management";
    categoryMap[@(293)] = @"Real Estate Agents";
    categoryMap[@(294)] = @"Real Estate Appraiser";
    categoryMap[@(295)] = @"Real Estate Development and Title Companies";
    categoryMap[@(296)] = @"Apartments, Condos, and Houses";
    categoryMap[@(297)] = @"Boarding Houses";
    categoryMap[@(298)] = @"Building and Land Surveyors";
    categoryMap[@(299)] = @"Commercial Real Estate";
    categoryMap[@(300)] = @"Corporate Housing";
    categoryMap[@(301)] = @"Renewable Energy";
    categoryMap[@(302)] = @"Repair Services";
    categoryMap[@(303)] = @"Shipping, Freight, and Material Transportation";
    categoryMap[@(304)] = @"Tailors";
    categoryMap[@(305)] = @"Veterinarians";
    categoryMap[@(306)] = @"Web Design and Development";
    categoryMap[@(307)] = @"Wholesale";
    categoryMap[@(308)] = @"Social";
    categoryMap[@(309)] = @"Arts";
    categoryMap[@(310)] = @"Art Dealers and Galleries";
    categoryMap[@(311)] = @"Museums";
    categoryMap[@(312)] = @"Bars";
    categoryMap[@(313)] = @"Hotel Lounges";
    categoryMap[@(314)] = @"Jazz and Blues Cafes";
    categoryMap[@(315)] = @"Sports Bars";
    categoryMap[@(316)] = @"Wine Bars";
    categoryMap[@(317)] = @"Entertainment";
    categoryMap[@(318)] = @"Adult Entertainment";
    categoryMap[@(319)] = @"Amusement Parks";
    categoryMap[@(320)] = @"Billiard and Pool";
    categoryMap[@(321)] = @"Bingo";
    categoryMap[@(322)] = @"Bowling";
    categoryMap[@(323)] = @"Carnivals";
    categoryMap[@(324)] = @"Casinos and Gaming";
    categoryMap[@(325)] = @"Circuses";
    categoryMap[@(326)] = @"Dance Halls and Saloons";
    categoryMap[@(327)] = @"Fairgrounds and Rodeos";
    categoryMap[@(328)] = @"Go Carts";
    categoryMap[@(329)] = @"Hookah Lounges";
    categoryMap[@(330)] = @"Karaoke";
    categoryMap[@(331)] = @"Miniature Golf";
    categoryMap[@(332)] = @"Movie Theatres";
    categoryMap[@(333)] = @"Music and Show Venues";
    categoryMap[@(334)] = @"Night Clubs";
    categoryMap[@(335)] = @"Party Centers";
    categoryMap[@(336)] = @"Psychics and Astrologers";
    categoryMap[@(337)] = @"Ticket Sales";
    categoryMap[@(338)] = @"Food and Dining";
    categoryMap[@(339)] = @"Bagels and Donuts";
    categoryMap[@(340)] = @"Bakeries";
    categoryMap[@(341)] = @"Breweries";
    categoryMap[@(342)] = @"Cafes, Coffee and Tea Houses";
    categoryMap[@(343)] = @"Dessert";
    categoryMap[@(344)] = @"Ice Cream Parlors";
    categoryMap[@(345)] = @"Internet Cafes";
    categoryMap[@(346)] = @"Juice Bars and Smoothies";
    categoryMap[@(347)] = @"Restaurants";
    categoryMap[@(348)] = @"American";
    categoryMap[@(349)] = @"Barbecue";
    categoryMap[@(350)] = @"Buffets";
    categoryMap[@(351)] = @"Burgers";
    categoryMap[@(352)] = @"Chinese";
    categoryMap[@(353)] = @"Delis";
    categoryMap[@(354)] = @"Diners";
    categoryMap[@(355)] = @"Fast Food";
    categoryMap[@(356)] = @"French";
    categoryMap[@(357)] = @"Indian";
    categoryMap[@(358)] = @"Italian";
    categoryMap[@(359)] = @"Japanese";
    categoryMap[@(360)] = @"Korean";
    categoryMap[@(361)] = @"Mexican";
    categoryMap[@(362)] = @"Middle Eastern";
    categoryMap[@(363)] = @"Pizza";
    categoryMap[@(364)] = @"Seafood";
    categoryMap[@(365)] = @"Steakhouses";
    categoryMap[@(366)] = @"Sushi";
    categoryMap[@(367)] = @"Thai";
    categoryMap[@(368)] = @"Vegan and Vegetarian";
    categoryMap[@(369)] = @"Country Clubs";
    categoryMap[@(370)] = @"Wineries and Vineyards";
    categoryMap[@(371)] = @"Zoos, Aquariums and Wildlife Sanctuaries";
    categoryMap[@(372)] = @"Sports and Recreation";
    categoryMap[@(373)] = @"Athletic Fields";
    categoryMap[@(374)] = @"Baseball";
    categoryMap[@(375)] = @"Batting Ranges";
    categoryMap[@(376)] = @"Basketball";
    categoryMap[@(377)] = @"Combat Sports";
    categoryMap[@(378)] = @"Cycling";
    categoryMap[@(379)] = @"Dance";
    categoryMap[@(380)] = @"Equestrian";
    categoryMap[@(381)] = @"Football";
    categoryMap[@(382)] = @"Golf";
    categoryMap[@(383)] = @"Gun Ranges";
    categoryMap[@(384)] = @"Gymnastics";
    categoryMap[@(385)] = @"Gyms and Fitness Centers";
    categoryMap[@(386)] = @"Hockey";
    categoryMap[@(387)] = @"Outdoors";
    categoryMap[@(388)] = @"Campgrounds and RV Parks";
    categoryMap[@(389)] = @"Hiking";
    categoryMap[@(390)] = @"Hot Air Balloons";
    categoryMap[@(391)] = @"Hunting and Fishing";
    categoryMap[@(392)] = @"Rock Climbing";
    categoryMap[@(393)] = @"Skydiving";
    categoryMap[@(394)] = @"Paintball";
    categoryMap[@(395)] = @"Personal Trainers";
    categoryMap[@(396)] = @"Race Tracks";
    categoryMap[@(397)] = @"Racquet Sports";
    categoryMap[@(398)] = @"Racquetball";
    categoryMap[@(399)] = @"Tennis";
    categoryMap[@(400)] = @"Recreation Centers";
    categoryMap[@(401)] = @"Running";
    categoryMap[@(402)] = @"Skating";
    categoryMap[@(403)] = @"Snow Sports";
    categoryMap[@(404)] = @"Soccer";
    categoryMap[@(405)] = @"Sports Clubs";
    categoryMap[@(406)] = @"Stadiums and Arenas";
    categoryMap[@(407)] = @"Swimming Pools";
    categoryMap[@(408)] = @"Water Sports";
    categoryMap[@(409)] = @"Boating";
    categoryMap[@(410)] = @"Canoes and Kayaks";
    categoryMap[@(411)] = @"Rafting";
    categoryMap[@(412)] = @"Scuba Diving";
    categoryMap[@(413)] = @"Swimming";
    categoryMap[@(414)] = @"Yoga and Pilates";
    categoryMap[@(415)] = @"Transportation";
    categoryMap[@(416)] = @"Airlines and Aviation Services";
    categoryMap[@(417)] = @"Gas Stations";
    categoryMap[@(418)] = @"Parking";
    categoryMap[@(419)] = @"Public Transportation Services";
    categoryMap[@(420)] = @"Taxi and Car Services";
    categoryMap[@(421)] = @"Car and Truck Rentals";
    categoryMap[@(422)] = @"Charter Buses";
    categoryMap[@(423)] = @"Limos and Chauffeurs";
    categoryMap[@(424)] = @"Transport Hubs";
    categoryMap[@(425)] = @"Airports";
    categoryMap[@(426)] = @"Bus Stations";
    categoryMap[@(427)] = @"Heliports";
    categoryMap[@(428)] = @"Ports";
    categoryMap[@(429)] = @"Rail Stations";
    categoryMap[@(430)] = @"Travel";
    categoryMap[@(431)] = @"Cruises";
    categoryMap[@(432)] = @"Lodging";
    categoryMap[@(433)] = @"Bed and Breakfasts";
    categoryMap[@(434)] = @"Cottages and Cabins";
    categoryMap[@(435)] = @"Hostels";
    categoryMap[@(436)] = @"Hotels and Motels";
    categoryMap[@(437)] = @"Lodges and Vacation Rentals";
    categoryMap[@(438)] = @"Resorts";
    categoryMap[@(439)] = @"Tourist Information and Services";
    categoryMap[@(440)] = @"Travel Agents and Tour Operators";
    categoryMap[@(441)] = @"Geriatrics";
    categoryMap[@(442)] = @"Discount Stores";
    categoryMap[@(443)] = @"Meat and Seafood";
    categoryMap[@(444)] = @"Office Supplies";
    categoryMap[@(445)] = @"Party Supplies";
    categoryMap[@(446)] = @"Career Counseling";
    categoryMap[@(447)] = @"Construction";
    categoryMap[@(448)] = @"Notary";
    categoryMap[@(449)] = @"Photography";
    categoryMap[@(450)] = @"Translation Services";
    categoryMap[@(451)] = @"Golf Courses";
    categoryMap[@(452)] = @"Surfing";
    categoryMap[@(453)] = @"Embassies";
    categoryMap[@(454)] = @"Infrastructure";
    categoryMap[@(455)] = @"Mobile";
    categoryMap[@(456)] = @"Advertising";
    categoryMap[@(457)] = @"Asian";
    categoryMap[@(458)] = @"Food Trucks";
    categoryMap[@(459)] = @"Rest Areas";
    categoryMap[@(460)] = @"Technology";
    categoryMap[@(461)] = @"Dog Parks";
    categoryMap[@(462)] = @"International Airports";
    categoryMap[@(463)] = @"Arcades";
    categoryMap[@(464)] = @"International";
    categoryMap[@(465)] = @"Convention Centers";
    categoryMap[@(466)] = @"Optometrist";
    categoryMap[@(467)] = @"NoExport";
    categoryMap[@(468)] = @"Hardware Stores";
    categoryMap[@(469)] = @"Pet Sitting and Boarding";
    categoryMap[@(470)] = @"Grooming";
    categoryMap[@(471)] = @"Pet Supplies";
    categoryMap[@(472)] = @"Car Dealers";
    categoryMap[@(473)] = @"Banks and Credit Unions";
    categoryMap[@(474)] = @"Attorneys and Law Offices";
    categoryMap[@(475)] = @"Other Healthcare Professionals";
    categoryMap[@(476)] = @"Oral Surgeons";
    categoryMap[@(477)] = @"City Halls";
    
    return [[NSDictionary alloc] initWithDictionary:categoryMap];
}

+ (NSArray<NSString*>*)getCategoriesFromPlace:(FactualPlace*)place {
    if (!map) {
        map = [PlaceCategoryMap initializeMap];
    }
    
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    if (place.categoryIds != (id)[NSNull null]) {
        for (NSNumber *categoryId in place.categoryIds) {
            NSString *category = map[categoryId];
            if (category) {
                [categories addObject:category];
            }
        }
    }
    
    return [[NSArray alloc] initWithArray:categories];
}

@end

//
//  MockSearchItemRepository.swift
//  ml-challengeTests
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation
import RxSwift
@testable import ml_challenge

enum TestError: Error {
    case mockNotImplemented
    case mockError
}

class MockSearchItemRepository: SearchItemRepository {
    
    var searchItemResponse: Single<SearchItemResponse>?
    var searchBySellerResponse: Single<SearchItemResponse>?
    var searchByCategoryResponse: Single<SearchItemResponse>?
    
    override func searchItem(_ item: String, _ offset: Int) -> Single<SearchItemResponse> {
        return searchItemResponse ?? Single.error(TestError.mockNotImplemented)
    }
    
    override func searchBySellerId(_ sellerId: String, _ category: String) -> Single<SearchItemResponse> {
        return searchBySellerResponse ?? Single.error(TestError.mockNotImplemented)
    }
    
    override func searchByCategory(_ category: String, _ offset: Int) -> Single<SearchItemResponse> {
        return searchByCategoryResponse ?? Single.error(TestError.mockNotImplemented)
    }
}

extension MockSearchItemRepository {
    static let searchItemSuccessJSON = """
    {
        "site_id": "MLB",
        "country_default_time_zone": "GMT-03:00",
        "query": "macbook",
        "paging": {
            "total": 10864,
            "primary_results": 1000,
            "offset": 0,
            "limit": 50
        },
        "results": [
            {
                "id": "MLB2205623698",
                "title": "Macbook Air M1 2020 Cinza-espacial 13.3 , Apple M1  8gb De Ram 256gb Ssd, Apple M1 8-core Gpu 60 Hz 2560x1600px Macos - Distribuidor Autorizado",
                "condition": "new",
                "thumbnail_id": "614885-MLA49588273946_042022",
                "catalog_product_id": "MLB1018721006",
                "listing_type_id": "gold_pro",
                "permalink": "https://www.mercadolivre.com.br/macbook-air-m1-2020-133-cinza-espacial-8gb-de-ram-256gb-ssd-apple-distribuidor-autorizado/p/MLB1018721006",
                "buying_mode": "buy_it_now",
                "site_id": "MLB",
                "category_id": "MLB1652",
                "domain_id": "MLB-NOTEBOOKS",
                "thumbnail": "http://http2.mlstatic.com/D_614885-MLA49588273946_042022-I.jpg",
                "currency_id": "BRL",
                "order_backend": 1,
                "price": 7819.1,
                "original_price": 12999,
                "sale_price": null,
                "available_quantity": 1,
                "official_store_id": 2162,
                "official_store_name": "Apple",
                "use_thumbnail_id": true,
                "accepts_mercadopago": true,
                "shipping": {
                    "store_pick_up": false,
                    "free_shipping": true,
                    "logistic_type": "fulfillment",
                    "mode": "me2",
                    "tags": [
                        "fulfillment",
                        "mandatory_free_shipping"
                    ],
                    "benefits": null,
                    "promise": null,
                    "shipping_score": -1
                },
                "stop_time": "2042-03-10T04:00:00.000Z",
                "seller": {
                    "id": 480263032,
                    "nickname": "MERCADOLIVRE ELETRONICOS"
                },
                "attributes": [
                    {
                        "id": "BRAND",
                        "name": "Marca",
                        "value_id": "9344",
                        "value_name": "Apple",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "9344",
                                "name": "Apple",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "COLOR",
                        "name": "Cor",
                        "value_id": "162060",
                        "value_name": "Cinza-espacial",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "162060",
                                "name": "Cinza-espacial",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "DETAILED_MODEL",
                        "name": "Modelo detalhado",
                        "value_id": "13321630",
                        "value_name": "MGN63BE/A",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "13321630",
                                "name": "MGN63BE/A",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "GTIN",
                        "name": "Código universal de produto",
                        "value_id": null,
                        "value_name": "194252055977",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": null,
                                "name": "194252055977",
                                "struct": null,
                                "source": 385122562515662
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "ITEM_CONDITION",
                        "name": "Condição do item",
                        "value_id": "2230284",
                        "value_name": "Novo",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "2230284",
                                "name": "Novo",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "list"
                    },
                    {
                        "id": "LINE",
                        "name": "Linha",
                        "value_id": "95565",
                        "value_name": "MacBook Air",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "95565",
                                "name": "MacBook Air",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "MAIN_COLOR",
                        "name": "Cor principal",
                        "value_id": "2450294",
                        "value_name": "Cinza",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "2450294",
                                "name": "Cinza",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "list"
                    },
                    {
                        "id": "MODEL",
                        "name": "Modelo",
                        "value_id": "9770970",
                        "value_name": "M1 2020",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "9770970",
                                "name": "M1 2020",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "PACKAGE_LENGTH",
                        "name": "Comprimento da embalagem",
                        "value_id": null,
                        "value_name": "23.4 cm",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": {
                            "number": 23.4,
                            "unit": "cm"
                        },
                        "values": [
                            {
                                "id": null,
                                "name": "23.4 cm",
                                "struct": {
                                    "number": 23.4,
                                    "unit": "cm"
                                },
                                "source": 4333789534002961
                            }
                        ],
                        "source": 4333789534002961,
                        "value_type": "number_unit"
                    },
                    {
                        "id": "PACKAGE_WEIGHT",
                        "name": "Peso da embalagem",
                        "value_id": null,
                        "value_name": "2040 g",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": {
                            "number": 2040,
                            "unit": "g"
                        },
                        "values": [
                            {
                                "id": null,
                                "name": "2040 g",
                                "struct": {
                                    "number": 2040,
                                    "unit": "g"
                                },
                                "source": 4333789534002961
                            }
                        ],
                        "source": 4333789534002961,
                        "value_type": "number_unit"
                    },
                    {
                        "id": "PROCESSOR_BRAND",
                        "name": "Marca do processador",
                        "value_id": "9344",
                        "value_name": "Apple",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "9344",
                                "name": "Apple",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "list"
                    },
                    {
                        "id": "PROCESSOR_LINE",
                        "name": "Linha do processador",
                        "value_id": "13768903",
                        "value_name": "M1",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "13768903",
                                "name": "M1",
                                "struct": null,
                                "source": 8748668969142
                            }
                        ],
                        "source": 8748668969142,
                        "value_type": "string"
                    },
                    {
                        "id": "PROCESSOR_MODEL",
                        "name": "Modelo do processador",
                        "value_id": "17696",
                        "value_name": "M1",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "17696",
                                "name": "M1",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "WEIGHT",
                        "name": "Peso",
                        "value_id": "7212862",
                        "value_name": "1.29 kg",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": {
                            "number": 1.29,
                            "unit": "kg"
                        },
                        "values": [
                            {
                                "id": "7212862",
                                "name": "1.29 kg",
                                "struct": {
                                    "number": 1.29,
                                    "unit": "kg"
                                },
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "number_unit"
                    }
                ],
                "installments": {
                    "quantity": 10,
                    "amount": 781.91,
                    "rate": 0,
                    "currency_id": "BRL"
                },
                "winner_item_id": null,
                "catalog_listing": true,
                "discounts": null,
                "promotions": [],
                "differential_pricing": {
                    "id": 35713366
                },
                "inventory_id": "YAHN58244"
            }
        ]
    }
    """
    
    static let searchItemEmptyResultsJSON = """
    {
        "site_id": "MLB",
        "country_default_time_zone": "GMT-03:00",
        "query": "macbook",
        "paging": {
            "total": 10864,
            "primary_results": 1000,
            "offset": 0,
            "limit": 50
        },
        "results": []
    }
    """
    
    static let searchBySellerSuccesJSON = """
    {
        "site_id": "MLB",
        "seller": {
            "id": 480263032,
            "nickname": "MERCADOLIVRE ELETRONICOS"
        },
        "country_default_time_zone": "GMT-03:00",
        "paging": {
            "total": 40,
            "primary_results": 40,
            "offset": 0,
            "limit": 50
        },
        "results": [
            {
                "id": "MLB4688426004",
                "title": "Notebook Gamer Anv15-51-582r Ci5 16gb 512ssd 15,6 Linux",
                "condition": "new",
                "thumbnail_id": "872322-MLU76066556392_052024",
                "catalog_product_id": "MLB36710307",
                "listing_type_id": "gold_pro",
                "permalink": "https://www.mercadolivre.com.br/notebook-gamer-anv15-51-582r-ci5-16gb-512ssd-156-linux/p/MLB36710307",
                "buying_mode": "buy_it_now",
                "site_id": "MLB",
                "category_id": "MLB1652",
                "domain_id": "MLB-NOTEBOOKS",
                "thumbnail": "http://http2.mlstatic.com/D_872322-MLU76066556392_052024-I.jpg",
                "currency_id": "BRL",
                "order_backend": 1,
                "price": 4800,
                "original_price": 4999,
                "sale_price": null,
                "available_quantity": 500,
                "official_store_id": 2707,
                "official_store_name": "Mercado Livre",
                "use_thumbnail_id": true,
                "accepts_mercadopago": true,
                "shipping": {
                    "store_pick_up": false,
                    "free_shipping": true,
                    "logistic_type": "fulfillment",
                    "mode": "me2",
                    "tags": [
                        "fulfillment",
                        "mandatory_free_shipping"
                    ],
                    "benefits": null,
                    "promise": null,
                    "shipping_score": -1
                },
                "stop_time": "2044-05-11T04:00:00.000Z",
                "seller": {
                    "id": 480263032,
                    "nickname": "MERCADOLIVRE ELETRONICOS"
                },
                "attributes": [
                    {
                        "id": "ALPHANUMERIC_MODEL",
                        "name": "Modelo alfanumérico",
                        "value_id": "37474104",
                        "value_name": "NH.QQDAL.005",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "37474104",
                                "name": "NH.QQDAL.005",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "BRAND",
                        "name": "Marca",
                        "value_id": "15903",
                        "value_name": "Acer",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "15903",
                                "name": "Acer",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "COLOR",
                        "name": "Cor",
                        "value_id": "52049",
                        "value_name": "Preto",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "52049",
                                "name": "Preto",
                                "struct": null,
                                "source": 8748668969142
                            }
                        ],
                        "source": 8748668969142,
                        "value_type": "string"
                    },
                    {
                        "id": "GTIN",
                        "name": "Código universal de produto",
                        "value_id": null,
                        "value_name": "4711474013187",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": null,
                                "name": "4711474013187",
                                "struct": null,
                                "source": 8748668969142
                            }
                        ],
                        "source": 8748668969142,
                        "value_type": "string"
                    },
                    {
                        "id": "ITEM_CONDITION",
                        "name": "Condição do item",
                        "value_id": "2230284",
                        "value_name": "Novo",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "2230284",
                                "name": "Novo",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "list"
                    },
                    {
                        "id": "LINE",
                        "name": "Linha",
                        "value_id": "36747076",
                        "value_name": "Nitro V15",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "36747076",
                                "name": "Nitro V15",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "MAIN_COLOR",
                        "name": "Cor principal",
                        "value_id": "2450295",
                        "value_name": "Preto",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "2450295",
                                "name": "Preto",
                                "struct": null,
                                "source": 8748668969142
                            }
                        ],
                        "source": 8748668969142,
                        "value_type": "list"
                    },
                    {
                        "id": "MODEL",
                        "name": "Modelo",
                        "value_id": "37474105",
                        "value_name": "ANV15-51-582R",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "37474105",
                                "name": "ANV15-51-582R",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "PACKAGE_LENGTH",
                        "name": "Comprimento da embalagem",
                        "value_id": null,
                        "value_name": "31.6 cm",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": {
                            "number": 31.6,
                            "unit": "cm"
                        },
                        "values": [
                            {
                                "id": null,
                                "name": "31.6 cm",
                                "struct": {
                                    "number": 31.6,
                                    "unit": "cm"
                                },
                                "source": 4333789534002961
                            }
                        ],
                        "source": 4333789534002961,
                        "value_type": "number_unit"
                    },
                    {
                        "id": "PACKAGE_WEIGHT",
                        "name": "Peso da embalagem",
                        "value_id": null,
                        "value_name": "3170 g",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": {
                            "number": 3170,
                            "unit": "g"
                        },
                        "values": [
                            {
                                "id": null,
                                "name": "3170 g",
                                "struct": {
                                    "unit": "g",
                                    "number": 3170
                                },
                                "source": 4333789534002961
                            }
                        ],
                        "source": 4333789534002961,
                        "value_type": "number_unit"
                    },
                    {
                        "id": "PROCESSOR_BRAND",
                        "name": "Marca do processador",
                        "value_id": "7855833",
                        "value_name": "Intel",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "7855833",
                                "name": "Intel",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "list"
                    },
                    {
                        "id": "PROCESSOR_LINE",
                        "name": "Linha do processador",
                        "value_id": "7769178",
                        "value_name": "Core i5",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "7769178",
                                "name": "Core i5",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "PROCESSOR_MODEL",
                        "name": "Modelo do processador",
                        "value_id": "23004886",
                        "value_name": "13420H",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "23004886",
                                "name": "13420H",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "WEIGHT",
                        "name": "Peso",
                        "value_id": "946904",
                        "value_name": "4.3 kg",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": {
                            "number": 4.3,
                            "unit": "kg"
                        },
                        "values": [
                            {
                                "id": "946904",
                                "name": "4.3 kg",
                                "struct": {
                                    "number": 4.3,
                                    "unit": "kg"
                                },
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "number_unit"
                    }
                ],
                "installments": {
                    "quantity": 10,
                    "amount": 480,
                    "rate": 0,
                    "currency_id": "BRL"
                },
                "winner_item_id": null,
                "catalog_listing": true,
                "discounts": null,
                "promotions": [],
                "differential_pricing": {
                    "id": 35713366
                },
                "inventory_id": "IOIG46082"
            }
        ]
    }
    """
    
    static let searchBySellerEmptyJSON = """
    {
        "site_id": "MLB",
        "seller": {
            "id": 480263032,
            "nickname": "MERCADOLIVRE ELETRONICOS"
        },
        "country_default_time_zone": "GMT-03:00",
        "paging": {
            "total": 40,
            "primary_results": 40,
            "offset": 0,
            "limit": 50
        },
        "results": []
    }
    """
    
    static let searchByCategorySuccessJSON = """
    {
        "site_id": "MLB",
        "country_default_time_zone": "GMT-03:00",
        "paging": {
            "total": 47239,
            "primary_results": 1000,
            "offset": 400,
            "limit": 50
        },
        "results": [
            {
                "id": "MLB3684698569",
                "title": "Notebook Asus Vivobook Go 15 E1504ga Intel Core I3 N305 8gb Ram 256gb Ssd Windows 11 Home Tela 15,6  Fhd Silver - Nj434w",
                "condition": "new",
                "thumbnail_id": "982406-MLU74678297529_022024",
                "catalog_product_id": "MLB34017480",
                "listing_type_id": "gold_special",
                "permalink": "https://www.mercadolivre.com.br/notebook-asus-vivobook-go-15-e1504ga-intel-core-i3-n305-8gb-ram-256gb-ssd-windows-11-home-tela-156-fhd-silver-nj434w/p/MLB34017480",
                "buying_mode": "buy_it_now",
                "site_id": "MLB",
                "category_id": "MLB1652",
                "domain_id": "MLB-NOTEBOOKS",
                "thumbnail": "http://http2.mlstatic.com/D_982406-MLU74678297529_022024-I.jpg",
                "currency_id": "BRL",
                "order_backend": 1,
                "price": 2575.08,
                "original_price": 2575.08,
                "sale_price": null,
                "available_quantity": 1,
                "official_store_id": 2053,
                "official_store_name": "Asus",
                "use_thumbnail_id": true,
                "accepts_mercadopago": true,
                "shipping": {
                    "store_pick_up": false,
                    "free_shipping": true,
                    "logistic_type": "cross_docking",
                    "mode": "me2",
                    "tags": [
                        "mandatory_free_shipping"
                    ],
                    "benefits": null,
                    "promise": null,
                    "shipping_score": -1
                },
                "stop_time": "2044-05-04T04:00:00.000Z",
                "seller": {
                    "id": 353148713,
                    "nickname": "ACBZIMPORTACAOECOMERCIOLTD"
                },
                "attributes": [
                    {
                        "id": "ALPHANUMERIC_MODEL",
                        "name": "Modelo alfanumérico",
                        "value_id": "20502460",
                        "value_name": "E1504GA",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "20502460",
                                "name": "E1504GA",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "BRAND",
                        "name": "Marca",
                        "value_id": "7294334",
                        "value_name": "Asus",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "7294334",
                                "name": "Asus",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "COLOR",
                        "name": "Cor",
                        "value_id": "124682",
                        "value_name": "Prata metálico",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "124682",
                                "name": "Prata metálico",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "GTIN",
                        "name": "Código universal de produto",
                        "value_id": null,
                        "value_name": "7898573299784",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": null,
                                "name": "7898573299784",
                                "struct": null,
                                "source": 252977589148881
                            }
                        ],
                        "source": 252977589148881,
                        "value_type": "string"
                    },
                    {
                        "id": "ITEM_CONDITION",
                        "name": "Condição do item",
                        "value_id": "2230284",
                        "value_name": "Novo",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "2230284",
                                "name": "Novo",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "list"
                    },
                    {
                        "id": "LINE",
                        "name": "Linha",
                        "value_id": "13488192",
                        "value_name": "VivoBook Go 15",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "13488192",
                                "name": "VivoBook Go 15",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "MODEL",
                        "name": "Modelo",
                        "value_id": "34245099",
                        "value_name": "E1504GA-NJ434W",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "34245099",
                                "name": "E1504GA-NJ434W",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "PROCESSOR_BRAND",
                        "name": "Marca do processador",
                        "value_id": "7855833",
                        "value_name": "Intel",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "7855833",
                                "name": "Intel",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "list"
                    },
                    {
                        "id": "PROCESSOR_LINE",
                        "name": "Linha do processador",
                        "value_id": "12840706",
                        "value_name": "Intel Core i3",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "12840706",
                                "name": "Intel Core i3",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "PROCESSOR_MODEL",
                        "name": "Modelo do processador",
                        "value_id": "16588989",
                        "value_name": "N305",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": null,
                        "values": [
                            {
                                "id": "16588989",
                                "name": "N305",
                                "struct": null,
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "string"
                    },
                    {
                        "id": "WEIGHT",
                        "name": "Peso",
                        "value_id": "7518316",
                        "value_name": "1.63 kg",
                        "attribute_group_id": "OTHERS",
                        "attribute_group_name": "Outros",
                        "value_struct": {
                            "number": 1.63,
                            "unit": "kg"
                        },
                        "values": [
                            {
                                "id": "7518316",
                                "name": "1.63 kg",
                                "struct": {
                                    "number": 1.63,
                                    "unit": "kg"
                                },
                                "source": 1
                            }
                        ],
                        "source": 1,
                        "value_type": "number_unit"
                    }
                ],
                "installments": {
                    "quantity": 12,
                    "amount": 249.65,
                    "rate": 16.34,
                    "currency_id": "BRL"
                },
                "winner_item_id": null,
                "catalog_listing": true,
                "discounts": null,
                "promotions": [],
                "inventory_id": null
            }
        ]
    }
    """
    
    static let searchByCategoryEmptyJSON = """
    {
        "site_id": "MLB",
        "country_default_time_zone": "GMT-03:00",
        "paging": {
            "total": 47239,
            "primary_results": 1000,
            "offset": 400,
            "limit": 50
        },
        "results": []
    }
    """
}

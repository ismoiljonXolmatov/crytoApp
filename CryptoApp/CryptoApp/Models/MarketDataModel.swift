//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 18.03.2024.
//

import Foundation

// JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
 "data": {
 "active_cryptocurrencies": 13383,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 1005,
 "total_market_cap": {
 "btc": 39736368.33128825,
 "eth": 753043020.7196752,
 "ltc": 31913011911.82468,
 "bch": 6691806879.036219,
 "bnb": 4756493816.469667,
 "eos": 2675028842066.11,
 "xrp": 4425551274586.774,
 "xlm": 20663568293951.715,
 "link": 140462250335.90207,
 "dot": 263677811230.86182,
 "yfi": 297407916.1880302,
 "usd": 2712086565210.118,
 "aed": 9959866702077.627,
 "ars": 2307361995567274,
 "aud": 4127359106312.787,
 "bdt": 297769042363546.6,
 "bhd": 1022312894496.26,
 "bmd": 2712086565210.118,
 "brl": 13549310559046.68,
 "cad": 3672295389449.628,
 "chf": 2393180442266.7554,
 "clp": 2558989278604008,
 "cny": 19238186050317.965,
 "czk": 62580583866254.08,
 "dkk": 18546525325678.99,
 "eur": 2486958971518.591,
 "gbp": 2128662503302.1174,
 "gel": 7200589830632.879,
 "hkd": 21206659160645.94,
 "huf": 981967721178652.1,
 "idr": 42626023790994080,
 "ils": 9892484911364.982,
 "inr": 224854199093233.9,
 "jpy": 404303852685232.1,
 "krw": 3614121170595083.5,
 "kwd": 833586926682.9819,
 "lkr": 828313553701847.5,
 "mmk": 5698173676653643,
 "mxn": 45258674108229.81,
 "myr": 12796980457943.94,
 "ngn": 4245771517836456.5,
 "nok": 28704873370944.957,
 "nzd": 4451005956572.14,
 "php": 150813709718204.16,
 "pkr": 758122065716423,
 "pln": 10716603943848.824,
 "rub": 249501983520771.06,
 "sar": 10171336227826.78,
 "sek": 28125832040926.36,
 "sgd": 3627253055774.6196,
 "thb": 97485948874391.02,
 "try": 87598494883604.62,
 "twd": 85882289217226.3,
 "uah": 105251764666079.27,
 "vef": 271561227774.4891,
 "vnd": 67056173526072296,
 "zar": 51094856581290.484,
 "xdr": 2031266050572.2925,
 "xag": 107727224390.56151,
 "xau": 1255451991.9014144,
 "bits": 39736368331288.25,
 "sats": 3973636833128825
 },
 "total_volume": {
 "btc": 2135044.379996935,
 "eth": 40461177.92846958,
 "ltc": 1714693606.699502,
 "bch": 359552351.3874152,
 "bnb": 255567527.1247039,
 "eos": 143729926398.07748,
 "xrp": 237785906815.1143,
 "xlm": 1110258365557.4387,
 "link": 7547069618.469781,
 "dot": 14167470572.671053,
 "yfi": 15979797.014410937,
 "usd": 145721046544.60074,
 "aed": 535145971330.3911,
 "ars": 123975100597591.78,
 "aud": 221763971752.38788,
 "bdt": 15999200408427.17,
 "bhd": 54929111331.8477,
 "bmd": 145721046544.60074,
 "brl": 728007630711.1251,
 "cad": 197313291631.6234,
 "chf": 128586145844.56075,
 "clp": 137495093467158.08,
 "cny": 1033672243664.125,
 "czk": 3362469432702.7075,
 "dkk": 996509150884.9015,
 "eur": 133624888191.97995,
 "gbp": 114373535011.92622,
 "gel": 386889378575.9158,
 "hkd": 1139438765061.894,
 "huf": 52761355717303.13,
 "idr": 2290306244844169,
 "ils": 531525531928.9906,
 "inr": 12081468796802.775,
 "jpy": 21723340726309.613,
 "krw": 194187577223336.4,
 "kwd": 44788820865.94849,
 "lkr": 44505481300210.32,
 "mmk": 306164206632000.94,
 "mxn": 2431759163174.541,
 "myr": 687584758120.6985,
 "ngn": 228126298365573.34,
 "nok": 1542319571285.613,
 "nzd": 239153592841.78796,
 "php": 8103255956252.152,
 "pkr": 40734076206078.9,
 "pln": 575805640621.4523,
 "rub": 13405800028651.992,
 "sar": 546508278492.6146,
 "sek": 1511207544964.1558,
 "sgd": 194893156490.61078,
 "thb": 5237942872324.62,
 "try": 4706687652936.977,
 "twd": 4614475520404.6045,
 "uah": 5655201974210.893,
 "vef": 14591048390.51087,
 "vnd": 3602943913679451.5,
 "zar": 2745338614770.611,
 "xdr": 109140400788.41656,
 "xag": 5788209005.165531,
 "xau": 67455729.65596105,
 "bits": 2135044379996.9348,
 "sats": 213504437999693.5
 },
 "market_cap_percentage": {
 "btc": 49.470153409370006,
 "eth": 15.945536527281554,
 "usdt": 3.808128316844707,
 "sol": 3.3779370281279393,
 "bnb": 3.23463785459203,
 "steth": 1.2995633560727846,
 "xrp": 1.2382643401791107,
 "usdc": 1.1369254514432579,
 "avax": 0.8886241652302084,
 "ada": 0.8895309886945306
 },
 "market_cap_change_percentage_24h_usd": 1.7093595191275563,
 "updated_at": 1710762645
 }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, MarketCapPercentage: [String : Double]
    let marketCapPercentageChange24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case MarketCapPercentage = "market_cap_percentage"
        case marketCapPercentageChange24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = MarketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}

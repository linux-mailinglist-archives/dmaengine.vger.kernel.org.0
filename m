Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3802449E782
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jan 2022 17:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbiA0Q3k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jan 2022 11:29:40 -0500
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:61568
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229836AbiA0Q3j (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 27 Jan 2022 11:29:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O07W4LGD1YssuSouCxaquJSau3HQcYYZKY/IGZH/eAQbFKax+MIqkhZ0huaDxFoXubskVtrp2RPArSSPqhykuhKqC3tg1G7pJ4OpDkFkJ7pw8XkOqWnwaoOubAZXti0olZunj8ns6DaJyrIZ9msYA65nNWJt93FEzXY/F+z3NvKN4Jl84Vsjx57kjTbKf9aL79SdkqUfyGDVroGAsFKs0MGBlM8dVm5NVwNBBqZYK4BcvjpvWEh/nku/deJ+duN1uXWAOM0YyVSbwSy5sYEGSgG+EdO7uDwD5w26JRPnRn4EvsOm0LxSA/5+WOim2AUhW3tJa+Kcx0fxIG1ochRz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JsBT/I1V1HNCyU2tHpyQgTREfutIRRyaecGyU+9a3w=;
 b=Ni80Tw1IZr0LUBYn7G+CEHdbNfgTQESkJN6j4zKklr81IROkg+i8PaU7kBZCo6limdEBId2J5hizK5ByiMmm89fPdECHTPSVCj7D6TcTPNZ3K1G3YcelCmy7ClJ6wEgM31pe4ipbe0oXjy+PygOENhVEM4WojP198CA6dy5DOGm7gajrOQn5p7SjGMnieA1drsFZmJumN3izjaLN0XXce3K8/349ZCZUhn7wg8U6CH9AvBWf4gDccN7YpBj7wrY7XUt8JUiTO5Kyo7h0lKfYXawaMksLkSTkmg3H4NN39yharxLiGNHKWbTBzYb3aKC36pQPdwbgipHHLAxVXS1Fng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JsBT/I1V1HNCyU2tHpyQgTREfutIRRyaecGyU+9a3w=;
 b=BE2kps5bHgzZavcuWL03xxHJLLpaS/rQwpWM7p9x0uCqX6tQgMf67cy2lWXi/2r6/l1Czm+TJSw1T6M7lFPSrmRlyCGIJiLru5AnO6xgYLQqMjC9QizNskEpM7bPHBrNErYqN8pjrUPOxI3xUGf/G1aDkTy/8o8Rl63RANoW1wipwwMTucs9xGKk1hhBX75yrNhH4cSgNNa8dQK04oHP8jvkLNrnvIZJpkoywKu2PAb/GUD7gt8aqNZ4zf5kl6pmes0z4C7olf1Nfnzz01hbbBDeozREVIq91wNJiiAvd9oD5Ind0WTdl9GvUYwqyxrIvMvkWfLrXqZbgUtDqAEN/Q==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by SN6PR12MB4733.namprd12.prod.outlook.com (2603:10b6:805:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Thu, 27 Jan
 2022 16:29:37 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851%11]) with mapi id 15.20.4909.019; Thu, 27 Jan
 2022 16:29:37 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYBjv6V3jR20SoJ0WlGaDgyuzZEaxib1oAgARSzJCAAKKnAIAA14lggACbUICABOB+0IABt/qAgAFghpCAAF1jgIACgP5Q
Date:   Thu, 27 Jan 2022 16:29:36 +0000
Message-ID: <DM5PR12MB1850677D5F07065BDC08EE24C0219@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
 <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
 <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
 <1db14c3d-6a96-96dd-be76-b81b3a48a2b1@gmail.com>
 <DM5PR12MB1850FF1DC4DC1714E31AADB5C0589@DM5PR12MB1850.namprd12.prod.outlook.com>
 <683a71b1-049a-bddf-280d-5d5141b59686@gmail.com>
 <DM5PR12MB1850D67F9B5640943F1AEB2EC05B9@DM5PR12MB1850.namprd12.prod.outlook.com>
 <31ba2627-65c7-1340-e6b9-7c328a485456@gmail.com>
 <DM5PR12MB18502DF12B324E50D5E50BC0C05D9@DM5PR12MB1850.namprd12.prod.outlook.com>
 <80a90a28-d9b8-1ba6-b79e-07fd49cc92b7@gmail.com>
In-Reply-To: <80a90a28-d9b8-1ba6-b79e-07fd49cc92b7@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5564f34f-8771-43ef-c6a8-08d9e1b235a6
x-ms-traffictypediagnostic: SN6PR12MB4733:EE_
x-microsoft-antispam-prvs: <SN6PR12MB473397782917D65CE3DE6C61C0219@SN6PR12MB4733.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vDKkzwZwuutckXyxxXNLKqZcFwUnFZHyNos0yKG7C01aEKtKWpqWLnFlizoC/u161k58Pbb9mP2Nbf+5xozaFz6jAdpjr/Mhovu5H5WI449Ohg9RT8TBcLiNVzYUptxMOab359p+XUCWv+sYMn/WTGFlOcV4ZmAoAvOyNjviCSDJKn13HBSRj8Tk88DQBoDIlyHu6R7ACqD5fDefkGy99aOORYS+lwhlhdfD2lzxAPaG6IiLCnAGifmdzxKaVkYgzffvLpXjLJGAc6ndFkdgbQ6WjM5p7Kt/bEJPSI0zOpKerv3Ug2LYd9CCigWJI1yZjQpeM9+RwkVzJFBHwftiUXc07EDTjyhQVT/7jsAUYv7ppRi0RyEpaw7YdgtdDDc2RCeRZkW2pHB6U9z354rdxuTDsPBaIKYRJjgthfQ0s+p2Gyk8SMVe4uXuH0DyIeFt6Yo/YwzrQh+uIFjafWWq+13ZnyPiVCSAdpAKpP5MJLNpXXjnZ8HsLnw8yI16ThwvVaYVCcZ1Ly1jtU047p3CafQAxHcUD9Fhsvf4mQs0iKqiL1WwN+Ej5NC1Rwxm3Sc1CQ59MGvRPkMyBtQmspcfJ337lXm3oFWGmcw8OwyVG1G5TmmVs50PzA48ymIsjuphUijXWdn+KDRzn+NbFgSAcC26QQyPvjiHMN+kesyada1NnY8W7H3VoN3S3/a0oiJpDUxnfqNjUR7EhMrY58T2zC711RRAA47qRYf4QpzNbw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(107886003)(55016003)(66946007)(921005)(8936002)(26005)(122000001)(38070700005)(5660300002)(110136005)(86362001)(52536014)(71200400001)(316002)(2906002)(9686003)(186003)(7696005)(76116006)(55236004)(508600001)(8676002)(66476007)(66556008)(66446008)(33656002)(83380400001)(6506007)(7416002)(64756008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZyekc3b2VsWHRFTUE3S2s0NVZBeTJrTTlEZ2kvOHJmT05HV0ZhUmhId0Js?=
 =?utf-8?B?L2pXWWY4ZCt4WVF4WGphcFluVHhpK2tkOCt1blRFcmZ3M21CaHVkdDF4KzVO?=
 =?utf-8?B?YVhOQk9zMW1ZZXRUbThJUG95TW9OM3Y5YjAvY25ibW9obzN0N0p2a0VMQ1pm?=
 =?utf-8?B?L1hRaU9UYm1HNFBXQVV2NmVFQlF2ODF4bmI0eU1FL2lSWU1hQWEyMGJ4UlVM?=
 =?utf-8?B?QzBidmpPaGZ2V3BjcklHRWpBZFJ2K3FCZVlQdGN1U0x0NHc3aHc5MkdoTGtG?=
 =?utf-8?B?K2V0ZzZsOG9RdXljdytKbmxOcjRvNG5KYzBCSENuM1M3b3Rac3dFeTUxYTE4?=
 =?utf-8?B?aWJmVFBDbXNMSUJRcFc0TmlCcURtc0FqWVpTS3RRRmVwcXhuV3EzYjRZakJ5?=
 =?utf-8?B?KzE3R0tpTWJtd0dxUUhCUFNKVk5JSDVLLzJkUGo2YnFhbEZnL2FOOUVxMHJr?=
 =?utf-8?B?RE9HVWNYZjh4eGpiTENka0xoTDBOSjJrWUhzazdhYTVNWmt4Y1ZxMThKWmE2?=
 =?utf-8?B?NGRkbHVtM1FtTUgvRVRaaGRaU2REdFVkZUY5Z1RXVHRqS2l3Y09OZW52MzM4?=
 =?utf-8?B?TFdUUDZpZWgwd1NVb3UvQzRKTEE2N3hXMlorTHdWNlJOOWdOcUFWMjI4U3Ey?=
 =?utf-8?B?ZGtzWW02V3RGNXFxZC9QMVNlVTFPZXdId2xtZjY3NTR6dnpOWk0yWmFNQ255?=
 =?utf-8?B?RnJaQVFGdHpnNXZLczRKZWlQZHIzdzNyMklGbXVuYmtyWEdLeDJZYVpPdS9p?=
 =?utf-8?B?N3FVZnoxVVJCMmU3NVZNcTZUNEhwVTNrZjdjRkloZndMSkFVRHo2clgxYVFR?=
 =?utf-8?B?OEZSZXlMdFJvN3N6Smx4ZW4xKzBJSEhxY0RpL3VKQzlqcXFYbit6aXZQdzlZ?=
 =?utf-8?B?cVN2KytNMldsb3J1Mm56VHJOWk9uSkJaWjYrejV1R3J0S0dqVmU5VXExNGJ1?=
 =?utf-8?B?TkNzSWNod2ZxR2JWUHJtVXpCR2lTbEt0U1lWSEhZeG5FWnNCd2hJUmQrS0lJ?=
 =?utf-8?B?UW9IcmFSL0N1aWUwVUd4QVpnMjU4aFc1bTU1Y3kxY0ZUcjM5U1RhV1Ntek9i?=
 =?utf-8?B?dE5LY0xiZGp0QWtWTEl6TGJvRmhyOWI1WXJmb05pSjRmWGFHcWljQzk5eGRB?=
 =?utf-8?B?a1pyVzIvM0RFSmZ6eEpzY00vSmZ2YmFQN0JKcG1iWDBwTlFiL2Y1L1U3WXJ4?=
 =?utf-8?B?TlIzbTRMQzVPREpmdlFXT0FLMUVaalY1Q25uN1RkTERyT3dsajRLU3AzMVYv?=
 =?utf-8?B?dVQ2TFRlUjZacytISUNFSW1yb29IYTRtTFBGRFN6Z3RIWUlueUhQWUR6Tklm?=
 =?utf-8?B?OFhxU3pjbzVYbnNROXJzMjlBRGpseXJwS0lObHh6SndLZGxJazVBV0RGTWdw?=
 =?utf-8?B?cDYzOEpQY2xVZDNOK0lDdWpDQTkvNjBYZUFMWnpHZ2xTdjV1QzRjcE44a3l4?=
 =?utf-8?B?OTB6RThDUitkTU5HQnJLVjhNdEJ6K1UwVDdDR3VucG1hTTcvdFRsNEpvWThn?=
 =?utf-8?B?Rnh0YS9jb0I4Sm11SDg4d1IvbFIyV2t2ZllCbWwrUG03eFZtVk4vN0I1ZzUx?=
 =?utf-8?B?cmpGcU5mOHBRWmJpK0oyZFExVWh1N2dBZS84MGRSRGNzVzJtMjZwOGxEajVC?=
 =?utf-8?B?SHNsYytRdktxemxqbXM2VjdEeW1nMEdQVGYvWnZjSU1KL0lOSGVRWHAzbThy?=
 =?utf-8?B?elZCdTBZWlVhSFMvVkFhYTZZeXZHcFJ3WDU3SUdwd2wrRzhzbXZZRDlkM1pM?=
 =?utf-8?B?U2ZNOVhBTEtESEIzQmZCTFNadUFjZVFlNXpFbVIzOStHdzhoWXlXY1JqSldq?=
 =?utf-8?B?akJnT1AzSnlna09HNlBqVWFoWFhYbHpudU5CN2diNkFQREZCYXArYW1Lbm5X?=
 =?utf-8?B?YTh3cWpuMFFVLzRBc1JKRm4rY1RsYWR5QXBlcWxwTVJ5Y0xPbXdseVpXWEVm?=
 =?utf-8?B?QW51QWs4WXNhaTRMVU5Xb1QzWE16WW81bUFhMG44dmJndVNCSVI2UkdJMGJM?=
 =?utf-8?B?R25Mdiswa3J5VytHSE9ydGZoR0J4SEFRWWJoMHpZbDdvdmpDVDM5UDJjNVha?=
 =?utf-8?B?R0ltbndsRG4yTVUxcDBrc3F5SG1FTnd5ZFhNZkZnOC8vTkt1Nk8yMlE3MktK?=
 =?utf-8?B?U0tnTE5ldnZYVW5WcGlNaGxzMXBFSkJWaFlOYVZmK25FMG5ZNUcxVlVna0pN?=
 =?utf-8?Q?i35q2yQHsycWTUMyQOMGi2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5564f34f-8771-43ef-c6a8-08d9e1b235a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 16:29:36.8624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErRmm8fWEuZtBzaq5EWXq4fqMDLuLc3hjpiy7akgT04n8olF42Sqs1kCLE785Y/MlswbKIN56WkQqLl5rMuD8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4733
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAyMy4wMS4yMDIyIDE5OjQ5LCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4+IDIxLjAxLjIwMjIg
MTk6MjQsIEFraGlsIFIg0L/QuNGI0LXRgjoNCj4gPj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHRlZ3Jh
X2RtYV90ZXJtaW5hdGVfYWxsKHN0cnVjdCBkbWFfY2hhbiAqZGMpIHsNCj4gPj4+Pj4+Pj4+ICsg
ICAgIHN0cnVjdCB0ZWdyYV9kbWFfY2hhbm5lbCAqdGRjID0gdG9fdGVncmFfZG1hX2NoYW4oZGMp
Ow0KPiA+Pj4+Pj4+Pj4gKyAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4+Pj4+Pj4+ICsg
ICAgIExJU1RfSEVBRChoZWFkKTsNCj4gPj4+Pj4+Pj4+ICsgICAgIGludCBlcnI7DQo+ID4+Pj4+
Pj4+PiArDQo+ID4+Pj4+Pj4+PiArICAgICBpZiAodGRjLT5kbWFfZGVzYykgew0KPiA+Pj4+Pj4+
Pg0KPiA+Pj4+Pj4+PiBOZWVkcyBsb2NraW5nIHByb3RlY3Rpb24gYWdhaW5zdCByYWNpbmcgd2l0
aCB0aGUgaW50ZXJydXB0IGhhbmRsZXIuDQo+ID4+Pj4+Pj4gdGVncmFfZG1hX3N0b3BfY2xpZW50
KCkgd2FpdHMgZm9yIHRoZSBpbi1mbGlnaHQgdHJhbnNmZXIgdG8NCj4gPj4+Pj4+PiBjb21wbGV0
ZSBhbmQgcHJldmVudHMgYW55IGFkZGl0aW9uYWwgdHJhbnNmZXIgdG8gc3RhcnQuDQo+ID4+Pj4+
Pj4gV291bGRuJ3QgaXQgbWFuYWdlIHRoZSByYWNlPyBEbyB5b3Ugc2VlIGFueSBwb3RlbnRpYWwg
aXNzdWUgdGhlcmU/DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gWW91IHNob3VsZCBjb25zaWRlciBpbnRl
cnJ1cHQgaGFuZGxlciBsaWtlIGEgcHJvY2VzcyBydW5uaW5nIGluIGENCj4gPj4+Pj4+IHBhcmFs
bGVsIHRocmVhZC4gVGhlIGludGVycnVwdCBoYW5kbGVyIHNldHMgdGRjLT5kbWFfZGVzYyB0byBO
VUxMLA0KPiA+Pj4+Pj4gaGVuY2UgeW91J2xsIGdldCBOVUxMIGRlcmVmZXJlbmNlIGluIHRlZ3Jh
X2RtYV9zdG9wX2NsaWVudCgpLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJcyBpdCBiZXR0ZXIgaWYgSSBy
ZW1vdmUgdGhlIGJlbG93IHBhcnQgZnJvbSB0ZWdyYV9kbWFfc3RvcF9jbGllbnQoKQ0KPiA+Pj4+
PiBzbyB0aGF0IGRtYV9kZXNjIGlzIG5vdCBhY2Nlc3NlZCBhdCBhbGw/DQo+ID4+Pj4+DQo+ID4+
Pj4+ICsgICAgIHdjb3VudCA9IHRkY19yZWFkKHRkYywgVEVHUkFfR1BDRE1BX0NIQU5fWEZFUl9D
T1VOVCk7DQo+ID4+Pj4+ICsgICAgIHRkYy0+ZG1hX2Rlc2MtPmJ5dGVzX3RyYW5zZmVycmVkICs9
DQo+ID4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICB0ZGMtPmRtYV9kZXNjLT5ieXRlc19yZXF1
ZXN0ZWQgLSAod2NvdW50ICogNCk7DQo+ID4+Pj4+DQo+ID4+Pj4+IEJlY2F1c2UgSSBkb24ndCBz
ZWUgYSBwb2ludCBpbiB1cGRhdGluZyB0aGUgdmFsdWUgdGhlcmUuIGRtYV9kZXNjIGlzDQo+ID4+
Pj4+IHNldCB0byBOVUxMIGluIHRoZSBuZXh0IHN0ZXAgaW4gdGVybWluYXRlX2FsbCgpIGFueXdh
eS4NCj4gPj4+Pg0KPiA+Pj4+IFRoYXQgaXNuJ3QgZ29pbmcgaGVscCB5b3UgbXVjaCBiZWNhdXNl
IHlvdSBhbHNvIGNhbid0IHJlbGVhc2UgRE1BDQo+ID4+Pj4gZGVzY3JpcHRvciB3aGlsZSBpbnRl
cnJ1cHQgaGFuZGxlciBzdGlsbCBtYXkgYmUgcnVubmluZyBhbmQgdXNpbmcNCj4gPj4+PiB0aGF0
IGRlc2NyaXB0b3IuDQo+ID4+Pg0KPiA+Pj4gRG9lcyB0aGUgYmVsb3cgZnVuY3Rpb25zIGxvb2sg
Z29vZCB0byByZXNvbHZlIHRoZSBpc3N1ZSwgcHJvdmlkZWQNCj4gPj4+IHRlZ3JhX2RtYV9zdG9w
X2NsaWVudCgpIGRvZXNuJ3QgYWNjZXNzIGRtYV9kZXNjPw0KPiA+Pg0KPiA+PiBTdG9wIHNoYWxs
IG5vdCByYWNlIHdpdGggdGhlIHN0YXJ0Lg0KPiA+Pg0KPiA+Pj4gK3N0YXRpYyBpbnQgdGVncmFf
ZG1hX3Rlcm1pbmF0ZV9hbGwoc3RydWN0IGRtYV9jaGFuICpkYykgew0KPiA+Pj4gKyAgICAgICBz
dHJ1Y3QgdGVncmFfZG1hX2NoYW5uZWwgKnRkYyA9IHRvX3RlZ3JhX2RtYV9jaGFuKGRjKTsNCj4g
Pj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4+ICsgICAgICAgTElTVF9IRUFE
KGhlYWQpOw0KPiA+Pj4gKyAgICAgICBpbnQgZXJyOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICBl
cnIgPSB0ZWdyYV9kbWFfc3RvcF9jbGllbnQodGRjKTsNCj4gPj4+ICsgICAgICAgaWYgKGVycikN
Cj4gPj4+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAg
ICB0ZWdyYV9kbWFfc3RvcCh0ZGMpOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmdGRjLT52Yy5sb2NrLCBmbGFncyk7DQo+ID4+PiArICAgICAgIHRlZ3JhX2RtYV9z
aWRfZnJlZSh0ZGMpOw0KPiA+Pj4gKyAgICAgICB0ZGMtPmRtYV9kZXNjID0gTlVMTDsNCj4gPj4+
ICsNCj4gPj4+ICsgICAgICAgdmNoYW5fZ2V0X2FsbF9kZXNjcmlwdG9ycygmdGRjLT52YywgJmhl
YWQpOw0KPiA+Pj4gKyAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0ZGMtPnZjLmxvY2ss
IGZsYWdzKTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgdmNoYW5fZG1hX2Rlc2NfZnJlZV9saXN0
KCZ0ZGMtPnZjLCAmaGVhZCk7DQo+ID4+PiArDQo+ID4+PiArICAgICAgIHJldHVybiAwOw0KPiA+
Pj4gK30NCj4gPj4+DQo+ID4+PiArc3RhdGljIGlycXJldHVybl90IHRlZ3JhX2RtYV9pc3IoaW50
IGlycSwgdm9pZCAqZGV2X2lkKSB7DQo+ID4+PiArICAgICAgIHN0cnVjdCB0ZWdyYV9kbWFfY2hh
bm5lbCAqdGRjID0gZGV2X2lkOw0KPiA+Pj4gKyAgICAgICBzdHJ1Y3QgdGVncmFfZG1hX2Rlc2Mg
KmRtYV9kZXNjID0gdGRjLT5kbWFfZGVzYzsNCj4gPj4+ICsgICAgICAgc3RydWN0IHRlZ3JhX2Rt
YV9zZ19yZXEgKnNnX3JlcTsNCj4gPj4+ICsgICAgICAgdTMyIHN0YXR1czsNCj4gPj4+ICsNCj4g
Pj4+ICsgICAgICAgLyogQ2hlY2sgY2hhbm5lbCBlcnJvciBzdGF0dXMgcmVnaXN0ZXIgKi8NCj4g
Pj4+ICsgICAgICAgc3RhdHVzID0gdGRjX3JlYWQodGRjLCBURUdSQV9HUENETUFfQ0hBTl9FUlJf
U1RBVFVTKTsNCj4gPj4+ICsgICAgICAgaWYgKHN0YXR1cykgew0KPiA+Pj4gKyAgICAgICAgICAg
ICAgIHRlZ3JhX2RtYV9jaGFuX2RlY29kZV9lcnJvcih0ZGMsIHN0YXR1cyk7DQo+ID4+PiArICAg
ICAgICAgICAgICAgdGVncmFfZG1hX2R1bXBfY2hhbl9yZWdzKHRkYyk7DQo+ID4+PiArICAgICAg
ICAgICAgICAgdGRjX3dyaXRlKHRkYywgVEVHUkFfR1BDRE1BX0NIQU5fRVJSX1NUQVRVUywgMHhG
RkZGRkZGRik7DQo+ID4+PiArICAgICAgIH0NCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgc3RhdHVz
ID0gdGRjX3JlYWQodGRjLCBURUdSQV9HUENETUFfQ0hBTl9TVEFUVVMpOw0KPiA+Pj4gKyAgICAg
ICBpZiAoIShzdGF0dXMgJiBURUdSQV9HUENETUFfU1RBVFVTX0lTRV9FT0MpKQ0KPiA+Pj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAg
dGRjX3dyaXRlKHRkYywgVEVHUkFfR1BDRE1BX0NIQU5fU1RBVFVTLA0KPiA+Pj4gKyAgICAgICAg
ICAgICAgICAgVEVHUkFfR1BDRE1BX1NUQVRVU19JU0VfRU9DKTsNCj4gPj4+ICsNCj4gPj4+ICsg
ICAgICAgc3Bpbl9sb2NrKCZ0ZGMtPnZjLmxvY2spOw0KPiA+Pj4gKyAgICAgICBpZiAoIWRtYV9k
ZXNjKQ0KPiA+PiBBbGwgY2hlY2tzIGFuZCBhc3NpZ25tZW50cyBtdXN0IGJlIGRvbmUgaW5zaWRl
IG9mIGNyaXRpY2FsIHNlY3Rpb24uDQo+ID4NCj4gPiBPa2F5LiBTbywgdGhlIGxvY2sgc2hvdWxk
IGJlIGhlbGQgdGhyb3VnaG91dCB0aGUgZnVuY3Rpb24uDQo+ID4gRG8geW91IHRoaW5rIHRlZ3Jh
X2RtYV9wYXVzZSBzaG91bGQgYWxzbyBob2xkIGEgbG9jaw0KPiA+IGFuZCByZW1vdmUgaXJxX3N5
bmNocm9uaXplPyBUaGF0IGZ1bmN0aW9uIGFsc28gd3JpdGVzDQo+ID4gdG8gQ1NSIHJlZ2lzdGVy
Lg0KPiANCj4gSW50ZXJydXB0IGhhbmRsZXIgc2hhbGwgbm90IHVucGF1c2UgY2hhbm5lbCBpbiBh
IGNhc2Ugb2YgcmFjZSBjb25kaXRpb24sDQo+IGl0IHNob3VsZCBoYW5kbGUgY29tcGxldGVkIHRy
YW5zZmVyIGFuZCBjaGVjayB3aGV0aGVyIGNoYW5uZWwgaXMgcGF1c2VkDQo+IGJlZm9yZSBpc3N1
aW5nIG5leHQgdHJhbnNmZXIuDQo+IFNvIHllcywgcGF1c2UgYWxzbyBuZWVkcyBhIGxvY2suDQpU
aGFua3MgZm9yIHRoZSBwb2ludHMuIEkgY29sbGVjdGVkIG1vcmUgZGV0YWlscyBvbiB0aGlzIHNj
ZW5hcmlvIGFuZCBmb3VuZCB0aGF0DQpETUEgY2FuIG9ubHkgYmUgcGF1c2VkIGlmIHRoZXJlIGlz
IGFuIGluLWZsaWdodCB0cmFuc2ZlciAoaS5lIG5vIGludGVycnVwdCB3aWxsIGJlDQpwZW5kaW5n
KS4gQW5kIHRoZXJlIGNhbm5vdCBiZSBhbiBpbnRlcnJ1cHQgYWZ0ZXIgRE1BIGlzIHBhdXNlZC4g
SGVuY2UsIHRoZXJlDQppcyBubyBjYXNlIG9mIElTUiB1bnBhdXNpbmcgYSBwYXVzZWQgdHJhbnNm
ZXIuIFNvLCBJIGd1ZXNzLCB0aGUgY2hlY2sgb3IgYSBsb2NrDQptaWdodCBub3QgYmUgcmVxdWly
ZWQgdGhlcmUuDQoNCk9uZSB0aGluZyBJIGFtIHRoaW5raW5nIG9mIGlzIHRvIHdhaXQgZm9yIERN
QSB0byBiZSBidXN5IHNvIHRoYXQgaXQgY2FuIGJlIHBhdXNlZC4NCkkgd291bGQgYWRkIHRoZXNl
IGNoYW5nZXMgYW5kIHNlbmQgb3V0IGEgbmV3IHBhdGNoLg0KDQpUaGFua3MsDQpBa2hpbA0KDQo=

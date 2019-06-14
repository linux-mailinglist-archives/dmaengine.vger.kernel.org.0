Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB545717
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFNIPb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 04:15:31 -0400
Received: from mail-eopbgr680088.outbound.protection.outlook.com ([40.107.68.88]:16512
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfFNIPW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU51HHqm9ZRnFP73vQTI1/OZYnHZ2XoUGsB7RVRqTs4=;
 b=TpVpySkFasLkbI97whyhdxxnp4IxgkxvLRdmwH+PKIRRjvW+N5u1oniLMhvR7X7rDYH2bemOgzAOzQPXQVS99mcewkIMXMjkJ3Msp2HEVr9zYiMshVEDJ19CTwuB4jwnqWCwgEB0mC0vOKznylcSI4P9TMvKBDBVUQrATQlg39U=
Received: from BN3PR03CA0092.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::52) by CY4PR03MB3127.namprd03.prod.outlook.com
 (2603:10b6:910:53::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13; Fri, 14 Jun
 2019 08:15:19 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN3PR03CA0092.outlook.office365.com
 (2a01:111:e400:7a4d::52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Fri, 14 Jun 2019 08:14:37 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Fri, 14 Jun 2019 08:14:36 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5E8EZBP001917
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 14 Jun 2019 01:14:35 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 14 Jun 2019 04:14:35 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 4/4] dmaengine: axi-dmac: add regmap support
Thread-Topic: [PATCH 4/4] dmaengine: axi-dmac: add regmap support
Thread-Index: AQHVHFUHMVY6/rwYRk2QCcpVOmPugKaa9QMAgAAnxAA=
Date:   Fri, 14 Jun 2019 08:14:34 +0000
Message-ID: <d39019156021aabb2bf8ddc822b6f38b70e46bb5.camel@analog.com>
References: <20190606104550.32336-1-alexandru.ardelean@analog.com>
         <20190606104550.32336-4-alexandru.ardelean@analog.com>
         <20190614055212.GC2962@vkoul-mobl>
In-Reply-To: <20190614055212.GC2962@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFB49C229C847C469E279AEC1100F6DF@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(189003)(199004)(486006)(50466002)(5660300002)(47776003)(118296001)(6246003)(436003)(4744005)(6916009)(4326008)(126002)(11346002)(446003)(2616005)(2351001)(76176011)(305945005)(7636002)(7736002)(23676004)(102836004)(53546011)(7696005)(14444005)(426003)(356004)(14454004)(36756003)(5640700003)(229853002)(70206006)(476003)(2486003)(316002)(478600001)(26005)(8936002)(70586007)(336012)(106002)(246002)(186003)(2501003)(3846002)(2906002)(6116002)(1730700003)(86362001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3127;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54cf5469-5e06-4422-f172-08d6f0a056f9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY4PR03MB3127;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3127:
X-Microsoft-Antispam-PRVS: <CY4PR03MB3127397B88DCA8D13AF207CDF9EE0@CY4PR03MB3127.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0068C7E410
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: F8xuPK9gqBGolM5y0Lne6NQG+HXpCGhFGPhe9Cwi74Ck8FGoAZqhzWQj71thDBYet7jZxLtx69rqBaSeQqf3nQLuJtPPiR2w/QXmLaWGXkW4qT+Ed+2yURJZEE2Oy0ak7B3SVO4s5HMA4oGsPqgBfv+ms4cyDWtrghmGL1/PvhAVvuACAaYMpCEJQhIznljQtoeJYGgMd5T8mhvoJl7dukIgez3gI+A2UCrPF5GLgeP2+yB1v+hdHhqj399HCBoeHMvgtUMGoO54j7kkR3jTZll6aIflcyuBpUdNYhAV/aG3J0XhNCRSsCLjvkXmTkIthTlfIUF86USbx9xnvOqQ4anJ4lA2OR1hrH07TkBb/t5LDFwv8H6srYx+wc4gO1VyLdLuACUnNR8kEscaHJark1WIGB3z2712BsicXtnwwAM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2019 08:14:36.1296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cf5469-5e06-4422-f172-08d6f0a056f9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3127
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gRnJpLCAyMDE5LTA2LTE0IGF0IDExOjIyICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gMDYtMDYtMTksIDEzOjQ1LCBBbGV4YW5kcnUgQXJkZWxl
YW4gd3JvdGU6DQo+IA0KPiA+ICtzdGF0aWMgYm9vbCBheGlfZG1hY19yZWdtYXBfcmR3cihzdHJ1
Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCByZWcpDQo+ID4gK3sNCj4gPiArICAgICBzd2l0
Y2ggKHJlZykgew0KPiA+ICsgICAgIGNhc2UgQVhJX0RNQUNfUkVHX0lSUV9NQVNLOg0KPiA+ICsg
ICAgIGNhc2UgQVhJX0RNQUNfUkVHX0lSUV9TT1VSQ0U6DQo+ID4gKyAgICAgY2FzZSBBWElfRE1B
Q19SRUdfSVJRX1BFTkRJTkc6DQo+ID4gKyAgICAgY2FzZSBBWElfRE1BQ19SRUdfQ1RSTDoNCj4g
PiArICAgICBjYXNlIEFYSV9ETUFDX1JFR19UUkFOU0ZFUl9JRDoNCj4gPiArICAgICBjYXNlIEFY
SV9ETUFDX1JFR19TVEFSVF9UUkFOU0ZFUjoNCj4gPiArICAgICBjYXNlIEFYSV9ETUFDX1JFR19G
TEFHUzoNCj4gPiArICAgICBjYXNlIEFYSV9ETUFDX1JFR19ERVNUX0FERFJFU1M6DQo+ID4gKyAg
ICAgY2FzZSBBWElfRE1BQ19SRUdfU1JDX0FERFJFU1M6DQo+ID4gKyAgICAgY2FzZSBBWElfRE1B
Q19SRUdfWF9MRU5HVEg6DQo+ID4gKyAgICAgY2FzZSBBWElfRE1BQ19SRUdfWV9MRU5HVEg6DQo+
ID4gKyAgICAgY2FzZSBBWElfRE1BQ19SRUdfREVTVF9TVFJJREU6DQo+ID4gKyAgICAgY2FzZSBB
WElfRE1BQ19SRUdfU1JDX1NUUklERToNCj4gPiArICAgICBjYXNlIEFYSV9ETUFDX1JFR19UUkFO
U0ZFUl9ET05FOg0KPiA+ICsgICAgIGNhc2UgQVhJX0RNQUNfUkVHX0FDVElWRV9UUkFOU0ZFUl9J
RCA6DQo+IA0KPiBTcGFjZSBiZWZvcmUgOiAuLi4/DQoNCm9vcHMNCnNvcnJ5IGFib3V0IHRoYXQN
Cg0KdGhhbmtzIGZvciBmaXhpbmcNCg0KQWxleA0KDQo+IA0KPiAtLQ0KPiB+Vmlub2QNCg==

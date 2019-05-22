Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90CE260E4
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfEVJ7q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 05:59:46 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:22337
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVJ7p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDyskuE1hfrVjxPzPDO3h59MjCYr/+DW7fNrhovBzYY=;
 b=r8VzIPYmATUNiTqGa7xA1UawM3hW9IKBgg3nOQJ0F5BFxBYlfDFZfhh1nOdaUh2uRqxW1Zhjx0yR6vwGw3YTKDaLaSFnwGrOIQqiIqIOYwSCa4UGDPIfE+jZ3/ZfgHHs4vmTDnAz5kqofqqdg7JkmP3xnfWYeveKF63dUtN4aZo=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3103.eurprd04.prod.outlook.com (10.170.229.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 09:59:39 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 09:59:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v4 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v4 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHVEIUR54BxkzTNOk2fBr52LKhyNQ==
Date:   Wed, 22 May 2019 09:59:39 +0000
Message-ID: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ebcce8-5d67-4a02-6927-08d6de9c33f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3103;
x-ms-traffictypediagnostic: VI1PR04MB3103:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB3103F029DE5EAE4CC102C56A89000@VI1PR04MB3103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(68736007)(81166006)(2201001)(2501003)(52116002)(71200400001)(14454004)(186003)(256004)(14444005)(26005)(53936002)(7736002)(25786009)(81156014)(305945005)(966005)(8936002)(4326008)(86362001)(8676002)(50226002)(71190400001)(486006)(6512007)(6306002)(5660300002)(6436002)(66946007)(73956011)(498600001)(66446008)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(99286004)(386003)(6506007)(2906002)(54906003)(36756003)(110136005)(7416002)(2616005)(6486002)(102836004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3103;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jnsnaHzcad38YiP83FfDlBCYBJ0GMZPivmHg4wOR57yoTdXl2R3JmK81S9ktZE1NnM9yFYXqoEpB82tanGIzEfsFKclYNaRXVyUIUWbhFMB3dM0tfk7yhiLgLudUiR0PT1Orxj+0cMk3hg/Fbfjxz8QuW6zGySAl7/KWjYyIofhToKtL3evJCZgVlfiQto1o/P/Fm5lgoazQZCOC9J4CMuSK9iZ3MRAHcPfiMHx5GOC3YXEatdntT4n44m/c2su7YiZG3e3qlyun+VQllxPcNi+O4gxayDkZAapD587786dMJFRbuckFQVlfLrZV5HiG17H13drTfkF4teCkqfqnDQwcjCTzwqjzPqx9w5lS83XK+PPlpKdYoucN8lxWhw8PHhGIM7W4ctr02WiAEdnL1PZeiw/lSkfn2qif1wiunoQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ebcce8-5d67-4a02-6927-08d6de9c33f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:59:39.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ICBUaGVyZSBpcyBlY3NwaSBFUlIwMDkxNjUgb24gaS5teDYvNyBzb2MgZmFtaWx5LCB3aGljaCBj
YXVzZSBGSUZPDQp0cmFuc2ZlciB0byBiZSBzZW5kIHR3aWNlIGluIERNQSBtb2RlLiBQbGVhc2Ug
Z2V0IG1vcmUgaW5mb3JtYXRpb24gZnJvbToNCmh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9l
cnJhdGEvSU1YNkRRQ0UucGRmLiBUaGUgd29ya2Fyb3VuZCBpcyBhZGRpbmcNCm5ldyBzZG1hIHJh
bSBzY3JpcHQgd2hpY2ggd29ya3MgaW4gWENIICBtb2RlIGFzIFBJTyBpbnNpZGUgc2RtYSBpbnN0
ZWFkDQpvZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xEJyBzaG91bGQgYmUgMC4g
VGhlIGlzc3VlIHNob3VsZCBiZQ0KZXhpc3Qgb24gYWxsIGxlZ2FjeSBpLm14Ni83IHNvYyBmYW1p
bHkgYmVmb3JlIGkubXg2dWwuDQpOWFAgZml4IHRoaXMgZGVzaWduIGlzc3VlIGZyb20gaS5teDZ1
bCwgc28gbmV3ZXIgY2hpcHMgaW5jbHVkaW5nIGkubXg2dWwvDQo2dWxsLzZzbGwgZG8gbm90IG5l
ZWQgdGhpcyB3b3JrYXJvdWQgYW55bW9yZS4gQWxsIG90aGVyIGkubXg2LzcvOCBjaGlwcw0Kc3Rp
bGwgbmVlZCB0aGlzIHdvcmthcm91ZC4gVGhpcyBwYXRjaCBzZXQgYWRkIG5ldyAnZnNsLGlteDZ1
bC1lY3NwaScNCmZvciBlY3NwaSBkcml2ZXIgYW5kICdlY3NwaV9maXhlZCcgaW4gc2RtYSBkcml2
ZXIgdG8gY2hvb3NlIGlmIG5lZWQgZXJyYXRhDQpvciBub3QuDQogIFRoZSBmaXJzdCB0d28gcmV2
ZXJ0ZWQgcGF0Y2hlcyBzaG91bGQgYmUgdGhlIHNhbWUgaXNzdWUsIHRob3VnaCwgaXQNCnNlZW1z
ICdmaXhlZCcgYnkgY2hhbmdpbmcgdG8gb3RoZXIgc2hwIHNjcmlwdC4gSG9wZSBTZWFuIG9yIFNh
c2NoYSBjb3VsZA0KaGF2ZSB0aGUgY2hhbmNlIHRvIHRlc3QgdGhpcyBwYXRjaCBzZXQgaWYgY291
bGQgZml4IHRoZWlyIGlzc3Vlcy4NCiAgQmVzaWRlcywgZW5hYmxlIHNkbWEgc3VwcG9ydCBmb3Ig
aS5teDhtbS84bXEgYW5kIGZpeCBlY3NwaTEgbm90IHdvcmsNCm9uIGkubXg4bW0gYmVjYXVzZSB0
aGUgZXZlbnQgaWQgaXMgemVyby4NCg0KUFM6DQogIFBsZWFzZSBnZXQgc2RtYSBmaXJtd2FyZSBm
cm9tIGJlbG93IGxpbnV4LWZpcm13YXJlIGFuZCBjb3B5IGl0IHRvIHlvdXINCmxvY2FsIHJvb3Rm
cyAvbGliL2Zpcm13YXJlL2lteC9zZG1hLg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvZmlybXdhcmUvbGludXgtZmlybXdhcmUuZ2l0L3RyZWUvaW14L3Nk
bWENCg0KdjI6DQogIDEuIGFkZCBjb21taXQgbG9nIGZvciByZXZlcnRlZCBwYXRjaGVzLg0KICAy
LiBhZGQgY29tbWVudCBmb3IgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZlci4NCiAgMy4gYWRk
ICdmc2wsaW14NnNsbC1lY3NwaScgY29tcGF0aWJsZSBpbnN0ZWFkIG9mICdmc2wsaW14NnVsLWVj
c3BpJw0KICAgICByYXRoZXIgdGhhbiByZW1vdmUuDQp2MzoNCiAgMS4gY29uZmlybSB3aXRoIGRl
c2lnbiB0ZWFtIG1ha2Ugc3VyZSBFUlIwMDkxNjUgZml4ZWQgb24gaS5teDZ1bC9pLm14NnVsbA0K
ICAvaS5teDZzbGwsIG5vdCBmaXhlZCBvbiBpLm14OG0vOG1tIGFuZCBvdGhlciBpLm14Ni83IGxl
Z2FjeSBjaGlwcy4NCiAgQ29ycmVjdCBkdHMgcmVsYXRlZCBkdHMgcGF0Y2ggaW4gdjIuDQogIDIu
IGNsZWFuIGVyYXR0YSBpbmZvcm1hdGlvbiBpbiBiaW5kaW5nIGRvYyBhbmQgbmV3ICd0eF9nbGl0
Y2hfZml4ZWQnIGZsYWcNCiAgaW4gc3BpLWlteCBkcml2ZXIgdG8gc3RhdGUgRVJSMDA5MTY1IGZp
eGVkIG9yIG5vdC4NCiAgMy4gRW5sYXJnZSBidXJzdCBzaXplIHRvIGZpZm8gc2l6ZSBmb3IgdHgg
c2luY2UgdHhfd21sIHNldCB0byAwIGluIHRoZQ0KICBlcnJhdGEgd29ya2Fyb3VkLCB0aHVzIGlt
cHJvdmUgcGVyZm9ybWFuY2UgYXMgcG9zc2libGUuDQp2NDoNCiAgMS4gYWRkIEFjayB0YWcgZnJv
bSBNYXJrIGFuZCBWaW5vZA0KICAyLiByZW1vdmUgY2hlY2tpbmcgJ2V2ZW50X2lkMScgemVybyBh
cyAnZXZlbnRfaWQwJy4NCg0KUm9iaW4gR29uZyAoMTQpOg0KICBSZXZlcnQgIkFSTTogZHRzOiBp
bXg2cTogVXNlIGNvcnJlY3QgU0RNQSBzY3JpcHQgZm9yIFNQSTUgY29yZSINCiAgUmV2ZXJ0ICJB
Uk06IGR0czogaW14NjogVXNlIGNvcnJlY3QgU0RNQSBzY3JpcHQgZm9yIFNQSSBjb3JlcyINCiAg
UmV2ZXJ0ICJkbWFlbmdpbmU6IGlteC1zZG1hOiByZWZpbmUgdG8gbG9hZCBjb250ZXh0IG9ubHkg
b25jZSINCiAgZG1hZW5naW5lOiBpbXgtc2RtYTogcmVtb3ZlIGR1cGlsaWNhdGVkIHNkbWFfbG9h
ZF9jb250ZXh0DQogIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCBtY3VfMl9lY3NwaSBzY3JpcHQN
CiAgc3BpOiBpbXg6IGZpeCBFUlIwMDkxNjUNCiAgc3BpOiBpbXg6IHJlbW92ZSBFUlIwMDkxNjUg
d29ya2Fyb3VuZCBvbiBpLm14NnVsDQogIGR0LWJpbmRpbmdzOiBzcGk6IGlteDogYWRkIG5ldyBp
Lm14NnVsIGNvbXBhdGlibGUgbmFtZQ0KICBkbWFlbmdpbmU6IGlteC1zZG1hOiByZW1vdmUgRVJS
MDA5MTY1IG9uIGkubXg2dWwNCiAgZHQtYmluZGluZ3M6IGRtYTogaW14LXNkbWE6IGFkZCBpLm14
NnVsLzZzeCBjb21wYXRpYmxlIG5hbWUNCiAgZG1hZW5naW5lOiBpbXgtc2RtYTogZml4IGVjc3Bp
MSByeCBkbWEgbm90IHdvcmsgb24gaS5teDhtbQ0KICBBUk06IGR0czogaW14NnVsOiBhZGQgZG1h
IHN1cHBvcnQgb24gZWNzcGkNCiAgQVJNOiBkdHM6IGlteDZzbGw6IGNvcnJlY3Qgc2RtYSBjb21w
YXRpYmxlDQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBTRE1BIG9uIGkubXg4bXEvOG1tDQoN
CiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dCAgICAgICB8ICAy
ICsNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dCAgICAgICB8
ICAxICsNCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyICstDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpICAgICAgICAgICAgICAg
ICAgICAgfCAgOCArLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kgICAgICAgICAg
ICAgICAgICAgICB8ICAyICstDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLmR0c2kgICAgICAg
ICAgICAgICAgICAgICAgfCAgOCArKysNCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzICsNCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDc4ICsrKysrKysrKysrKysrKystLS0tLS0NCiBkcml2
ZXJzL3NwaS9zcGktaW14LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDYxICsrKysr
KysrKysrKysrLS0tDQogaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2RtYS5o
ICAgICAgICAgfCAgMSArDQogMTAgZmlsZXMgY2hhbmdlZCwgMTMyIGluc2VydGlvbnMoKyksIDM0
IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNy40DQoNCg==

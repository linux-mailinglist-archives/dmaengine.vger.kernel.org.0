Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184A119B18
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEJKOI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 06:14:08 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:33825
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbfEJKOI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 06:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXZZvRgob1QWlWConVzgUn9IBqkwBT2in/JqBYa13OY=;
 b=FwHzAIWbhfR2aYeKMQ6pb28/WLiHfTTP4+VINOpUHhbpdxFK0nVMs1tk08MlmVlRkml+5SDxq9VAb+q8oNxMGL/deKnHRhjPI3jvkPGve7/YY+mqdlWxgDkDZ1FcMCWKqcDDp+WAHF0lkgIFRPm73+XZ/MV2UmDYBVm1kRwJok0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3007.eurprd04.prod.outlook.com (10.170.228.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 10 May 2019 10:14:03 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:14:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 0/6] add edma2 for i.mx7ulp
Thread-Topic: [PATCH v1 0/6] add edma2 for i.mx7ulp
Thread-Index: AQHVBxkYfOJpUoG7C02l/BlvpbIORA==
Date:   Fri, 10 May 2019 10:14:03 +0000
Message-ID: <1557512248-8440-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 234a5fff-bd76-4f8c-a171-08d6d5303a62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3007;
x-ms-traffictypediagnostic: VI1PR04MB3007:
x-microsoft-antispam-prvs: <VI1PR04MB30079A5982BFFAF38D2EE789890C0@VI1PR04MB3007.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(189003)(14454004)(2201001)(110136005)(54906003)(478600001)(2501003)(8936002)(8676002)(81166006)(81156014)(50226002)(316002)(86362001)(66066001)(25786009)(7416002)(53936002)(4326008)(36756003)(7736002)(71200400001)(2616005)(71190400001)(66946007)(14444005)(256004)(486006)(2906002)(186003)(26005)(102836004)(476003)(5660300002)(3846002)(6486002)(6116002)(52116002)(6506007)(386003)(68736007)(305945005)(66476007)(66556008)(64756008)(66446008)(73956011)(99286004)(6436002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3007;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M/X5Jioj0FC7wVI2mWILq7BOkgG3LrH5xXZibV/IoWZ+BJrrru0KAI8kU42dofn3D8POs1ow6j3z5MgFnuGsX7hZbkmXKn+T5pm38cSHAQVxTZwV6DaX4CzRrBC2FZUGpabT410eodHfqQY/pxVuGknyLu7Rg7t+mXCvZvbm/hg+V5yOeVptNp3I4V58DtWBCRHm7Hx7Bacb08dRr8rmzfu1xyQKr/LmEm40FWuEzN2qpDoVi62xFOjb+EAaGA9XVeTo8kfavKOa0amlYNrSR115V20QnDDTM5/pO/B4BR+all8Our+j3zUlSSFjO5I7C0sHxVviG0kjUE6pmwA386WBfqgG6E12l2K5adpsV1um4sqSdpnE3eSK0HFHmWYx+Az3WES7+oeSXvlPKjE5PaJS5kg2oWISLYHwX75y8a8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234a5fff-bd76-4f8c-a171-08d6d5303a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:14:03.9186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3007
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ICBUaGlzIHBhdGNoIHNldCBhZGQgbmV3IHZlcnNpb24gb2YgZWRtYSBmb3IgaS5teDd1bHAsIHRo
ZSBtYWluIGNoYW5nZXMNCmFyZSBhcyBiZWxvd3M6DQogIDEuIG9ubHkgb25lIGRtYW11eC4NCiAg
Mi4gYW5vdGhlciBjbG9jayBkbWFfY2xrIGV4Y2VwdCBkbWFtdXggY2xrLg0KICAzLiAxNiBpbmRl
cGVuZGVudCBpbnRlcnJ1cHRzIGluc3RlYWQgb2Ygb25seSBvbmUgaW50ZXJydXB0IGZvcg0KYWxs
IGNoYW5uZWxzLg0KICBGb3IgdGhlIGZpcnN0IGNoYW5nZSwgbmVlZCBtb2RpZnkgZnNsLWVkbWEt
Y29tbW9uLmMgYW5kIG1jZi1lZG1hLA0Kc28gY3JlYXRlIHRoZSBmaXJzdCB0d28gcGF0Y2hlcyB0
byBwcmVwYXJlIHdpdGhvdXQgYW55IGZ1bmN0aW9uDQppbXBhY3QuDQogIEZvciB0aGUgdGhpcmQg
Y2hhbmdlLCBuZWVkIHJlcXVlc3Qgc2luZ2xlIGlycSBmb3IgZXZlcnkgY2hhbm5lbCB3aXRoDQp0
aGUgbGVnYWN5IGhhbmRsZXIuIEJ1dCBhY3R1YWxseSAyIGRtYSBjaGFubmVscyBzaGFyZSBvbmUg
aW50ZXJydXB0KDE2DQpjaGFubmVsIGludGVycnVwdHMsIGJ1dCAzMiBjaGFubmVscy4pLGNoMC9j
aDE2LGNoMS9jaDE3Li4uIEZvciBub3csIGp1c3QNCnNpbXBseSByZXF1ZXN0IGlycSB3aXRob3V0
IElSUUZfU0hBUkVEIGZsYWcsIHNpbmNlIDE2IGNoYW5uZWxzIGFyZSBlbm91Z2gNCm9uIGkubXg3
dWxwIHdob3NlIE00IGRvbWFpbiBvd24gc29tZSBwZXJpcGhlcmFscy4NCg0KUm9iaW4gR29uZyAo
Nik6DQogIGRtYWVuZ2luZTogZnNsLWVkbWE6IGFkZCBkbWFtdXhfbnIgZm9yIG5leHQgdmVyc2lv
bg0KICBkbWFlbmdpbmU6IG1jZi1lZG1hOiB1cGRhdGUgdG8gJ2RtYW11eF9ucicNCiAgZG1hZW5n
aW5lOiBmc2wtZWRtYS1jb21tb246IG1vdmUgZG1hbXV4IHJlZ2lzdGVyIHRvIGFub3RoZXIgc2lu
Z2xlDQogICAgZnVuY3Rpb24NCiAgZG1hZW5naW5lOiBmc2wtZWRtYTogYWRkIGkubXg3dWxwIGVk
bWEyIHZlcnNpb24gc3VwcG9ydA0KICBkdC1iaW5kaW5nczogZG1hOiBmc2wtZWRtYTogYWRkIG5l
dyBpLm14N3VscC1lZG1hDQogIEFSTTogZHRzOiBpbXg3dWxwOiBhZGQgZWRtYSBkZXZpY2Ugbm9k
ZQ0KDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtZWRtYS50eHQg
fCA0NCArKysrKysrKysrLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kgICAgICAg
ICAgICAgICAgICAgICB8IDI4ICsrKysrKysrDQogZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9u
LmMgICAgICAgICAgICAgICAgICAgICAgfCAzNCArKysrKysrLS0NCiBkcml2ZXJzL2RtYS9mc2wt
ZWRtYS1jb21tb24uaCAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrDQogZHJpdmVycy9kbWEv
ZnNsLWVkbWEuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA4MCArKysrKysrKysrKysr
KysrKysrKy0tDQogZHJpdmVycy9kbWEvbWNmLWVkbWEuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMSArDQogNiBmaWxlcyBjaGFuZ2VkLCAxNzYgaW5zZXJ0aW9ucygrKSwgMTUgZGVs
ZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4888C1604E
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEGJPx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:15:53 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:25905
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfEGJPx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnRKarNhddCU1AORDzZBs5G9ScPkPlar0EDir6cOQZA=;
 b=HNQPUj5Loyu/uQCXvEl7pvwNkB1KVKEdSAKp2c4ZDZYxGP3EE2otrvNIAE0IGo0MCkCDkw02f1Z0bU+hEINNeH5xvy6KkO5sZBl626rJdMlSXKq4rPZPNyR2lZ97EDfmmLlU4uHVDeBc8iriNgCIX8VljXgqD2sYbGNGYqWTqH8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3184.eurprd04.prod.outlook.com (10.170.229.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 09:15:47 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:15:47 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v3 02/14] Revert "ARM: dts: imx6: Use correct SDMA script for
 SPI cores"
Thread-Topic: [PATCH v3 02/14] Revert "ARM: dts: imx6: Use correct SDMA script
 for SPI cores"
Thread-Index: AQHVBLV0duL5TZOWzEylRRHi3H0INQ==
Date:   Tue, 7 May 2019 09:15:47 +0000
Message-ID: <1557249513-4903-3-git-send-email-yibin.gong@nxp.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51aa6306-9710-487b-792c-08d6d2cc974a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3184;
x-ms-traffictypediagnostic: VI1PR04MB3184:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB318478746C367990C29808BF89310@VI1PR04MB3184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(478600001)(2906002)(7416002)(68736007)(81156014)(8676002)(4326008)(6116002)(81166006)(86362001)(2201001)(2501003)(476003)(256004)(446003)(11346002)(14444005)(2616005)(6512007)(6306002)(486006)(8936002)(3846002)(110136005)(6436002)(36756003)(5660300002)(66066001)(99286004)(54906003)(7736002)(66446008)(64756008)(66556008)(102836004)(66476007)(14454004)(25786009)(73956011)(71190400001)(71200400001)(66946007)(305945005)(386003)(6486002)(53936002)(50226002)(6506007)(76176011)(186003)(52116002)(26005)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3184;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fmcegvHEjgdMDICL43dXbucWfbPjYxry6VZ/ZEFINuIgogLivtWdjAbCWP18uLU2Be9sdKOUSFBR2N1Lavt/qjo41Tf1LwIUhtnlVTISuYSQaRDiQCyPTW2AL/rjkKR3AoLG7alnse4bWhSPlraDd8AQpiJ5cRX0nq8ULSS1ntgLuBd0jb4OnVCi+lbnHCIbi22+5hCpD6vC4VNfe4VOKOISoUfwcwW0d2FSCo2BleXoK4DZIDkbXKRzH0E3MLzsqQf+fV8pskjleNW0I8nFyH8MnyIq5TR3BGRt8vWNdQCx+kShlfirIrCml22UdErDJnTC0C+m+5GI20+xGbCEcJ66SA8X0ZX0iSSdNCy4792CUIjVH68s2xmSDZUJKnIlEDf5CGH/bplG3YRZay2AVu2SNJincCdUqDwAsAyCPCA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aa6306-9710-487b-792c-08d6d2cc974a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:15:47.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3184
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ICBUaGVyZSBhcmUgdHdvIHdheXMgZm9yIFNETUEgYWNjZXNzaW5nIFNQQkEgZGV2aWNlczogb25l
IGlzIFNETUEtPkFJUFMNCi0+U1BCQShtYXN0ZXJBIHBvcnQpLCBhbm90aGVyIGlzIFNETUEtPlNQ
QkEobWFzdGVyQyBwb3J0KS4gUGxlYXNlIHJlZmVyDQp0byB0aGUgJ0ZpZ3VyZSA1OC0xLiBpLk1Y
IDZEdWFsLzZRdWFkIFNQQkEgY29ubmVjdGl2aXR5JyBvZiBpLm14NkRRDQpSZWZlcmVuY2UgTWFu
dWFsLiBTRE1BIHByb3ZpZGUgdGhlIGNvcnJlc3BvbmRpbmcgYXBwXzJfbWN1L21jdV8yX2FwcCBh
bmQNCnNocF8yX21jdS9tY3VfMl9zaHAgc2NyaXB0IGZvciBzdWNoIHR3byBvcHRpb25zLiBTbyBi
b3RoIEFJUFMgYW5kIFNQQkENCnNjcmlwdHMgc2hvdWxkIGtlZXAgdGhlIHNhbWUgYmVoYXZpb3Vy
LCB0aGUgaXNzdWUgb25seSBjYXVnaHQgaW4gQUlQUw0Kc2NyaXB0IHNvdW5kcyBub3Qgc29saWRl
Lg0KICBUaGUgaXNzdWUgaXMgbW9yZSBsaWtlbHkgYXMgdGhlIGVjc3BpIGVycmF0YQ0KRVJSMDA5
MTY1KGh0dHA6Ly93d3cubnhwLmNvbS9kb2NzL2VuL2VycmF0YS9JTVg2RFFDRS5wZGYpOg0KZUNT
UEk6IFRYRklGTyBlbXB0eSBmbGFnIGdsaXRjaCBjYW4gY2F1c2UgdGhlIGN1cnJlbnQgRklGTyB0
cmFuc2ZlciB0bw0KICAgICAgICAgICBiZSBzZW50IHR3aWNlDQpTbyByZXZlcnQgY29tbWl0ICdk
ZDRiNDg3YjMyYTMnIGZpcnN0bHkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaSB8IDgg
KysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQppbmRleCBiM2E3N2JjLi5hOTBmMjE3IDEwMDY0NA0K
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQorKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2cWRsLmR0c2kNCkBAIC0zMzksNyArMzM5LDcgQEANCiAJCQkJCWNsb2NrcyA9IDwm
Y2xrcyBJTVg2UURMX0NMS19FQ1NQSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFETF9DTEtfRUNT
UEkxPjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwm
c2RtYSAzIDggMT4sIDwmc2RtYSA0IDggMj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwg
PCZzZG1hIDQgNyAyPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KIAkJCQl9Ow0KQEAgLTM1Myw3ICszNTMsNyBAQA0KIAkJCQkJY2xv
Y2tzID0gPCZjbGtzIElNWDZRRExfQ0xLX0VDU1BJMj4sDQogCQkJCQkJIDwmY2xrcyBJTVg2UURM
X0NMS19FQ1NQSTI+Ow0KIAkJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQotCQkJCQlk
bWFzID0gPCZzZG1hIDUgOCAxPiwgPCZzZG1hIDYgOCAyPjsNCisJCQkJCWRtYXMgPSA8JnNkbWEg
NSA3IDE+LCA8JnNkbWEgNiA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJ
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQpAQCAtMzY3LDcgKzM2Nyw3IEBADQog
CQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEkzPiwNCiAJCQkJCQkgPCZjbGtz
IElNWDZRRExfQ0xLX0VDU1BJMz47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsN
Ci0JCQkJCWRtYXMgPSA8JnNkbWEgNyA4IDE+LCA8JnNkbWEgOCA4IDI+Ow0KKwkJCQkJZG1hcyA9
IDwmc2RtYSA3IDcgMT4sIDwmc2RtYSA4IDcgMj47DQogCQkJCQlkbWEtbmFtZXMgPSAicngiLCAi
dHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCkBAIC0zODEsNyArMzgx
LDcgQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19FQ1NQSTQ+LA0KIAkJCQkJ
CSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEk0PjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIs
ICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwmc2RtYSA5IDggMT4sIDwmc2RtYSAxMCA4IDI+Ow0KKwkJ
CQkJZG1hcyA9IDwmc2RtYSA5IDcgMT4sIDwmc2RtYSAxMCA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVz
ID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQotLSAN
CjIuNy40DQoNCg==

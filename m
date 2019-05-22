Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7E260EE
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfEVJ7y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 05:59:54 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:63620
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVJ7y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 05:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnRKarNhddCU1AORDzZBs5G9ScPkPlar0EDir6cOQZA=;
 b=m4JFKQNBuC1+U6IpplMX6bQle4idJ+/UvWzj0riNIkSw2ZWTNGUKVjlG6a3OcAxNC86728N+FrXuP+0UrQqoIn/zfyht3zNuHjVGkkqp6u099mZSVhP8OyefpRwyhG33OvNzeqroeR3v0hyxhacsvbCNNLwZObuAxdgeLzrfhMU=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3103.eurprd04.prod.outlook.com (10.170.229.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 09:59:51 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 09:59:51 +0000
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
Subject: [PATCH v4 02/14] Revert "ARM: dts: imx6: Use correct SDMA script for
 SPI cores"
Thread-Topic: [PATCH v4 02/14] Revert "ARM: dts: imx6: Use correct SDMA script
 for SPI cores"
Thread-Index: AQHVEIUYElHsYfR94EmpIUmwMYIUBg==
Date:   Wed, 22 May 2019 09:59:50 +0000
Message-ID: <1558548188-1155-3-git-send-email-yibin.gong@nxp.com>
References: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: ec8c42f5-3dec-48e2-badc-08d6de9c3afa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3103;
x-ms-traffictypediagnostic: VI1PR04MB3103:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB31033749E59632B9A96029D089000@VI1PR04MB3103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(68736007)(81166006)(2201001)(2501003)(52116002)(71200400001)(14454004)(186003)(256004)(14444005)(26005)(53936002)(7736002)(25786009)(81156014)(305945005)(8936002)(4326008)(86362001)(8676002)(50226002)(71190400001)(486006)(6512007)(6306002)(5660300002)(6436002)(66946007)(73956011)(498600001)(446003)(66446008)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(99286004)(386003)(6506007)(2906002)(54906003)(76176011)(36756003)(11346002)(110136005)(7416002)(2616005)(6486002)(102836004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3103;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RZPDISVh5kH+VkS01i3XO7zrFF5XghTysaBz1MTwZ5kqSlco29or0BXp6F+2WTdM10cUzto/CBPxu09XAualtRaJaXRB/KIHGj6CFk+VuJEV9+GHAe3HWw19jYHr1HtAlRUtoES0xe+1JQ215Ux2Zr7rjEYgdbvSiQcV6+Meee+CooMVj4etAfBevUIP4vEWwHLzlunOR6zLEQAnQy8rGUQ5bYwe6fREim3CdcGdsMKRbHfWI/zR/wIU/5pF6Y9QUuXN5KvBg5WAmUFP3uTEznzaXBT4ZRryZuKtcf1qXbH7Ng+z49fwJU2T0wITwkOy3QJo8rmui8WC+zn2dkOIjDgO+iZw88DMkmIjRHy495zQU45VLdSpj8ongWD7RjziMWN3HYfyRpQnxrVIasrjiShuUSCbp2t4aLwruQyHQT8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8c42f5-3dec-48e2-badc-08d6de9c3afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:59:50.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
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

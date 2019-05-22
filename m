Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4788426130
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEVKBb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:01:31 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:18971
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728668AbfEVKBa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scAqqGt5yoPaSrcQ2/nd3cG8Kz6Tt66Vsg7Gk4jfTV0=;
 b=q958lJ0957X+Y3aolhJke15yf3ASKklhhkmRN2sW46v6x0UnzVoINstM8vaHHAFglRieDWLwFdC9qbDU83hrvvnrLrKwWVD4moeNZ90BT8GxdGe0+yChW7wMLzYmwF3PN43W7kc8GQAgvShTNcawH9DkdKa5Odo53kuhAvvrB5E=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:56 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:56 +0000
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
Subject: [PATCH v4 13/14] ARM: dts: imx6sll: correct sdma compatible
Thread-Topic: [PATCH v4 13/14] ARM: dts: imx6sll: correct sdma compatible
Thread-Index: AQHVEIU/6bsQAJL92kquJnq0ODVbAg==
Date:   Wed, 22 May 2019 10:00:56 +0000
Message-ID: <1558548188-1155-14-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 0aa9e34f-c3a3-4b49-61f4-08d6de9c6206
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-microsoft-antispam-prvs: <VI1PR04MB3149DD1979586AD32A51DECE89000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(4744005)(71200400001)(36756003)(6512007)(99286004)(7416002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(14444005)(66556008)(6116002)(3846002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aPbnRP9iG0lunoEntZm+rATALlnr2R6WFM3s20vz5iSp07kyuzJbS24eg0vTolBOO4DxO/nhvh/nUDIi11BHsoXS9qQcmSuodf/vFp26JDYVz5Ztm0gm3NpJ0z7UlvU8gsSIPFOCOO1ynC5j5J+lef5aMpwSwNEYLuh4IpOPu5tJ13g9/L7Zr5V9oA0fqOmk1qCRtzFDyNyAnDYyoXGwmoRLPay209Hm3jYEbqbGpgl9M57wKLUWaQDDBrM+6GP2dQzGsEYOLEsqzy6h/ll4hwSBMYWqB8gy6qwh0pkfc9c8vCdVhRYwdmViAv1rFescvG1bv9nxQofGYx+JEuEaqYLUhPQLyY5W2ntmHck4JwFBPRXlB9nO43lNNKDfXVoQnTe1IdgvU3N9Sd4/Nf8zHEnavx28Lz2BeKNZ0qXBppU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa9e34f-c3a3-4b49-61f4-08d6de9c6206
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:56.5370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Q29ycmVjdCBzZG1hIGNvbXBhdGlibGUgc2luY2UgZWNzcGkgZXJyYXRhIEVSUjAwOTE2NSBoYXMg
YmVlbiBmaXhlZA0Kb24gaS5teDZzbGwgYXMgaS5teDZ1bC4NCg0KU2lnbmVkLW9mZi1ieTogUm9i
aW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnNsbC5kdHNpIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQppbmRleCAxYjQ4OTlmLi5kODEwZTEwIDEw
MDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQorKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2c2xsLmR0c2kNCkBAIC02MTksNyArNjE5LDcgQEANCiAJCQl9Ow0KIA0K
IAkJCXNkbWE6IGRtYS1jb250cm9sbGVyQDIwZWMwMDAgew0KLQkJCQljb21wYXRpYmxlID0gImZz
bCxpbXg2c2xsLXNkbWEiLCAiZnNsLGlteDM1LXNkbWEiOw0KKwkJCQljb21wYXRpYmxlID0gImZz
bCxpbXg2c2xsLXNkbWEiLCAiZnNsLGlteDZ1bC1zZG1hIjsNCiAJCQkJcmVnID0gPDB4MDIwZWMw
MDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2U0xMX0NMS19JUEc+LA0KLS0gDQoyLjcu
NA0KDQo=

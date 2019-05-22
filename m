Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5219126121
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfEVKB2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:01:28 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:13764
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfEVKB2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6sqrqxqwTiZ4tbyJIcnvRvAcZq7pQfaNREQf2oUNJU=;
 b=P9bdUFm9Xh6g4lFidqcCBEvsLuVmRknWle3E+Js7RNKfrv/Ntu4HPgCrM16nIkMDznMADns6vvIn+91HfT+YM6fyklkeZbmHXmDzOoC9T5iqOmhs5MJPYJpd29gdv1Fh03m5v3RVMuavGgAXw3BaP6EJOh8Nv65pzpL80aTiHxA=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:50 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:50 +0000
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
Subject: [PATCH v4 12/14] ARM: dts: imx6ul: add dma support on ecspi
Thread-Topic: [PATCH v4 12/14] ARM: dts: imx6ul: add dma support on ecspi
Thread-Index: AQHVEIU83qMigGqUGE6I8nfFNPDIVQ==
Date:   Wed, 22 May 2019 10:00:50 +0000
Message-ID: <1558548188-1155-13-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: aa041148-5ce4-4bfe-e04c-08d6de9c5e5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-microsoft-antispam-prvs: <VI1PR04MB31492FFCA87BCD36D2B6271F89000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(71200400001)(36756003)(6512007)(99286004)(7416002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(14444005)(66556008)(6116002)(3846002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3ZMxYNrsqSdtPnHRridgmTzAbN9a6QLjf25dMBkv8KT7YscG0mP4mMoXwwBrAXeXMnXqSErlnn7UFxzOLlV3cGift+Ptx/232jVipD65zW4t8ryeIgtkWkZbr7XCYclldyC4da38ej7HRat5PWPHtuWYkljieUSYaVNugZ8LwIy+q7gqjj5SzhWAnUC7IU1eCGUUK7cU695gANaNtNUwZ/HlH7MIxGGe2OjGBNbG+HaM7ecmGQGHhiIeHg+rRoHk2Iv1s0HEIFncxxZQRSNwk1P78wF3VwPBBueTilFuApUvmuRorlwyv+cgjyvt3vxHWL8CYqQk6Zb7Ics9RjJ9fhmUUDLNKsFJ8Aw+TGU+jzdgOxRrq51diCUGUhywPspwUzt2NIRo+czwTonJFnnT9DV/linIlWMiuO3+CflVQCo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa041148-5ce4-4bfe-e04c-08d6de9c5e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:50.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QWRkIGRtYSBzdXBwb3J0IG9uIGVjc3BpLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5
aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSB8
IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZ1bC5kdHNpDQppbmRleCBiYmYwMTBjLi44ODBiOWVlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsLmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5kdHNp
DQpAQCAtMjI2LDYgKzIyNiw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlVMX0NMS19F
Q1NQSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTE+Ow0KIAkJCQkJY2xvY2st
bmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwgPCZzZG1h
IDQgNyAyPjsNCisJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIAkJCQl9Ow0KIA0KQEAgLTIzOCw2ICsyNDAsOCBAQA0KIAkJCQkJY2xvY2tz
ID0gPCZjbGtzIElNWDZVTF9DTEtfRUNTUEkyPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtf
RUNTUEkyPjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KKwkJCQkJZG1hcyA9
IDwmc2RtYSA1IDcgMT4sIDwmc2RtYSA2IDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAi
dHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCkBAIC0yNTAsNiAr
MjU0LDggQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz4sDQogCQkJ
CQkJIDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGci
LCAicGVyIjsNCisJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8JnNkbWEgOCA3IDI+Ow0KKwkJ
CQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQog
CQkJCX07DQogDQpAQCAtMjYyLDYgKzI2OCw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1Y
NlVMX0NMS19FQ1NQSTQ+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTQ+Ow0KIAkJ
CQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDkgNyAx
PiwgPCZzZG1hIDEwIDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KIAkJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCi0tIA0KMi43LjQNCg0K

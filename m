Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D46260EB
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfEVJ7t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 05:59:49 -0400
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:26753
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVJ7t (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 05:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDn8j2HqvkAgGOvzsK2c8evs0ozo2pfez6/Fl92rAdQ=;
 b=Zo2kYWgipptQpPMfYFToILHU9X7jaKJ16bJP0xiv5aUN0lPRX0eUcfD6lkXHPv158MN6gGIdcSG3zVK2JwxbH3+wsb78ED3iAIFyimtQVPe6rmVYMXaIrnpDAEEYEc3BfWP/FbgVUeHCCpYtBpPK/3GK4gRQHS+UkgcFrn7guvQ=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 09:59:45 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 09:59:45 +0000
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
Subject: [PATCH v4 01/14] Revert "ARM: dts: imx6q: Use correct SDMA script for
 SPI5 core"
Thread-Topic: [PATCH v4 01/14] Revert "ARM: dts: imx6q: Use correct SDMA
 script for SPI5 core"
Thread-Index: AQHVEIUV+93GPFkskUmxabHcQCZhPQ==
Date:   Wed, 22 May 2019 09:59:45 +0000
Message-ID: <1558548188-1155-2-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: a99b8a20-0bc7-49ae-5a38-08d6de9c376f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB31496EA6D7C533132E73DD1A89000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(71200400001)(36756003)(6512007)(99286004)(7416002)(6306002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(14444005)(66556008)(6116002)(3846002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MpBBD+h9H47g5METrmU2ubKTjHJL4AJE24zQ3NyBufUqilZsv9ZaX52Q/MAaHSfbVk50trN/UnCZO8k5hSZjkkU0/XX/voYlLmxJzZxKxa27ZJbZTADzIJBEuZIo/Uy5CEn2Mb9vQKd64XV81EvD6NHx/mVhF6B4e1hkc6GfQAjh6FlO+Bt9zrV9abRW1MPPFjwcQoe3TyxUinF2PZjRSdw4y0oqgSKruleMZVq1+OxcgYbYjhD0LhQvpV4/dZJCJZxMaG6iaxva5ic41fesrC5q+pYU36CplqsRrHZAHX95E/4FiaUTn8KWOHP0V2qCsuFrMdT8UfZmCnq53dZRsmmT5uFXsE+m5AGR+XVTAYDcNSNbaxWIdZ7U686Equ17X2Bqv4IqwX92zKdi1+UPSmFExquOpwDnGYgVq+kFnZo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99b8a20-0bc7-49ae-5a38-08d6de9c376f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:59:45.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
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
cmFuc2ZlciB0bw0KICAgICAgIGJlIHNlbnQgdHdpY2UNClNvIHJldmVydCBjb21taXQgJ2RmMDcx
MDFlMWM0YScgZmlyc3RseS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29u
Z0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaSB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2
cS5kdHNpDQppbmRleCBkMDM4ZjQxLi43MTc1ODk4IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnEuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaQ0KQEAg
LTE3Miw3ICsxNzIsNyBAQA0KIAkJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZRX0NMS19FQ1NQSTU+
LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFfQ0xLX0VDU1BJNT47DQogCQkJCQljbG9jay1uYW1lcyA9
ICJpcGciLCAicGVyIjsNCi0JCQkJCWRtYXMgPSA8JnNkbWEgMTEgOCAxPiwgPCZzZG1hIDEyIDgg
Mj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDExIDcgMT4sIDwmc2RtYSAxMiA3IDI+Ow0KIAkJCQkJ
ZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJ
CX07DQotLSANCjIuNy40DQoNCg==

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E795C1607B
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEGJRF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:17:05 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:26283
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727079AbfEGJRE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scAqqGt5yoPaSrcQ2/nd3cG8Kz6Tt66Vsg7Gk4jfTV0=;
 b=Fq1WMua3iOnMUsxcybnu3u+p4Sfo7vaq0xdHZFTOIPrQw7ZGJ0CuROfFRYdmqJfnYWpTfpqY/vlW6/ngBhZSfyGcai3Sxnlw4ft5wcfelG1u+PGfjc0MddWVuZeQW3uOs6lJck2HsR2QfXEmfFR0xDJ9tGmgyBys7EvX6K46x6Y=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:16:57 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:57 +0000
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
Subject: [PATCH v3 13/14] ARM: dts: imx6sll: correct sdma compatible
Thread-Topic: [PATCH v3 13/14] ARM: dts: imx6sll: correct sdma compatible
Thread-Index: AQHVBLWe5vdyXKfEb0GhX6YfVDDR5Q==
Date:   Tue, 7 May 2019 09:16:57 +0000
Message-ID: <1557249513-4903-14-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 26486173-d82f-4598-012b-08d6d2ccc09e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5005;
x-ms-traffictypediagnostic: VI1PR04MB5005:
x-microsoft-antispam-prvs: <VI1PR04MB50056A8CAE7F4A300FFCD7B989310@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(386003)(6506007)(2501003)(36756003)(102836004)(6486002)(26005)(8676002)(4326008)(5660300002)(25786009)(68736007)(52116002)(76176011)(186003)(4744005)(2201001)(6512007)(53936002)(3846002)(71200400001)(14444005)(66556008)(86362001)(66446008)(64756008)(476003)(66476007)(7416002)(305945005)(2906002)(11346002)(7736002)(66066001)(6116002)(99286004)(54906003)(256004)(14454004)(2616005)(73956011)(110136005)(6436002)(50226002)(8936002)(81156014)(81166006)(66946007)(316002)(71190400001)(486006)(478600001)(446003)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s/LXu9n/CZBDh/Wh0nBrjGVcny8GPYrln06UjnHjiw+5UW+rSnITJ9q1PO1t2mxeiI5h3Vd39P2SjQ/urBzcPLEkI9AzZ0XHfwE19voyyO2Aw2zCxon+7Fbl7JwC2ZY1H3CXPRSAViGwxvUaL8lOvAx1M/F75wXT0nJIc06kfaJLM7hAluGv/fef9YwdULSR+x+EBUi5cCiLTa0kNt+0so7VN2b5Oczr0i1bFQEs/2wSwbeM0jyPvSv9WkklL3p0epKP91u56mfMH8wU30Fm9Dro9tpGfsO7LVeUJ4hXr2/mU5TUrconhFKGBsrjs3ykDfmeB/f34ULMHDIQdT09Wph5GMW1ChLTcN5mw10Y+zzVAaxrfSf5CMOxiAqowq0WNUF2Tagpke7IGX1emqfUapyopbwCVTahjeBkHXqralg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26486173-d82f-4598-012b-08d6d2ccc09e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:57.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
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

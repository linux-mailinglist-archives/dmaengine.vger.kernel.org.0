Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7235116087
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfEGJRB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:17:01 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:57499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbfEGJRA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOw/nd6mZWn6uySvaALabGejFn7LilUgKaLDKkOCWTc=;
 b=gXjQHth1NDwR4pW2HCVfMTndn/Pda4BhXJAGy6MlFetuVy+Xs4AsW/6ZSRob9BDEziWXj5mgLbNrrTUWlJ3UL1VdthURGEaxUS/cPLsgfCbmKiu+6GT33jXe3VWVFCAVkOVpQTFIiUo6wVwO+tyLMr63hVMpgXcz63YCdtqWO8A=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:16:38 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:38 +0000
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
Subject: [PATCH v3 10/14] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx
 compatible name
Thread-Topic: [PATCH v3 10/14] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx
 compatible name
Thread-Index: AQHVBLWTt0OSjK9EeEapvrzqhcMqNA==
Date:   Tue, 7 May 2019 09:16:38 +0000
Message-ID: <1557249513-4903-11-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 791a86a3-037e-4b52-e4f1-08d6d2ccb549
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5005;
x-ms-traffictypediagnostic: VI1PR04MB5005:
x-microsoft-antispam-prvs: <VI1PR04MB5005C9B3E8F776005C08A89189310@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(386003)(6506007)(2501003)(36756003)(102836004)(6486002)(26005)(8676002)(4326008)(5660300002)(25786009)(68736007)(52116002)(76176011)(186003)(4744005)(2201001)(6512007)(53936002)(3846002)(71200400001)(66556008)(86362001)(66446008)(64756008)(476003)(66476007)(7416002)(305945005)(2906002)(11346002)(7736002)(66066001)(6116002)(99286004)(54906003)(256004)(14454004)(2616005)(73956011)(110136005)(6436002)(50226002)(8936002)(81156014)(81166006)(66946007)(316002)(71190400001)(486006)(478600001)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GfUKTv5MTsHR8klmvi7oimgmC/y4Yln3fxgV/SJhid4TOPk9MbrBiBqOaXW7UWwdvBMXmcNU37CRLnee2qRRU/IcjpzvoKLWdbpC0Z/aHU2AJOL8GCx7pJz2/VCXj3ewEOVtt+5JLBC38vEX2a4Jqne4CQBu2fVXaLWp7dn4T9XeBlaxIC9pfjvw8jC9EhzlfT277pgTugRrCgzD8U1toA1FMtw7uObw+ALe14gLGvQBLp7hVLkis3KZFNGJiZ68c9rMCXFtkoAazpIMPcuPRFyfC3XJbL811+3a3+hKk7ge+9IYHUYaOYqmgDmmvXqsZOpI0mUZmPykTmL9BcFP+EsMsTqYE/OK+xfXuDiPCOaavpVJLrfpj/Iuae1XQSc+48+U8fVs9Nh3qzhavkN4RzHY12EHgMvLhlW+8RHq+V4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791a86a3-037e-4b52-e4f1-08d6d2ccb549
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:38.0567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QWRkIGkubXg2dWwgYW5kIGkubXg2c3ggY29tcGF0aWJsZSBuYW1lLg0KDQpTaWduZWQtb2ZmLWJ5
OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQgfCAyICsrDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQppbmRleCA5ZDhiYmFjLi5kMDI0
YTgzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9m
c2wtaW14LXNkbWEudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL2ZzbC1pbXgtc2RtYS50eHQNCkBAIC05LDYgKzksOCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KICAgICAgICJmc2wsaW14NTMtc2RtYSINCiAgICAgICAiZnNsLGlteDZxLXNkbWEiDQogICAg
ICAgImZzbCxpbXg3ZC1zZG1hIg0KKyAgICAgICJmc2wsaW14NnN4LXNkbWEiDQorICAgICAgImZz
bCxpbXg2dWwtc2RtYSINCiAgICAgICAiZnNsLGlteDhtcS1zZG1hIg0KICAgVGhlIC10byB2YXJp
YW50cyBzaG91bGQgYmUgcHJlZmVycmVkIHNpbmNlIHRoZXkgYWxsb3cgdG8gZGV0ZXJtaW5lIHRo
ZQ0KICAgY29ycmVjdCBST00gc2NyaXB0IGFkZHJlc3NlcyBuZWVkZWQgZm9yIHRoZSBkcml2ZXIg
dG8gd29yayB3aXRob3V0IGFkZGl0aW9uYWwNCi0tIA0KMi43LjQNCg0K

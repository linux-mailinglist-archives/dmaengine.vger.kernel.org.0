Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67926117
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfEVKAm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:42 -0400
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:50693
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbfEVKAl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCc3iGSXOg2WvBHHOsJIocqHBRmiOZmoCm1AE1MQLcI=;
 b=Pn0U9w2f/lKkCHqymnW1WCLQI+jn5I2zyHRk2A/RneM5LKcS0XGrSgqtP4TuTAXlhwOpcTCNkyXrmwkBhxspxureaTw3pb9BWsYm/PLSVde4V1wNHoDIxJkbl0EtVv8ykRDOZZ53k3nR5oFrWaQA6SVmfhzMuJSVKYpBZNd+eVk=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:38 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:38 +0000
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
Subject: [PATCH v4 10/14] dma: imx-sdma: add i.mx6ul/6sx compatible name
Thread-Topic: [PATCH v4 10/14] dma: imx-sdma: add i.mx6ul/6sx compatible name
Thread-Index: AQHVEIU1vbltRMJezUidB/k1RHkv6w==
Date:   Wed, 22 May 2019 10:00:38 +0000
Message-ID: <1558548188-1155-11-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 284774ee-0463-4e1d-4bb0-08d6de9c572a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-microsoft-antispam-prvs: <VI1PR04MB3149E6D1491C4733BFEEA2D289000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(4744005)(71200400001)(36756003)(6512007)(99286004)(7416002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(66556008)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kBDN5U4CakCpcfqzJhecdO2IVXIv3tdlyxzCvY9cVIoCur73kDHAQ1I5f+s4lgo78FyppGLYj4IcMG9FYCDTD6hzOlX0hOhusycgtCsHblM5CY+RMhOVImbVddEFxDE8G7h9r6jiaOk1nqBRW526nSeaQdoKzokkNfsdQ2fiAg6DxEqom1YfdxsYP1Fm1zZdft9VlFHhB1tkc4M9no3xzk6kXOp6UTGvMgH9ToHX3ipE8ab52512PMh0jkD9WBwSuhER4Xhc8vDeFFRQ6VcxBVNvI3lmZR3I5FvOwqnOxhcGw8CLXmn60SLNpMEgJviI08ulC/Af7hOO2B/u3NWFlsqYSX00ufdw3+G/xox+/BeC05aDNRLL866mZ7WqtdxxszKwvqCZUtuZR/+6QDdc98fzct1nYH9bw1pXuUzn+yk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284774ee-0463-4e1d-4bb0-08d6de9c572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:38.4414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QWRkIGkubXg2dWwgYW5kIGkubXg2c3ggY29tcGF0aWJsZSBuYW1lIGluIGJpbmRpbmcgZG9jLg0K
DQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQgfCAy
ICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQppbmRl
eCA5ZDhiYmFjLi5kMDI0YTgzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQNCkBAIC05LDYgKzksOCBAQCBSZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KICAgICAgICJmc2wsaW14NTMtc2RtYSINCiAgICAgICAiZnNsLGlt
eDZxLXNkbWEiDQogICAgICAgImZzbCxpbXg3ZC1zZG1hIg0KKyAgICAgICJmc2wsaW14NnN4LXNk
bWEiDQorICAgICAgImZzbCxpbXg2dWwtc2RtYSINCiAgICAgICAiZnNsLGlteDhtcS1zZG1hIg0K
ICAgVGhlIC10byB2YXJpYW50cyBzaG91bGQgYmUgcHJlZmVycmVkIHNpbmNlIHRoZXkgYWxsb3cg
dG8gZGV0ZXJtaW5lIHRoZQ0KICAgY29ycmVjdCBST00gc2NyaXB0IGFkZHJlc3NlcyBuZWVkZWQg
Zm9yIHRoZSBkcml2ZXIgdG8gd29yayB3aXRob3V0IGFkZGl0aW9uYWwNCi0tIA0KMi43LjQNCg0K

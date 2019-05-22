Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5025260F3
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfEVKAB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:01 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:31364
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729145AbfEVKAA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne8lUTHYIL86i2wNgDyCIKewW238BE0WWwtYB4rlmGc=;
 b=m7Ck0MGvWJyNgtGPBn9NwqQUl6R9UrHlPF6Kywfem+v2srgrMQqDZszpSzbA4N+1fAQrHOithtr2XS7dp9lRVKiabsngAs9gKPG2HgCvcMN/ACsROHkQahlM9xL5UlqfNBqGuaZw4jZWT8FaMm/CQQABxUicFtdh6qOCyTwMPjo=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3103.eurprd04.prod.outlook.com (10.170.229.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 09:59:56 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 09:59:56 +0000
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
Subject: [PATCH v4 03/14] Revert "dmaengine: imx-sdma: refine to load context
 only once"
Thread-Topic: [PATCH v4 03/14] Revert "dmaengine: imx-sdma: refine to load
 context only once"
Thread-Index: AQHVEIUcooXNsGt30kGAg9mv40OQWQ==
Date:   Wed, 22 May 2019 09:59:56 +0000
Message-ID: <1558548188-1155-4-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5198f41b-7940-4489-8ae2-08d6de9c3e5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3103;
x-ms-traffictypediagnostic: VI1PR04MB3103:
x-microsoft-antispam-prvs: <VI1PR04MB310374DB00236321CA76A9F189000@VI1PR04MB3103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:119;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(68736007)(81166006)(2201001)(2501003)(52116002)(71200400001)(14454004)(186003)(256004)(14444005)(26005)(53936002)(7736002)(25786009)(81156014)(305945005)(8936002)(4326008)(86362001)(8676002)(50226002)(71190400001)(486006)(6512007)(5660300002)(6436002)(66946007)(73956011)(498600001)(446003)(66446008)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(99286004)(386003)(6506007)(2906002)(54906003)(76176011)(36756003)(11346002)(110136005)(7416002)(2616005)(6486002)(102836004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3103;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y8oAKkUHnkvIIgIjNIEA3PwfuQhy6FttTbW/93WME0lgYzqshVGp5OlnC6UqU24GRuWS7x7GQD0K7p7zHm6H5rI3yJ2/68cj1OhfVKByL1EHJdazo4mWsbLOGab6dilxpfEazYJaMD/Z9GrZGyzyRil5VzdSJA3XopWi8IEzRa8hN2TN01rSX3Nvr32qy/MT/qPhP7AUgJgK8XXykWt7E2iseTfECuh0pXFbENQmGaPEgQRk2DajXJVi1y7KLhxqXxMB2xVik8QEE33OscwStE2y85AgkHzx981+++CfalPKiqMiOgGZJy00CBWqeHAiZtVgNCBlEkGaLn9wBsqTChywr6Te4C+RlOcsG3l71lb7D4tpXsQEJd5Hr3o5uUW5180J3p9Xt6rqgdALN4+afYQRRF6t3EyToFkjPirbtqc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5198f41b-7940-4489-8ae2-08d6de9c3e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 09:59:56.8392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBhZDBkOTJkN2JhNmFlY2JlMjcwNTkwN2MzOGZmOGQ4YmU0ZGEx
ZTljLCBiZWNhdXNlDQppbiBzcGktaW14IGNhc2UsIGJ1cnN0IGxlbmd0aCBtYXkgYmUgY2hhbmdl
ZCBkeW5hbWljYWxseS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0Bu
eHAuY29tPg0KLS0tDQogZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDcgLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDk5ZDlmNDMuLjQwN2E1NmUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9p
bXgtc2RtYS5jDQpAQCAtMzc3LDcgKzM3Nyw2IEBAIHN0cnVjdCBzZG1hX2NoYW5uZWwgew0KIAl1
bnNpZ25lZCBsb25nCQkJd2F0ZXJtYXJrX2xldmVsOw0KIAl1MzIJCQkJc2hwX2FkZHIsIHBlcl9h
ZGRyOw0KIAllbnVtIGRtYV9zdGF0dXMJCQlzdGF0dXM7DQotCWJvb2wJCQkJY29udGV4dF9sb2Fk
ZWQ7DQogCXN0cnVjdCBpbXhfZG1hX2RhdGEJCWRhdGE7DQogCXN0cnVjdCB3b3JrX3N0cnVjdAkJ
dGVybWluYXRlX3dvcmtlcjsNCiB9Ow0KQEAgLTk4OCw5ICs5ODcsNiBAQCBzdGF0aWMgaW50IHNk
bWFfbG9hZF9jb250ZXh0KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KIAlpbnQgcmV0Ow0K
IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIA0KLQlpZiAoc2RtYWMtPmNvbnRleHRfbG9hZGVkKQ0K
LQkJcmV0dXJuIDA7DQotDQogCWlmIChzZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fTUVN
KQ0KIAkJbG9hZF9hZGRyZXNzID0gc2RtYWMtPnBjX2Zyb21fZGV2aWNlOw0KIAllbHNlIGlmIChz
ZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fREVWKQ0KQEAgLTEwMzMsOCArMTAyOSw2IEBA
IHN0YXRpYyBpbnQgc2RtYV9sb2FkX2NvbnRleHQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMp
DQogDQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNkbWEtPmNoYW5uZWxfMF9sb2NrLCBmbGFn
cyk7DQogDQotCXNkbWFjLT5jb250ZXh0X2xvYWRlZCA9IHRydWU7DQotDQogCXJldHVybiByZXQ7
DQogfQ0KIA0KQEAgLTEwNzQsNyArMTA2OCw2IEBAIHN0YXRpYyB2b2lkIHNkbWFfY2hhbm5lbF90
ZXJtaW5hdGVfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogCXNkbWFjLT5kZXNjID0g
TlVMTDsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2RtYWMtPnZjLmxvY2ssIGZsYWdzKTsN
CiAJdmNoYW5fZG1hX2Rlc2NfZnJlZV9saXN0KCZzZG1hYy0+dmMsICZoZWFkKTsNCi0Jc2RtYWMt
PmNvbnRleHRfbG9hZGVkID0gZmFsc2U7DQogfQ0KIA0KIHN0YXRpYyBpbnQgc2RtYV9kaXNhYmxl
X2NoYW5uZWxfYXN5bmMoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KLS0gDQoyLjcuNA0KDQo=

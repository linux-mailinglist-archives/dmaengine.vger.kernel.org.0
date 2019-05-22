Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E492611F
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEVKB2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:01:28 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:18971
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728942AbfEVKB2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dncx24V94UiZzNz3FmPxPytFt84+LcaUrVLQIrZ4TuQ=;
 b=iwAgvlu7FZjX0iAN7+nYCMtIx10DJw4mW1LJ3U6geLaeOwKWtHeC1QNJtp+FRH5nAr5FHnaPVDeGBXtrUHzgdmP5dXp16ALWQxsPfvNvdUex4OMeVHpVdUF9Pxb+wt59hU2xzEOLwFkFXa+idNGMoXLJwiE7hIr2pp3I8sSKWak=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:44 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:44 +0000
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
Subject: [PATCH v4 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work on
 i.mx8mm
Thread-Topic: [PATCH v4 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHVEIU4IH98ryzb1UOeRNgXW44V+w==
Date:   Wed, 22 May 2019 10:00:44 +0000
Message-ID: <1558548188-1155-12-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: c6672de5-493b-4a81-8e9e-08d6de9c5ab1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-microsoft-antispam-prvs: <VI1PR04MB314953A23689FFEF3A3F8F5989000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(71200400001)(36756003)(6512007)(99286004)(7416002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(14444005)(66556008)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lox5lf8i5yrr0MExOBtUot/uxNgX0Se1LBH9bUCibN+0zveWqUR/Qwv2GXX90mxdAJyKJpyK4yhQDIWKwTtUMIMiEEccUaNJkTBBK7x7I+zHREVuiyjYmjKKMDxzFBjD2L/GV1rZF28Q4aN8d4BxR0FIe5GcEDjdgk+9F2Ku3M9wRq98HVJnE8KuZRMrp/R35J4milu/B80rB0w0PkGuUGjRezaFxKc4Jh1osz7dej+wATHR35dNpfn1NoO4R2DJUe+I3C6eGbZw/70uxorPgEMFPV+Ru3prFwL1EQgqm1AeTfRLOOg5pzALxfzmGMqIfUEZwmctg4pQzeA8vpNsL5QvSgVK4m7/vKacplweDqKQJ7yXZD7tHh3yGuLKSuK6RxbXkqbN3SCKJ9Lg+iKBffZoytm1/kH3nbMS1Fp101A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6672de5-493b-4a81-8e9e-08d6de9c5ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:44.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRo
ZSBjb25kaXRpb24NCmNoZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBj
aGFubmVsIGVuYWJsZWQsIHdoaWNoIGNhdXNlZA0KZWNzcGkxIHJ4IHdvcmtzIGZhaWxlZC4gQWN0
dWFsbHksIG5vIG5lZWQgdG8gY2hlY2sgZXZlbnRfaWQwL2V2ZW50X2lkMQ0KYW5kIHJlcGxhY2Ug
Y2hlY2tpbmcgJ2V2ZW50X2lkMScgd2l0aCAnRE1BX0RFVl9UT19ERVYnLCBzbyB0aGF0IGNvbmZp
Z3VyZQ0KZXZlbnRfaWQxIG9ubHkgaW4gY2FzZSBERVZfVE9fREVWLg0KDQpTaWduZWQtb2ZmLWJ5
OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgt
c2RtYS5jIHwgMTggKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgt
c2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KaW5kZXggYTQ5NWM3Zi4uYjY5Mjc4MyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL2lt
eC1zZG1hLmMNCkBAIC0xMjAyLDcgKzEyMDIsNyBAQCBzdGF0aWMgaW50IHNkbWFfY29uZmlnX2No
YW5uZWwoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KIAlpZiAoKHNkbWFjLT5wZXJpcGhlcmFsX3R5
cGUgIT0gSU1YX0RNQVRZUEVfTUVNT1JZKSAmJg0KIAkJCShzZG1hYy0+cGVyaXBoZXJhbF90eXBl
ICE9IElNWF9ETUFUWVBFX0RTUCkpIHsNCiAJCS8qIEhhbmRsZSBtdWx0aXBsZSBldmVudCBjaGFu
bmVscyBkaWZmZXJlbnRseSAqLw0KLQkJaWYgKHNkbWFjLT5ldmVudF9pZDEpIHsNCisJCWlmIChz
ZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fREVWKSB7DQogCQkJaWYgKHNkbWFjLT5wZXJp
cGhlcmFsX3R5cGUgPT0gSU1YX0RNQVRZUEVfQVNSQ19TUCB8fA0KIAkJCSAgICBzZG1hYy0+cGVy
aXBoZXJhbF90eXBlID09IElNWF9ETUFUWVBFX0FTUkMpDQogCQkJCXNkbWFfc2V0X3dhdGVybWFy
a2xldmVsX2Zvcl9wMnAoc2RtYWMpOw0KQEAgLTEzNzAsOSArMTM3MCw5IEBAIHN0YXRpYyB2b2lk
IHNkbWFfZnJlZV9jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pDQogDQogCXNk
bWFfY2hhbm5lbF9zeW5jaHJvbml6ZShjaGFuKTsNCiANCi0JaWYgKHNkbWFjLT5ldmVudF9pZDAp
DQotCQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0KLQlpZiAo
c2RtYWMtPmV2ZW50X2lkMSkNCisJc2RtYV9ldmVudF9kaXNhYmxlKHNkbWFjLCBzZG1hYy0+ZXZl
bnRfaWQwKTsNCisNCisJaWYgKHNkbWFjLT5kaXJlY3Rpb24gPT0gRE1BX0RFVl9UT19ERVYpDQog
CQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDEpOw0KIA0KIAlzZG1h
Yy0+ZXZlbnRfaWQwID0gMDsNCkBAIC0xNjcwLDEzICsxNjcwLDExIEBAIHN0YXRpYyBpbnQgc2Rt
YV9jb25maWcoc3RydWN0IGRtYV9jaGFuICpjaGFuLA0KIAltZW1jcHkoJnNkbWFjLT5zbGF2ZV9j
b25maWcsIGRtYWVuZ2luZV9jZmcsIHNpemVvZigqZG1hZW5naW5lX2NmZykpOw0KIA0KIAkvKiBT
ZXQgRU5CTG4gZWFybGllciB0byBtYWtlIHN1cmUgZG1hIHJlcXVlc3QgdHJpZ2dlcmVkIGFmdGVy
IHRoYXQgKi8NCi0JaWYgKHNkbWFjLT5ldmVudF9pZDApIHsNCi0JCWlmIChzZG1hYy0+ZXZlbnRf
aWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLQkJCXJldHVybiAtRUlO
VkFMOw0KLQkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0KLQl9
DQorCWlmIChzZG1hYy0+ZXZlbnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZl
bnRzKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorCXNkbWFfZXZlbnRfZW5hYmxlKHNkbWFjLCBzZG1h
Yy0+ZXZlbnRfaWQwKTsNCiANCi0JaWYgKHNkbWFjLT5ldmVudF9pZDEpIHsNCisJaWYgKHNkbWFj
LT5kaXJlY3Rpb24gPT0gRE1BX0RFVl9UT19ERVYpIHsNCiAJCWlmIChzZG1hYy0+ZXZlbnRfaWQx
ID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KIAkJCXJldHVybiAtRUlOVkFM
Ow0KIAkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDEpOw0KLS0gDQoy
LjcuNA0KDQo=

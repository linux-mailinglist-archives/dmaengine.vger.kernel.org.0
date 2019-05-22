Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D22260FB
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfEVKAN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:13 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:29424
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729198AbfEVKAM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gg8NGnxlCeTy7TsIPabst/9jj6hRd9ySIiJgwD3W9A=;
 b=lyEfIHnEoPwAIrisoNEum/o8GusjzOz2seZP/BbTVNtCpwWWgnp8kkHLHTqqztjYeZlSlpaHiihYaxSlMLDziliADuZtlnx5DTV5tXCPFXIMZrVQEy4e69wrI9ryH0Zu7UJ71CjylEOBftbTlijffkcGBkOr5qaadixecvVuQE4=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3103.eurprd04.prod.outlook.com (10.170.229.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:09 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:09 +0000
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
Subject: [PATCH v4 05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
Thread-Topic: [PATCH v4 05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
Thread-Index: AQHVEIUjm3xKCu6AA0qu2fwIMJMuqw==
Date:   Wed, 22 May 2019 10:00:08 +0000
Message-ID: <1558548188-1155-6-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: b9772486-2412-4b4f-d306-08d6de9c4575
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3103;
x-ms-traffictypediagnostic: VI1PR04MB3103:
x-microsoft-antispam-prvs: <VI1PR04MB310333940BAA648954CBED1B89000@VI1PR04MB3103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(68736007)(81166006)(2201001)(2501003)(52116002)(71200400001)(14454004)(186003)(256004)(26005)(53936002)(7736002)(25786009)(81156014)(305945005)(8936002)(4326008)(86362001)(8676002)(50226002)(71190400001)(486006)(6512007)(5660300002)(6436002)(66946007)(73956011)(498600001)(446003)(66446008)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(99286004)(386003)(6506007)(2906002)(54906003)(76176011)(36756003)(11346002)(110136005)(7416002)(2616005)(6486002)(102836004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3103;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wLiXKciDVmoGwp1GEXgMlcBtU3gTKIaL2DR2eoZLoYFcgMYoBIR/VocwTGSRT9/A9YlbEGDNjfoTNc27EOthy8Vkd0BYGyR8kPcAHyaK8OrXbiDEIp6+yMxSF94BbOP0XBw0DYynp9aZyzMPb6H4bIWepDDW40ESk4uHSl3Ag7JLOdncTB+gUHUuo3s4Wx3YVq7wnMajyhRDtTJgAnuSRXCM3LKvp7OAA120ik0dJidtd6I2lGFzJbKMPUvxyVWRxLXufXShBzyAHPTfx8m2BaiWu3U6ldiphVIaZxvgj/4plU6866x5bnaojV+lLkrApq6MCGZcRxDq0CadlnPc/ZoKjCmll2OiqUr8u8wkW46p30FE8Lv9KRQtXfhHYCXPEawydN2ZpJgbQfl2PadT8EA5KdObfaio/mm0NSGAEII=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9772486-2412-4b4f-d306-08d6de9c4575
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:09.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QWRkIG1jdV8yX2Vjc3BpIHNjcmlwdCB0byBmaXggZWNzcGkgZXJyYXRhIEVSUjAwOTE2NS4NCg0K
U2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KQWNrZWQtYnk6
IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jICAgICAgICAgICAgICAgICAgICAgfCAzICsrKw0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1f
ZGF0YS9kbWEtaW14LXNkbWEuaCB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEv
aW14LXNkbWEuYw0KaW5kZXggODZhMzFiNC4uMzUyYjBkNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
ZG1hL2lteC1zZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCkBAIC05MjQsNiAr
OTI0LDkgQEAgc3RhdGljIHZvaWQgc2RtYV9nZXRfcGMoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2Rt
YWMsDQogCQllbWlfMl9wZXIgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPm1jdV8yX2F0YV9hZGRyOw0K
IAkJYnJlYWs7DQogCWNhc2UgSU1YX0RNQVRZUEVfQ1NQSToNCisJCXBlcl8yX2VtaSA9IHNkbWEt
PnNjcmlwdF9hZGRycy0+YXBwXzJfbWN1X2FkZHI7DQorCQllbWlfMl9wZXIgPSBzZG1hLT5zY3Jp
cHRfYWRkcnMtPm1jdV8yX2Vjc3BpX2FkZHI7DQorCQlicmVhazsNCiAJY2FzZSBJTVhfRE1BVFlQ
RV9FWFQ6DQogCWNhc2UgSU1YX0RNQVRZUEVfU1NJOg0KIAljYXNlIElNWF9ETUFUWVBFX1NBSToN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmgg
Yi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmgNCmluZGV4IDZlYWE1
M2MuLmY3OTRmZWUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1h
LWlteC1zZG1hLmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNk
bWEuaA0KQEAgLTUxLDYgKzUxLDcgQEAgc3RydWN0IHNkbWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHsN
CiAJLyogRW5kIG9mIHYyIGFycmF5ICovDQogCXMzMiB6Y2FuZmRfMl9tY3VfYWRkcjsNCiAJczMy
IHpxc3BpXzJfbWN1X2FkZHI7DQorCXMzMiBtY3VfMl9lY3NwaV9hZGRyOw0KIAkvKiBFbmQgb2Yg
djMgYXJyYXkgKi8NCiB9Ow0KIA0KLS0gDQoyLjcuNA0KDQo=

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACB26108
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfEVKAZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:25 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:47078
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbfEVKAY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ADy7pLlzZYEYZaDPAxQBNKiAyltF4OeNTnp/jzk1o=;
 b=FVcotXTgzhmJJz22ju4fu5bd8My8u6dy8FS/AAlr39Sh8amZyRCiU0kRZQp6phPnJhsnw7m64g3mOhZ/YQagk/wl8xwUFiwNcfAINo3hk8jCEaCAiRROQ2Nj2LW+1TrkULu4HAYUDmU3tYUUv6lie7GBw/empMcVc/20mDg5qXI=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:20 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:20 +0000
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
Subject: [PATCH v4 07/14] spi: imx: remove ERR009165 workaround on i.mx6ul
Thread-Topic: [PATCH v4 07/14] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Thread-Index: AQHVEIUq6WzqjupH2U+A6iNqXBfmAg==
Date:   Wed, 22 May 2019 10:00:20 +0000
Message-ID: <1558548188-1155-8-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 341ea908-89b4-447c-ea08-08d6de9c4ca3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB3149A08A3E1B58D541B12C3289000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(71200400001)(36756003)(6512007)(99286004)(7416002)(6306002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(966005)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(14444005)(66556008)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1BHSK8nnzsWCeds0SBEAuqakfbTwQ66uTv9R5OCbAp7jvA6csJhJJ1zXb9PLV4ftLkN3USaGsoI2nXhUdSK+Mol8AZPY27XtT1lqLixBIQz4I7ShfPBq866hThzGeG35uUDpL8f5mIm0blV5CIQ5FNOhzs3soUsKMVLWJBXZekZ9aBuwX+oS+qQHxuO26+apyiPeaIQJHXm09UVS2qqUTwm1/r7qoj3D0gmvHdF3iAck6Gwyr/7hr5B79bys9yfBGJGdxySo1Z7UN44l13BHihmHaqN4CFZvvE/osC5nVj1W+PtrNfQkHS9wgdFvjGe51oqYYu5eljxviwc30uJCAa8k9iPf+VCAc+9rc8hLdT+pGwPVkJceLywD+9q5hC0xSWiGmsP+3puzXxCFktMcFdHY655y0KAFfFYBG8JVkdE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341ea908-89b4-447c-ea08-08d6de9c4ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:20.5087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RVJSMDA5MTY1IGZpeGVkIG9uIGkubXg2dWwvNnVsbC82c2xsLiBBbGwgb3RoZXIgaS5teDYvNyBh
bmQNCmkubXg4bS84bW0gc3RpbGwgbmVlZCB0aGlzIGVycmF0YS4gUGxlYXNlIHJlZmVyIHRvIG54
cCBvZmZpY2lhbA0KZXJyYXRhIGRvY3VtZW50IGZyb20gaHR0cHM6Ly93d3cubnhwLmNvbS8gLg0K
DQpGb3IgcmVtb3Zpbmcgd29ya2Fyb3VuZCBvbiB0aG9zZSBjaGlwcy4gQWRkIG5ldyBpLm14NnVs
IHR5cGUuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4N
CkFja2VkLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQotLS0NCiBkcml2ZXJz
L3NwaS9zcGktaW14LmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWlteC5jIGIvZHJpdmVycy9z
cGkvc3BpLWlteC5jDQppbmRleCA2Nzk1OTEwLi45MTY2MGRjIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9zcGkvc3BpLWlteC5jDQorKysgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCkBAIC01Nyw2ICs1
Nyw3IEBAIGVudW0gc3BpX2lteF9kZXZ0eXBlIHsNCiAJSU1YMzVfQ1NQSSwJLyogQ1NQSSBvbiBh
bGwgaS5teCBleGNlcHQgYWJvdmUgKi8NCiAJSU1YNTFfRUNTUEksCS8qIEVDU1BJIG9uIGkubXg1
MSAqLw0KIAlJTVg1M19FQ1NQSSwJLyogRUNTUEkgb24gaS5teDUzIGFuZCBsYXRlciAqLw0KKwlJ
TVg2VUxfRUNTUEksCS8qIEVSUjAwOTE2NSBmaXggZnJvbSBpLm14NnVsICovDQogfTsNCiANCiBz
dHJ1Y3Qgc3BpX2lteF9kYXRhOw0KQEAgLTc1LDYgKzc2LDExIEBAIHN0cnVjdCBzcGlfaW14X2Rl
dnR5cGVfZGF0YSB7DQogCWJvb2wgaGFzX3NsYXZlbW9kZTsNCiAJdW5zaWduZWQgaW50IGZpZm9f
c2l6ZTsNCiAJYm9vbCBkeW5hbWljX2J1cnN0Ow0KKwkvKg0KKwkgKiBFUlIwMDkxNjUgZml4ZWQg
b3Igbm90Og0KKwkgKiBodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZEUUNF
LnBkZg0KKwkgKi8NCisJYm9vbCB0eF9nbGl0Y2hfZml4ZWQ7DQogCWVudW0gc3BpX2lteF9kZXZ0
eXBlIGRldnR5cGU7DQogfTsNCiANCkBAIC0xMjgsNyArMTM0LDggQEAgc3RhdGljIGlubGluZSBp
bnQgaXNfaW14MzVfY3NwaShzdHJ1Y3Qgc3BpX2lteF9kYXRhICpkKQ0KIA0KIHN0YXRpYyBpbmxp
bmUgaW50IGlzX2lteDUxX2Vjc3BpKHN0cnVjdCBzcGlfaW14X2RhdGEgKmQpDQogew0KLQlyZXR1
cm4gZC0+ZGV2dHlwZV9kYXRhLT5kZXZ0eXBlID09IElNWDUxX0VDU1BJOw0KKwlyZXR1cm4gZC0+
ZGV2dHlwZV9kYXRhLT5kZXZ0eXBlID09IElNWDUxX0VDU1BJIHx8DQorCSAgICAgICBkLT5kZXZ0
eXBlX2RhdGEtPmRldnR5cGUgPT0gSU1YNlVMX0VDU1BJOw0KIH0NCiANCiBzdGF0aWMgaW5saW5l
IGludCBpc19pbXg1M19lY3NwaShzdHJ1Y3Qgc3BpX2lteF9kYXRhICpkKQ0KQEAgLTU4NSw5ICs1
OTIsMTYgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBhcmVfdHJhbnNmZXIoc3RydWN0IHNw
aV9pbXhfZGF0YSAqc3BpX2lteCwNCiAJY3RybCB8PSBteDUxX2Vjc3BpX2Nsa2RpdihzcGlfaW14
LCB0LT5zcGVlZF9oeiwgJmNsayk7DQogCXNwaV9pbXgtPnNwaV9idXNfY2xrID0gY2xrOw0KIA0K
LQkvKiBFUlIwMDkxNjU6IHdvcmsgaW4gWEhDIG1vZGUgYXMgUElPICovDQotCWlmIChzcGlfaW14
LT51c2VkbWEpDQotCQljdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01DOw0KKwkvKg0KKwkgKiBF
UlIwMDkxNjU6IHdvcmsgaW4gWEhDIG1vZGUgaW5zdGVhZCBvZiBTTUMgYXMgUElPIG9uIHRoZSBj
aGlwcw0KKwkgKiBiZWZvcmUgaS5teDZ1bC4NCisJICovDQorCWlmIChzcGlfaW14LT51c2VkbWEp
IHsNCisJCWlmIChzcGlfaW14LT5kZXZ0eXBlX2RhdGEtPnR4X2dsaXRjaF9maXhlZCkNCisJCQlj
dHJsIHw9IE1YNTFfRUNTUElfQ1RSTF9TTUM7DQorCQllbHNlDQorCQkJY3RybCAmPSB+TVg1MV9F
Q1NQSV9DVFJMX1NNQzsNCisJfQ0KIA0KIAl3cml0ZWwoY3RybCwgc3BpX2lteC0+YmFzZSArIE1Y
NTFfRUNTUElfQ1RSTCk7DQogDQpAQCAtNjE1LDYgKzYyOSw4IEBAIHN0YXRpYyB2b2lkIG14NTFf
c2V0dXBfd21sKHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgpDQogew0KIAl1MzIgdHhfd21s
ID0gMDsNCiANCisJaWYgKHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+dHhfZ2xpdGNoX2ZpeGVkKQ0K
KwkJdHhfd21sID0gc3BpX2lteC0+d21sOw0KIAkvKg0KIAkgKiBDb25maWd1cmUgdGhlIERNQSBy
ZWdpc3Rlcjogc2V0dXAgdGhlIHdhdGVybWFyaw0KIAkgKiBhbmQgZW5hYmxlIERNQSByZXF1ZXN0
Lg0KQEAgLTEwMTIsNiArMTAyOCwyMyBAQCBzdGF0aWMgc3RydWN0IHNwaV9pbXhfZGV2dHlwZV9k
YXRhIGlteDUzX2Vjc3BpX2RldnR5cGVfZGF0YSA9IHsNCiAJLmRldnR5cGUgPSBJTVg1M19FQ1NQ
SSwNCiB9Ow0KIA0KK3N0YXRpYyBzdHJ1Y3Qgc3BpX2lteF9kZXZ0eXBlX2RhdGEgaW14NnVsX2Vj
c3BpX2RldnR5cGVfZGF0YSA9IHsNCisJLmludGN0cmwgPSBteDUxX2Vjc3BpX2ludGN0cmwsDQor
CS5wcmVwYXJlX21lc3NhZ2UgPSBteDUxX2Vjc3BpX3ByZXBhcmVfbWVzc2FnZSwNCisJLnByZXBh
cmVfdHJhbnNmZXIgPSBteDUxX2Vjc3BpX3ByZXBhcmVfdHJhbnNmZXIsDQorCS50cmlnZ2VyID0g
bXg1MV9lY3NwaV90cmlnZ2VyLA0KKwkucnhfYXZhaWxhYmxlID0gbXg1MV9lY3NwaV9yeF9hdmFp
bGFibGUsDQorCS5yZXNldCA9IG14NTFfZWNzcGlfcmVzZXQsDQorCS5zZXR1cF93bWwgPSBteDUx
X3NldHVwX3dtbCwNCisJLmZpZm9fc2l6ZSA9IDY0LA0KKwkuaGFzX2RtYW1vZGUgPSB0cnVlLA0K
KwkuZHluYW1pY19idXJzdCA9IHRydWUsDQorCS5oYXNfc2xhdmVtb2RlID0gdHJ1ZSwNCisJLnR4
X2dsaXRjaF9maXhlZCA9IHRydWUsDQorCS5kaXNhYmxlID0gbXg1MV9lY3NwaV9kaXNhYmxlLA0K
KwkuZGV2dHlwZSA9IElNWDZVTF9FQ1NQSSwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlX2lkIHNwaV9pbXhfZGV2dHlwZVtdID0gew0KIAl7DQogCQkubmFtZSA9
ICJpbXgxLWNzcGkiLA0KQEAgLTEwMzUsNiArMTA2OCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlX2lkIHNwaV9pbXhfZGV2dHlwZVtdID0gew0KIAkJLm5hbWUgPSAiaW14
NTMtZWNzcGkiLA0KIAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmaW14NTNfZWNz
cGlfZGV2dHlwZV9kYXRhLA0KIAl9LCB7DQorCQkubmFtZSA9ICJpbXg2dWwtZWNzcGkiLA0KKwkJ
LmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmaW14NnVsX2Vjc3BpX2RldnR5cGVfZGF0
YSwNCisJfSwgew0KIAkJLyogc2VudGluZWwgKi8NCiAJfQ0KIH07DQpAQCAtMTA0Nyw2ICsxMDgz
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc3BpX2lteF9kdF9pZHNbXSA9
IHsNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14MzUtY3NwaSIsIC5kYXRhID0gJmlteDM1X2Nz
cGlfZGV2dHlwZV9kYXRhLCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg1MS1lY3NwaSIs
IC5kYXRhID0gJmlteDUxX2Vjc3BpX2RldnR5cGVfZGF0YSwgfSwNCiAJeyAuY29tcGF0aWJsZSA9
ICJmc2wsaW14NTMtZWNzcGkiLCAuZGF0YSA9ICZpbXg1M19lY3NwaV9kZXZ0eXBlX2RhdGEsIH0s
DQorCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC1lY3NwaSIsIC5kYXRhID0gJmlteDZ1bF9l
Y3NwaV9kZXZ0eXBlX2RhdGEsIH0sDQogCXsgLyogc2VudGluZWwgKi8gfQ0KIH07DQogTU9EVUxF
X0RFVklDRV9UQUJMRShvZiwgc3BpX2lteF9kdF9pZHMpOw0KQEAgLTExNzgsNyArMTIxNSwxMCBA
QCBzdGF0aWMgaW50IHNwaV9pbXhfZG1hX2NvbmZpZ3VyZShzdHJ1Y3Qgc3BpX21hc3RlciAqbWFz
dGVyKQ0KIAkgKiBGb3IgRVJSMDA5MTY1IHdpdGggdHhfd21sID0gMCBjb3VsZCBlbmxhcmdlIGJ1
cnN0IHNpemUgdG8gZmlmbyBzaXplDQogCSAqIHRvIHNwZWVkIHVwIGZpZm8gZmlsbGluZyBhcyBw
b3NzaWJsZS4NCiAJICovDQotCXR4LmRzdF9tYXhidXJzdCA9IHNwaV9pbXgtPmRldnR5cGVfZGF0
YS0+Zmlmb19zaXplOw0KKwlpZiAoc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT50eF9nbGl0Y2hfZml4
ZWQpDQorCQl0eC5kc3RfbWF4YnVyc3QgPSBzcGlfaW14LT53bWw7DQorCWVsc2UNCisJCXR4LmRz
dF9tYXhidXJzdCA9IHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+Zmlmb19zaXplOw0KIAlyZXQgPSBk
bWFlbmdpbmVfc2xhdmVfY29uZmlnKG1hc3Rlci0+ZG1hX3R4LCAmdHgpOw0KIAlpZiAocmV0KSB7
DQogCQlkZXZfZXJyKHNwaV9pbXgtPmRldiwgIlRYIGRtYSBjb25maWd1cmF0aW9uIGZhaWxlZCB3
aXRoICVkXG4iLCByZXQpOw0KLS0gDQoyLjcuNA0KDQo=

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4B26101
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfEVKAS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:18 -0400
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:62638
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729198AbfEVKAS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSG+op0LGTlu9UVubzot8VhrFW1HWF33r3Ek1gPsJR8=;
 b=TgdJ0/4pLwyw7ha7zltHY6k0V5a5HQkDIg8+vHf74nfH1rxBlvYCeBQeri/rr9dNmxYIJ82Xk3PEG9YA9WwRHMSh9D/I/UuZmc2xobS0wBIwKJd42umVPu03vF4BSDmA2R0BsX2gG92exVI/QHQv3rGeQ1ce8PfRECQJpTeQOck=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3103.eurprd04.prod.outlook.com (10.170.229.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:14 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:14 +0000
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
Subject: [PATCH v4 06/14] spi: imx: fix ERR009165
Thread-Topic: [PATCH v4 06/14] spi: imx: fix ERR009165
Thread-Index: AQHVEIUm1l7pAgZtKU6lENGrbSG0GA==
Date:   Wed, 22 May 2019 10:00:14 +0000
Message-ID: <1558548188-1155-7-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8cbe9eb9-3fb6-46df-79c3-08d6de9c4939
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3103;
x-ms-traffictypediagnostic: VI1PR04MB3103:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB3103C30E578E00EAF944956289000@VI1PR04MB3103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(68736007)(81166006)(2201001)(2501003)(52116002)(71200400001)(14454004)(186003)(256004)(14444005)(26005)(53936002)(7736002)(25786009)(81156014)(305945005)(966005)(8936002)(4326008)(86362001)(8676002)(50226002)(71190400001)(486006)(6512007)(6306002)(5660300002)(6436002)(66946007)(73956011)(498600001)(446003)(66446008)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(99286004)(386003)(6506007)(2906002)(54906003)(76176011)(36756003)(11346002)(110136005)(7416002)(2616005)(6486002)(102836004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3103;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WcaN4mqUg33sjYTkOoZX2ZRsBhWAjS8DVQXE164S+W4vxYfbBric8skRZXnhqvKzrJhbadkukrEU/ATmQtobgddx9dG0gOrxHwi5ZeUqvzVYS9hICwu+XLjuTn9T0YRcI6s/Zlz8IFaKg03tT6XEa5Va0/3eVfZuT51Yy+fLD1WLC0f4VVDZWe4ZsRC4p/Kl7J81aPHQi+JyKWuqXdi3OACCXU4c1DGnzGs8vwgJihgdDbMEvtl6RZd+2LAEFnoT8pYNIa/WoxjC85jKLm2BggTscAIsxm8q9nYzByHgd73kCOiFvSYAFBCL7Ajusw+vzUbSZVxl+jiBCQlEmi7Rq1H/OSNzjY1Oi5oc+8OZtGLu40z4sfuR29RJZwr8kXklmD+Jh2AkAnbKIyAN7qgWLgeYrTQqlQu17v7WuZDb+sQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbe9eb9-3fb6-46df-79c3-08d6de9c4939
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:14.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Q2hhbmdlIHRvIFhDSCAgbW9kZSBldmVuIGluIGRtYSBtb2RlLCBwbGVhc2UgcmVmZXIgdG8gdGhl
IGJlbG93DQplcnJhdGE6DQpodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZE
UUNFLnBkZg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+
DQpBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KLS0tDQogZHJpdmVy
cy9zcGkvc3BpLWlteC5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3BpL3NwaS1pbXguYyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0KaW5kZXggMDljOWExZS4uNjc5
NTkxMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0KKysrIGIvZHJpdmVycy9z
cGkvc3BpLWlteC5jDQpAQCAtNTg1LDggKzU4NSw5IEBAIHN0YXRpYyBpbnQgbXg1MV9lY3NwaV9w
cmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgsDQogCWN0cmwgfD0g
bXg1MV9lY3NwaV9jbGtkaXYoc3BpX2lteCwgdC0+c3BlZWRfaHosICZjbGspOw0KIAlzcGlfaW14
LT5zcGlfYnVzX2NsayA9IGNsazsNCiANCisJLyogRVJSMDA5MTY1OiB3b3JrIGluIFhIQyBtb2Rl
IGFzIFBJTyAqLw0KIAlpZiAoc3BpX2lteC0+dXNlZG1hKQ0KLQkJY3RybCB8PSBNWDUxX0VDU1BJ
X0NUUkxfU01DOw0KKwkJY3RybCAmPSB+TVg1MV9FQ1NQSV9DVFJMX1NNQzsNCiANCiAJd3JpdGVs
KGN0cmwsIHNwaV9pbXgtPmJhc2UgKyBNWDUxX0VDU1BJX0NUUkwpOw0KIA0KQEAgLTYxMiwxMiAr
NjEzLDE0IEBAIHN0YXRpYyBpbnQgbXg1MV9lY3NwaV9wcmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBz
cGlfaW14X2RhdGEgKnNwaV9pbXgsDQogDQogc3RhdGljIHZvaWQgbXg1MV9zZXR1cF93bWwoc3Ry
dWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCkNCiB7DQorCXUzMiB0eF93bWwgPSAwOw0KKw0KIAkv
Kg0KIAkgKiBDb25maWd1cmUgdGhlIERNQSByZWdpc3Rlcjogc2V0dXAgdGhlIHdhdGVybWFyaw0K
IAkgKiBhbmQgZW5hYmxlIERNQSByZXF1ZXN0Lg0KIAkgKi8NCiAJd3JpdGVsKE1YNTFfRUNTUElf
RE1BX1JYX1dNTChzcGlfaW14LT53bWwgLSAxKSB8DQotCQlNWDUxX0VDU1BJX0RNQV9UWF9XTUwo
c3BpX2lteC0+d21sKSB8DQorCQlNWDUxX0VDU1BJX0RNQV9UWF9XTUwodHhfd21sKSB8DQogCQlN
WDUxX0VDU1BJX0RNQV9SWFRfV01MKHNwaV9pbXgtPndtbCkgfA0KIAkJTVg1MV9FQ1NQSV9ETUFf
VEVERU4gfCBNWDUxX0VDU1BJX0RNQV9SWERFTiB8DQogCQlNWDUxX0VDU1BJX0RNQV9SWFRERU4s
IHNwaV9pbXgtPmJhc2UgKyBNWDUxX0VDU1BJX0RNQSk7DQpAQCAtMTE3MSw3ICsxMTc0LDExIEBA
IHN0YXRpYyBpbnQgc3BpX2lteF9kbWFfY29uZmlndXJlKHN0cnVjdCBzcGlfbWFzdGVyICptYXN0
ZXIpDQogCXR4LmRpcmVjdGlvbiA9IERNQV9NRU1fVE9fREVWOw0KIAl0eC5kc3RfYWRkciA9IHNw
aV9pbXgtPmJhc2VfcGh5cyArIE1YQ19DU1BJVFhEQVRBOw0KIAl0eC5kc3RfYWRkcl93aWR0aCA9
IGJ1c3dpZHRoOw0KLQl0eC5kc3RfbWF4YnVyc3QgPSBzcGlfaW14LT53bWw7DQorCS8qDQorCSAq
IEZvciBFUlIwMDkxNjUgd2l0aCB0eF93bWwgPSAwIGNvdWxkIGVubGFyZ2UgYnVyc3Qgc2l6ZSB0
byBmaWZvIHNpemUNCisJICogdG8gc3BlZWQgdXAgZmlmbyBmaWxsaW5nIGFzIHBvc3NpYmxlLg0K
KwkgKi8NCisJdHguZHN0X21heGJ1cnN0ID0gc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT5maWZvX3Np
emU7DQogCXJldCA9IGRtYWVuZ2luZV9zbGF2ZV9jb25maWcobWFzdGVyLT5kbWFfdHgsICZ0eCk7
DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoc3BpX2lteC0+ZGV2LCAiVFggZG1hIGNvbmZpZ3Vy
YXRpb24gZmFpbGVkIHdpdGggJWRcbiIsIHJldCk7DQpAQCAtMTI2NSwxMCArMTI3Miw2IEBAIHN0
YXRpYyBpbnQgc3BpX2lteF9zZG1hX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc3Bp
X2lteF9kYXRhICpzcGlfaW14LA0KIHsNCiAJaW50IHJldDsNCiANCi0JLyogdXNlIHBpbyBtb2Rl
IGZvciBpLm14NmRsIGNoaXAgVEtUMjM4Mjg1ICovDQotCWlmIChvZl9tYWNoaW5lX2lzX2NvbXBh
dGlibGUoImZzbCxpbXg2ZGwiKSkNCi0JCXJldHVybiAwOw0KLQ0KIAlzcGlfaW14LT53bWwgPSBz
cGlfaW14LT5kZXZ0eXBlX2RhdGEtPmZpZm9fc2l6ZSAvIDI7DQogDQogCS8qIFByZXBhcmUgZm9y
IFRYIERNQTogKi8NCi0tIA0KMi43LjQNCg0K

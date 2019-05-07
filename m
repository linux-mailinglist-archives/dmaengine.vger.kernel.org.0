Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9916089
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEGJRC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:17:02 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:26283
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbfEGJQ6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IamOlvDHns+7MfjYUIuX2YgxLTawBqxGa/cJwrUa3GY=;
 b=tPXxquIyRPALfYWNQLhKessoj3mVH/u48e6PjO7Rza3Qc8kAp4VrucBwyTl6g8kE/Usq3ncHu5+MdEUw8wUIcKX9xhvJSS0S0Q1Ow+fvydFp/1b+Bek77ZhPS9eaegrm23ouYwq7qVmcMKRgiVpTLP9RXYqNRlhRA9LQMzmTi4M=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:16:19 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:19 +0000
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
Subject: [PATCH v3 07/14] spi: imx: remove ERR009165 workaround on i.mx6ul
Thread-Topic: [PATCH v3 07/14] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Thread-Index: AQHVBLWHv8D1fmdXnUup12XR6m92OQ==
Date:   Tue, 7 May 2019 09:16:19 +0000
Message-ID: <1557249513-4903-8-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: e7c47d71-d979-432f-bb96-08d6d2ccaa39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5005;
x-ms-traffictypediagnostic: VI1PR04MB5005:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB5005F611FF22B75B63129AD489310@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(386003)(6506007)(2501003)(36756003)(102836004)(6486002)(26005)(8676002)(4326008)(5660300002)(25786009)(68736007)(52116002)(76176011)(186003)(2201001)(6306002)(6512007)(53936002)(3846002)(71200400001)(14444005)(66556008)(966005)(86362001)(66446008)(64756008)(476003)(66476007)(7416002)(305945005)(2906002)(11346002)(7736002)(66066001)(6116002)(99286004)(54906003)(256004)(14454004)(2616005)(73956011)(110136005)(6436002)(50226002)(8936002)(81156014)(81166006)(66946007)(316002)(71190400001)(486006)(478600001)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vvMUG04wk06FVIBEu4WSrW27VxCZcpS9rYX/BpOyLQFHDMx28k5TY1yVOEZIap56L6S5FDVILNeP4XjmHC7URXS0Yo2EJFr80HEYMFRa66Wyu/XC/Eb83MFUg8gxdUM+2AhGgtwMrJYcncYdKpGyBZN0R4mtqI4Y+PL5ebXAAC8cU5F4ff718DXoUlTSuQk2/kVpOxuGy9lS1jU3KUSZ2m/5fy/BAElc36bPUOT1S6FnvrgCnDj6izLyliah8ubnj5wjQJrTBt0iZmaQMDgA+LaBTl4fT1fWnxCG0wpdzbyXPUyDiUj/8uzFq20sc5JsiBL50q+ADcH9LNfrHG97cgbN54Nxv+WaKxB4jxdIojNl6BDX29JOMa4FK801OFhhYRPO5WtIynQNT6v5WTJjEhVO2TyjaEbEQfpjSvkkGtg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c47d71-d979-432f-bb96-08d6d2ccaa39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:19.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RVJSMDA5MTY1IGZpeGVkIG9uIGkubXg2dWwvNnVsbC82c2xsLiBBbGwgb3RoZXIgaS5teDYvNyBh
bmQNCmkubXg4bS84bW0gc3RpbGwgbmVlZCB0aGlzIGVycmF0YS4gUGxlYXNlIHJlZmVyIHRvIG54
cCBvZmZpY2lhbA0KZXJyYXRhIGRvY3VtZW50IGZyb20gaHR0cHM6Ly93d3cubnhwLmNvbS8gLg0K
DQpGb3IgcmVtb3Zpbmcgd29ya2Fyb3VuZCBvbiB0aG9zZSBjaGlwcy4gQWRkIG5ldyBpLm14NnVs
IHR5cGUuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvc3BpL3NwaS1pbXguYyB8IDUwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktaW14
LmMgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCmluZGV4IDY3OTU5MTAuLjkxNjYwZGMgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3NwaS9zcGktaW14LmMNCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1pbXgu
Yw0KQEAgLTU3LDYgKzU3LDcgQEAgZW51bSBzcGlfaW14X2RldnR5cGUgew0KIAlJTVgzNV9DU1BJ
LAkvKiBDU1BJIG9uIGFsbCBpLm14IGV4Y2VwdCBhYm92ZSAqLw0KIAlJTVg1MV9FQ1NQSSwJLyog
RUNTUEkgb24gaS5teDUxICovDQogCUlNWDUzX0VDU1BJLAkvKiBFQ1NQSSBvbiBpLm14NTMgYW5k
IGxhdGVyICovDQorCUlNWDZVTF9FQ1NQSSwJLyogRVJSMDA5MTY1IGZpeCBmcm9tIGkubXg2dWwg
Ki8NCiB9Ow0KIA0KIHN0cnVjdCBzcGlfaW14X2RhdGE7DQpAQCAtNzUsNiArNzYsMTEgQEAgc3Ry
dWN0IHNwaV9pbXhfZGV2dHlwZV9kYXRhIHsNCiAJYm9vbCBoYXNfc2xhdmVtb2RlOw0KIAl1bnNp
Z25lZCBpbnQgZmlmb19zaXplOw0KIAlib29sIGR5bmFtaWNfYnVyc3Q7DQorCS8qDQorCSAqIEVS
UjAwOTE2NSBmaXhlZCBvciBub3Q6DQorCSAqIGh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9l
cnJhdGEvSU1YNkRRQ0UucGRmDQorCSAqLw0KKwlib29sIHR4X2dsaXRjaF9maXhlZDsNCiAJZW51
bSBzcGlfaW14X2RldnR5cGUgZGV2dHlwZTsNCiB9Ow0KIA0KQEAgLTEyOCw3ICsxMzQsOCBAQCBz
dGF0aWMgaW5saW5lIGludCBpc19pbXgzNV9jc3BpKHN0cnVjdCBzcGlfaW14X2RhdGEgKmQpDQog
DQogc3RhdGljIGlubGluZSBpbnQgaXNfaW14NTFfZWNzcGkoc3RydWN0IHNwaV9pbXhfZGF0YSAq
ZCkNCiB7DQotCXJldHVybiBkLT5kZXZ0eXBlX2RhdGEtPmRldnR5cGUgPT0gSU1YNTFfRUNTUEk7
DQorCXJldHVybiBkLT5kZXZ0eXBlX2RhdGEtPmRldnR5cGUgPT0gSU1YNTFfRUNTUEkgfHwNCisJ
ICAgICAgIGQtPmRldnR5cGVfZGF0YS0+ZGV2dHlwZSA9PSBJTVg2VUxfRUNTUEk7DQogfQ0KIA0K
IHN0YXRpYyBpbmxpbmUgaW50IGlzX2lteDUzX2Vjc3BpKHN0cnVjdCBzcGlfaW14X2RhdGEgKmQp
DQpAQCAtNTg1LDkgKzU5MiwxNiBAQCBzdGF0aWMgaW50IG14NTFfZWNzcGlfcHJlcGFyZV90cmFu
c2ZlcihzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14LA0KIAljdHJsIHw9IG14NTFfZWNzcGlf
Y2xrZGl2KHNwaV9pbXgsIHQtPnNwZWVkX2h6LCAmY2xrKTsNCiAJc3BpX2lteC0+c3BpX2J1c19j
bGsgPSBjbGs7DQogDQotCS8qIEVSUjAwOTE2NTogd29yayBpbiBYSEMgbW9kZSBhcyBQSU8gKi8N
Ci0JaWYgKHNwaV9pbXgtPnVzZWRtYSkNCi0JCWN0cmwgJj0gfk1YNTFfRUNTUElfQ1RSTF9TTUM7
DQorCS8qDQorCSAqIEVSUjAwOTE2NTogd29yayBpbiBYSEMgbW9kZSBpbnN0ZWFkIG9mIFNNQyBh
cyBQSU8gb24gdGhlIGNoaXBzDQorCSAqIGJlZm9yZSBpLm14NnVsLg0KKwkgKi8NCisJaWYgKHNw
aV9pbXgtPnVzZWRtYSkgew0KKwkJaWYgKHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+dHhfZ2xpdGNo
X2ZpeGVkKQ0KKwkJCWN0cmwgfD0gTVg1MV9FQ1NQSV9DVFJMX1NNQzsNCisJCWVsc2UNCisJCQlj
dHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01DOw0KKwl9DQogDQogCXdyaXRlbChjdHJsLCBzcGlf
aW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsNCiANCkBAIC02MTUsNiArNjI5LDggQEAgc3Rh
dGljIHZvaWQgbXg1MV9zZXR1cF93bWwoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCkNCiB7
DQogCXUzMiB0eF93bWwgPSAwOw0KIA0KKwlpZiAoc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT50eF9n
bGl0Y2hfZml4ZWQpDQorCQl0eF93bWwgPSBzcGlfaW14LT53bWw7DQogCS8qDQogCSAqIENvbmZp
Z3VyZSB0aGUgRE1BIHJlZ2lzdGVyOiBzZXR1cCB0aGUgd2F0ZXJtYXJrDQogCSAqIGFuZCBlbmFi
bGUgRE1BIHJlcXVlc3QuDQpAQCAtMTAxMiw2ICsxMDI4LDIzIEBAIHN0YXRpYyBzdHJ1Y3Qgc3Bp
X2lteF9kZXZ0eXBlX2RhdGEgaW14NTNfZWNzcGlfZGV2dHlwZV9kYXRhID0gew0KIAkuZGV2dHlw
ZSA9IElNWDUzX0VDU1BJLA0KIH07DQogDQorc3RhdGljIHN0cnVjdCBzcGlfaW14X2RldnR5cGVf
ZGF0YSBpbXg2dWxfZWNzcGlfZGV2dHlwZV9kYXRhID0gew0KKwkuaW50Y3RybCA9IG14NTFfZWNz
cGlfaW50Y3RybCwNCisJLnByZXBhcmVfbWVzc2FnZSA9IG14NTFfZWNzcGlfcHJlcGFyZV9tZXNz
YWdlLA0KKwkucHJlcGFyZV90cmFuc2ZlciA9IG14NTFfZWNzcGlfcHJlcGFyZV90cmFuc2ZlciwN
CisJLnRyaWdnZXIgPSBteDUxX2Vjc3BpX3RyaWdnZXIsDQorCS5yeF9hdmFpbGFibGUgPSBteDUx
X2Vjc3BpX3J4X2F2YWlsYWJsZSwNCisJLnJlc2V0ID0gbXg1MV9lY3NwaV9yZXNldCwNCisJLnNl
dHVwX3dtbCA9IG14NTFfc2V0dXBfd21sLA0KKwkuZmlmb19zaXplID0gNjQsDQorCS5oYXNfZG1h
bW9kZSA9IHRydWUsDQorCS5keW5hbWljX2J1cnN0ID0gdHJ1ZSwNCisJLmhhc19zbGF2ZW1vZGUg
PSB0cnVlLA0KKwkudHhfZ2xpdGNoX2ZpeGVkID0gdHJ1ZSwNCisJLmRpc2FibGUgPSBteDUxX2Vj
c3BpX2Rpc2FibGUsDQorCS5kZXZ0eXBlID0gSU1YNlVMX0VDU1BJLA0KK307DQorDQogc3RhdGlj
IGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgc3BpX2lteF9kZXZ0eXBlW10gPSB7DQog
CXsNCiAJCS5uYW1lID0gImlteDEtY3NwaSIsDQpAQCAtMTAzNSw2ICsxMDY4LDkgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgc3BpX2lteF9kZXZ0eXBlW10gPSB7DQog
CQkubmFtZSA9ICJpbXg1My1lY3NwaSIsDQogCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25n
X3QpICZpbXg1M19lY3NwaV9kZXZ0eXBlX2RhdGEsDQogCX0sIHsNCisJCS5uYW1lID0gImlteDZ1
bC1lY3NwaSIsDQorCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZpbXg2dWxfZWNz
cGlfZGV2dHlwZV9kYXRhLA0KKwl9LCB7DQogCQkvKiBzZW50aW5lbCAqLw0KIAl9DQogfTsNCkBA
IC0xMDQ3LDYgKzEwODMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzcGlf
aW14X2R0X2lkc1tdID0gew0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgzNS1jc3BpIiwgLmRh
dGEgPSAmaW14MzVfY3NwaV9kZXZ0eXBlX2RhdGEsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNs
LGlteDUxLWVjc3BpIiwgLmRhdGEgPSAmaW14NTFfZWNzcGlfZGV2dHlwZV9kYXRhLCB9LA0KIAl7
IC5jb21wYXRpYmxlID0gImZzbCxpbXg1My1lY3NwaSIsIC5kYXRhID0gJmlteDUzX2Vjc3BpX2Rl
dnR5cGVfZGF0YSwgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnVsLWVjc3BpIiwgLmRh
dGEgPSAmaW14NnVsX2Vjc3BpX2RldnR5cGVfZGF0YSwgfSwNCiAJeyAvKiBzZW50aW5lbCAqLyB9
DQogfTsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBzcGlfaW14X2R0X2lkcyk7DQpAQCAtMTE3
OCw3ICsxMjE1LDEwIEBAIHN0YXRpYyBpbnQgc3BpX2lteF9kbWFfY29uZmlndXJlKHN0cnVjdCBz
cGlfbWFzdGVyICptYXN0ZXIpDQogCSAqIEZvciBFUlIwMDkxNjUgd2l0aCB0eF93bWwgPSAwIGNv
dWxkIGVubGFyZ2UgYnVyc3Qgc2l6ZSB0byBmaWZvIHNpemUNCiAJICogdG8gc3BlZWQgdXAgZmlm
byBmaWxsaW5nIGFzIHBvc3NpYmxlLg0KIAkgKi8NCi0JdHguZHN0X21heGJ1cnN0ID0gc3BpX2lt
eC0+ZGV2dHlwZV9kYXRhLT5maWZvX3NpemU7DQorCWlmIChzcGlfaW14LT5kZXZ0eXBlX2RhdGEt
PnR4X2dsaXRjaF9maXhlZCkNCisJCXR4LmRzdF9tYXhidXJzdCA9IHNwaV9pbXgtPndtbDsNCisJ
ZWxzZQ0KKwkJdHguZHN0X21heGJ1cnN0ID0gc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT5maWZvX3Np
emU7DQogCXJldCA9IGRtYWVuZ2luZV9zbGF2ZV9jb25maWcobWFzdGVyLT5kbWFfdHgsICZ0eCk7
DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoc3BpX2lteC0+ZGV2LCAiVFggZG1hIGNvbmZpZ3Vy
YXRpb24gZmFpbGVkIHdpdGggJWRcbiIsIHJldCk7DQotLSANCjIuNy40DQoNCg==

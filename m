Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65619B2A
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 12:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfEJKO2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 06:14:28 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:33870
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727424AbfEJKO1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 06:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlxABmR932Qf54QdwDfiqRNhb3nbcrkNOm91cZmjgqw=;
 b=OBPzzYnFt017BNpXZFvtrMRTVhZoZc1T46K8+DzcpT/tbUESG2ZXFkCGpFuO5Xkxl7q/y9+SXQb4L0w51kNm1FsFjGzmB1PU/clx/I7gjYFWv9YF8H3gBFKibyXCjyQ4zzWZ161RVIzP6ixd0HDhZ0cUaTPsA5yPqL2QJ9wW4B8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5661.eurprd04.prod.outlook.com (20.178.126.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 10:14:22 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:14:22 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 4/6] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Topic: [PATCH v1 4/6] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Index: AQHVBxkiWq7ELKRpKk+QnDmvsVTzcg==
Date:   Fri, 10 May 2019 10:14:21 +0000
Message-ID: <1557512248-8440-5-git-send-email-yibin.gong@nxp.com>
References: <1557512248-8440-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1557512248-8440-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f250188-3f72-4f53-b16e-08d6d5304530
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5661;
x-ms-traffictypediagnostic: VI1PR04MB5661:
x-microsoft-antispam-prvs: <VI1PR04MB566152B4B44C7C7826057869890C0@VI1PR04MB5661.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(4326008)(86362001)(66066001)(110136005)(316002)(14454004)(25786009)(14444005)(256004)(6116002)(3846002)(71190400001)(7416002)(71200400001)(2201001)(7736002)(305945005)(2906002)(386003)(6506007)(5660300002)(6512007)(6486002)(50226002)(446003)(476003)(8936002)(478600001)(52116002)(186003)(102836004)(76176011)(99286004)(54906003)(11346002)(68736007)(6436002)(26005)(486006)(2616005)(66556008)(66476007)(66446008)(66946007)(64756008)(53936002)(8676002)(81156014)(73956011)(81166006)(36756003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5661;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LVD7F3sPurO2xjPFfZPVM9x3ybHG8NEwfey8shPPiNPHvpw/Hxg8U1JTYNwQCDPGTFX+yggyMQsAbbnkxBkWY7Ax+LuiN0LM+7H35xnUEIqUKoi8gb/OtoIrNa0lX/1K6S0D9PGQLeEsHftdKf6/3gLNIGM6Ixq0FXB2vE5nrcUdypyVAvA8HwDceRXlVXeRnFNtKs7n05iQoGl03xIX9qFF9o/H3DZ2jOGuzay7K1Pz0t29V72e2PKGl//hz+iqZmXMIvp4a2m9pz7NGMCfFpSChhS3BDAGSg+SMuUjesSQmieSU5ypc+3suGOyWn4UNp44I3SIfvRukBvT1Q5RUHaGzkdoj67b89H7ef00+jStiOoytm1YWhu29kTeBGDiRzDAAtvzlmvA6sBIEnl/o36vyYz1I62+gEju+p7joZc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f250188-3f72-4f53-b16e-08d6d5304530
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:14:21.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5661
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ICBBZGQgZWRtYTIgZm9yIGkubXg3dWxwIGJ5IHZlcnNpb24gdjMsIHNpbmNlIHYyIGhhcyBhbHJl
YWR5DQpiZWVuIHVzZWQgYnkgbWNmLWVkbWEuDQpUaGUgYmlnIGNoYW5nZXMgYmFzZWQgb24gdjEg
YXJlIGJlbG93czoNCiAgMS4gb25seSBvbmUgZG1hbXV4Lg0KICAyLiBhbm90aGVyIGNsb2NrIGRt
YV9jbGsgZXhjZXB0IGRtYW11eCBjbGsuDQogIDMuIDE2IGluZGVwZW5kZW50IGludGVycnVwdHMg
aW5zdGVhZCBvZiBvbmx5IG9uZSBpbnRlcnJ1cHQgZm9yDQphbGwgY2hhbm5lbHMuDQoNClNpZ25l
ZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
ZG1hL2ZzbC1lZG1hLWNvbW1vbi5jIHwgMTggKysrKysrKysrKy0NCiBkcml2ZXJzL2RtYS9mc2wt
ZWRtYS1jb21tb24uaCB8ICAzICsrDQogZHJpdmVycy9kbWEvZnNsLWVkbWEuYyAgICAgICAgfCA2
OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogMyBmaWxlcyBj
aGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmMgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21t
b24uYw0KaW5kZXggYmIyNDI1MS4uNjRlODIyZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL2Zz
bC1lZG1hLWNvbW1vbi5jDQorKysgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYw0KQEAg
LTkwLDYgKzkwLDE5IEBAIHN0YXRpYyB2b2lkIG11eF9jb25maWd1cmU4KHN0cnVjdCBmc2xfZWRt
YV9jaGFuICpmc2xfY2hhbiwgdm9pZCBfX2lvbWVtICphZGRyLA0KIAlpb3dyaXRlOCh2YWw4LCBh
ZGRyICsgb2ZmKTsNCiB9DQogDQordm9pZCBtdXhfY29uZmlndXJlMzIoc3RydWN0IGZzbF9lZG1h
X2NoYW4gKmZzbF9jaGFuLCB2b2lkIF9faW9tZW0gKmFkZHIsDQorCQkgICAgIHUzMiBvZmYsIHUz
MiBzbG90LCBib29sIGVuYWJsZSkNCit7DQorCXUzMiB2YWw7DQorDQorCWlmIChlbmFibGUpDQor
CQl2YWwgPSBFRE1BTVVYX0NIQ0ZHX0VOQkwgPDwgMjQgfCBzbG90Ow0KKwllbHNlDQorCQl2YWwg
PSBFRE1BTVVYX0NIQ0ZHX0RJUzsNCisNCisJaW93cml0ZTMyKHZhbCwgYWRkciArIG9mZiAqIDQp
Ow0KK30NCisNCiB2b2lkIGZzbF9lZG1hX2NoYW5fbXV4KHN0cnVjdCBmc2xfZWRtYV9jaGFuICpm
c2xfY2hhbiwNCiAJCQl1bnNpZ25lZCBpbnQgc2xvdCwgYm9vbCBlbmFibGUpDQogew0KQEAgLTEw
Miw3ICsxMTUsMTAgQEAgdm9pZCBmc2xfZWRtYV9jaGFuX211eChzdHJ1Y3QgZnNsX2VkbWFfY2hh
biAqZnNsX2NoYW4sDQogCW11eGFkZHIgPSBmc2xfY2hhbi0+ZWRtYS0+bXV4YmFzZVtjaCAvIGNo
YW5zX3Blcl9tdXhdOw0KIAlzbG90ID0gRURNQU1VWF9DSENGR19TT1VSQ0Uoc2xvdCk7DQogDQot
CW11eF9jb25maWd1cmU4KGZzbF9jaGFuLCBtdXhhZGRyLCBjaF9vZmYsIHNsb3QsIGVuYWJsZSk7
DQorCWlmIChmc2xfY2hhbi0+ZWRtYS0+dmVyc2lvbiA9PSB2MykNCisJCW11eF9jb25maWd1cmUz
Mihmc2xfY2hhbiwgbXV4YWRkciwgY2hfb2ZmLCBzbG90LCBlbmFibGUpOw0KKwllbHNlDQorCQlt
dXhfY29uZmlndXJlOChmc2xfY2hhbiwgbXV4YWRkciwgY2hfb2ZmLCBzbG90LCBlbmFibGUpOw0K
IH0NCiBFWFBPUlRfU1lNQk9MX0dQTChmc2xfZWRtYV9jaGFuX211eCk7DQogDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmggYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1j
b21tb24uaA0KaW5kZXggMjFhOWNmZC4uMmIwY2M4ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1h
L2ZzbC1lZG1hLWNvbW1vbi5oDQorKysgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uaA0K
QEAgLTEyNCw2ICsxMjQsNyBAQCBzdHJ1Y3QgZnNsX2VkbWFfY2hhbiB7DQogCWRtYV9hZGRyX3QJ
CQlkbWFfZGV2X2FkZHI7DQogCXUzMgkJCQlkbWFfZGV2X3NpemU7DQogCWVudW0gZG1hX2RhdGFf
ZGlyZWN0aW9uCQlkbWFfZGlyOw0KKwljaGFyCQkJCWNoYW5fbmFtZVsxNl07DQogfTsNCiANCiBz
dHJ1Y3QgZnNsX2VkbWFfZGVzYyB7DQpAQCAtMTM4LDYgKzEzOSw3IEBAIHN0cnVjdCBmc2xfZWRt
YV9kZXNjIHsNCiBlbnVtIGVkbWFfdmVyc2lvbiB7DQogCXYxLCAvKiAzMmNoLCBWeWJyaWQsIG1w
YzU3eCwgZXRjICovDQogCXYyLCAvKiA2NGNoIENvbGRmaXJlICovDQorCXYzLCAvKiAzMmNoLCBp
Lm14N3VscCAqLw0KIH07DQogDQogc3RydWN0IGZzbF9lZG1hX2VuZ2luZSB7DQpAQCAtMTQ1LDYg
KzE0Nyw3IEBAIHN0cnVjdCBmc2xfZWRtYV9lbmdpbmUgew0KIAl2b2lkIF9faW9tZW0JCSptZW1i
YXNlOw0KIAl2b2lkIF9faW9tZW0JCSptdXhiYXNlW0RNQU1VWF9OUl07DQogCXN0cnVjdCBjbGsJ
CSptdXhjbGtbRE1BTVVYX05SXTsNCisJc3RydWN0IGNsawkJKmRtYWNsazsNCiAJdTMyCQkJZG1h
bXV4X25yOw0KIAlzdHJ1Y3QgbXV0ZXgJCWZzbF9lZG1hX211dGV4Ow0KIAl1MzIJCQluX2NoYW5z
Ow0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLmMgYi9kcml2ZXJzL2RtYS9mc2wt
ZWRtYS5jDQppbmRleCA3YjY1ZWY0Li4xNTY4MDcwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kbWEv
ZnNsLWVkbWEuYw0KKysrIGIvZHJpdmVycy9kbWEvZnNsLWVkbWEuYw0KQEAgLTE2NSw2ICsxNjUs
NTEgQEAgZnNsX2VkbWFfaXJxX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3Ry
dWN0IGZzbF9lZG1hX2VuZ2luZSAqZnNsX2VkbWENCiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRp
YyBpbnQNCitmc2xfZWRtYTJfaXJxX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwN
CisJCSAgIHN0cnVjdCBmc2xfZWRtYV9lbmdpbmUgKmZzbF9lZG1hKQ0KK3sNCisJc3RydWN0IGRl
dmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KKwlpbnQgaSwgcmV0LCBpcnE7DQor
CWludCBjb3VudCA9IDA7DQorDQorCWNvdW50ID0gb2ZfaXJxX2NvdW50KG5wKTsNCisJZGV2X2lu
Zm8oJnBkZXYtPmRldiwgIiVzIEZvdW5kICVkIGludGVycnVwdHNcclxuIiwgX19mdW5jX18sIGNv
dW50KTsNCisJaWYgKGNvdW50IDw9IDIpIHsNCisJCWRldl9lcnIoJnBkZXYtPmRldiwgIkludGVy
cnVwdHMgaW4gRFRTIG5vdCBjb3JyZWN0LlxuIik7DQorCQlyZXR1cm4gLUVJTlZBTDsNCisJfQ0K
KwkvKg0KKwkgKiAxNiBjaGFubmVsIGluZGVwZW5kZW50IGludGVycnVwdHMgKyAxIGVycm9yIGlu
dGVycnVwdCBvbiBpLm14N3VscC4NCisJICogMiBjaGFubmVsIHNoYXJlIG9uZSBpbnRlcnJ1cHQs
IGZvciBleGFtcGxlLCBjaDAvY2gxNiwgY2gxL2NoMTcuLi4NCisJICogRm9yIG5vdywganVzdCBz
aW1wbHkgcmVxdWVzdCBpcnEgd2l0aG91dCBJUlFGX1NIQVJFRCBmbGFnLCBzaW5jZSAxNg0KKwkg
KiBjaGFubmVscyBhcmUgZW5vdWdoIG9uIGkubXg3dWxwIHdob3NlIE00IGRvbWFpbiBvd24gc29t
ZSBwZXJpcGhlcmFscy4NCisJICovDQorCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQor
CQlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIGkpOw0KKwkJaWYgKGlycSA8IDApDQorCQkJ
cmV0dXJuIC1FTlhJTzsNCisNCisJCXNwcmludGYoZnNsX2VkbWEtPmNoYW5zW2ldLmNoYW5fbmFt
ZSwgImVETUEyLUNIJTAyZCIsIGkpOw0KKw0KKwkJLyogVGhlIGxhc3QgSVJRIGlzIGZvciBlRE1B
IGVyciAqLw0KKwkJaWYgKGkgPT0gY291bnQgLSAxKQ0KKwkJCXJldCA9IGRldm1fcmVxdWVzdF9p
cnEoJnBkZXYtPmRldiwgaXJxLA0KKwkJCQkJCWZzbF9lZG1hX2Vycl9oYW5kbGVyLA0KKwkJCQkJ
CTAsICJlRE1BMi1FUlIiLCBmc2xfZWRtYSk7DQorCQllbHNlDQorDQorCQkJcmV0ID0gZGV2bV9y
ZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnEsDQorCQkJCQkJZnNsX2VkbWFfdHhfaGFuZGxlciwg
MCwNCisJCQkJCQlmc2xfZWRtYS0+Y2hhbnNbaV0uY2hhbl9uYW1lLA0KKwkJCQkJCWZzbF9lZG1h
KTsNCisJCWlmIChyZXQpDQorCQkJcmV0dXJuIHJldDsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9
DQorDQogc3RhdGljIHZvaWQgZnNsX2VkbWFfaXJxX2V4aXQoDQogCQlzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LCBzdHJ1Y3QgZnNsX2VkbWFfZW5naW5lICpmc2xfZWRtYSkNCiB7DQpAQCAt
MjE4LDYgKzI2MywyMyBAQCBzdGF0aWMgaW50IGZzbF9lZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQogCWZzbF9lZG1hX3NldHVwX3JlZ3MoZnNsX2VkbWEpOw0KIAlyZWdz
ID0gJmZzbF9lZG1hLT5yZWdzOw0KIA0KKwlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAs
ICJmc2wsaW14N3VscC1lZG1hIikpIHsNCisJCWZzbF9lZG1hLT5kbWFtdXhfbnIgPSAxOw0KKwkJ
ZnNsX2VkbWEtPnZlcnNpb24gPSB2MzsNCisNCisJCWZzbF9lZG1hLT5kbWFjbGsgPSBkZXZtX2Ns
a19nZXQoJnBkZXYtPmRldiwgImRtYSIpOw0KKwkJaWYgKElTX0VSUihmc2xfZWRtYS0+ZG1hY2xr
KSkgew0KKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgIk1pc3NpbmcgRE1BIGJsb2NrIGNsb2NrLlxu
Iik7DQorCQkJcmV0dXJuIFBUUl9FUlIoZnNsX2VkbWEtPmRtYWNsayk7DQorCQl9DQorDQorCQly
ZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZnNsX2VkbWEtPmRtYWNsayk7DQorCQlpZiAocmV0KSB7
DQorCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiRE1BIGNsayBibG9jayBmYWlsZWQuXG4iKTsNCisJ
CQlyZXR1cm4gcmV0Ow0KKwkJfQ0KKwl9DQorDQogCWZvciAoaSA9IDA7IGkgPCBmc2xfZWRtYS0+
ZG1hbXV4X25yOyBpKyspIHsNCiAJCWNoYXIgY2xrbmFtZVszMl07DQogDQpAQCAtMjY0LDcgKzMy
NiwxMSBAQCBzdGF0aWMgaW50IGZzbF9lZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogCX0NCiANCiAJZWRtYV93cml0ZWwoZnNsX2VkbWEsIH4wLCByZWdzLT5pbnRsKTsN
Ci0JcmV0ID0gZnNsX2VkbWFfaXJxX2luaXQocGRldiwgZnNsX2VkbWEpOw0KKw0KKwlpZiAoZnNs
X2VkbWEtPnZlcnNpb24gPT0gdjMpDQorCQlyZXQgPSBmc2xfZWRtYTJfaXJxX2luaXQocGRldiwg
ZnNsX2VkbWEpOw0KKwllbHNlDQorCQlyZXQgPSBmc2xfZWRtYV9pcnFfaW5pdChwZGV2LCBmc2xf
ZWRtYSk7DQogCWlmIChyZXQpDQogCQlyZXR1cm4gcmV0Ow0KIA0KQEAgLTM4NSw2ICs0NTEsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZnNsX2VkbWFfcG1fb3BzID0gew0KIA0K
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGZzbF9lZG1hX2R0X2lkc1tdID0gew0K
IAl7IC5jb21wYXRpYmxlID0gImZzbCx2ZjYxMC1lZG1hIiwgfSwNCisJeyAuY29tcGF0aWJsZSA9
ICJmc2wsaW14N3VscC1lZG1hIiwgfSwNCiAJeyAvKiBzZW50aW5lbCAqLyB9DQogfTsNCiBNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBmc2xfZWRtYV9kdF9pZHMpOw0KLS0gDQoyLjcuNA0KDQo=

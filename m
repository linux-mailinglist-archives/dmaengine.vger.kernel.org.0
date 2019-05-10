Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1D19B1D
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 12:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfEJKOM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 06:14:12 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:5890
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbfEJKOM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 06:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GUngS2hc2MDcjwsXSY7apOViN88QRoNo13FDkhjFwc=;
 b=dbiRoDRo4nsbNnUMwPUfzA05CCQIEDM1FVTs37n0sYveaVSZjjLNiR/8I8QynW4tiXtADnaW8fQdjId/VHDPJ0JO8rv1ENJSfGaTiXlQiL92obkcP6RI0qT54z71Zs6SFpH6VChJCWInNaXi8t2s8RpyszLb6kCYMQvp+/emxgQ=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3007.eurprd04.prod.outlook.com (10.170.228.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 10 May 2019 10:14:08 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 10:14:08 +0000
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
Subject: [PATCH v1 1/6] dmaengine: fsl-edma: add dmamux_nr for next version
Thread-Topic: [PATCH v1 1/6] dmaengine: fsl-edma: add dmamux_nr for next
 version
Thread-Index: AQHVBxka2g2zuT0EHUW4nsjDLiNmZw==
Date:   Fri, 10 May 2019 10:14:08 +0000
Message-ID: <1557512248-8440-2-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 88802fee-e01f-40ef-39f8-08d6d5303d2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3007;
x-ms-traffictypediagnostic: VI1PR04MB3007:
x-microsoft-antispam-prvs: <VI1PR04MB3007746342C2DAB05F3CB4AD890C0@VI1PR04MB3007.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(189003)(14454004)(2201001)(110136005)(54906003)(478600001)(2501003)(8936002)(8676002)(81166006)(81156014)(50226002)(316002)(86362001)(66066001)(25786009)(7416002)(53936002)(4326008)(36756003)(7736002)(71200400001)(2616005)(71190400001)(446003)(11346002)(66946007)(256004)(486006)(2906002)(186003)(26005)(102836004)(476003)(5660300002)(3846002)(6486002)(6116002)(76176011)(52116002)(6506007)(386003)(68736007)(305945005)(66476007)(66556008)(64756008)(66446008)(73956011)(99286004)(6436002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3007;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cEYtqknFcTg6iv/EyGTuNRIn3i3/tYkJ5JEjO974ySgChUqPmeItcx+Qk5efdEXKWh84Hfg88lnSnJK1dyHuyUFNQhO7T8fMpMrrPMnPEIpupOCF+7ctUkHpfbV73Y2scuuI4YGk3XZbH2geQx3qHUDhgYreiovTkUbcWAevD56tC8EH5HP/+MqBNoutv+goJ+f3+OxNKoKafA7ClcFJR5YVjCgm4rCt4sYpkzf2mlhAKeuHAzVRat85cmFgpOaVMrALYcePaQJCaP49kXuw07BrsvidWnRBpkMQMlUUrCsqbNz4HIZdkAcCWnCHEuhQPkF4jXdB8yS61QcLbT5ifH/xhk7vCoDtDnBRXAUCNZQMEOGZ9zNf9g6Ztv4TlKxkQhWs8VAvkCr1BDB6kowRftQsHQbHg9yYt8oCwp+IqFk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88802fee-e01f-40ef-39f8-08d6d5303d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 10:14:08.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3007
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

TmV4dCB2ZXJzaW9uIG9mIGVkbWEgc3VjaCBhcyBlZG1hdjIgb24gaS5teDd1bHAgaGFzIG9ubHkg
b25lIGRtYW11eC4NCkFkZCBkbWFtdXhfbnIgaW5zdGVhZCBvZiBzdGF0aWMgbWFjcm8gZGVmaW5l
ICdETUFNVVhfTlInLiBObyBhbnkNCmZ1bmN0aW9uIGNoYW5nZSBoZXJlLg0KDQpTaWduZWQtb2Zm
LWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9m
c2wtZWRtYS1jb21tb24uaCB8ICAxICsNCiBkcml2ZXJzL2RtYS9mc2wtZWRtYS5jICAgICAgICB8
IDExICsrKysrKy0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uaCBi
L2RyaXZlcnMvZG1hL2ZzbC1lZG1hLWNvbW1vbi5oDQppbmRleCBjNTNmNzZlLi4yMWE5Y2ZkIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmgNCisrKyBiL2RyaXZlcnMv
ZG1hL2ZzbC1lZG1hLWNvbW1vbi5oDQpAQCAtMTQ1LDYgKzE0NSw3IEBAIHN0cnVjdCBmc2xfZWRt
YV9lbmdpbmUgew0KIAl2b2lkIF9faW9tZW0JCSptZW1iYXNlOw0KIAl2b2lkIF9faW9tZW0JCSpt
dXhiYXNlW0RNQU1VWF9OUl07DQogCXN0cnVjdCBjbGsJCSptdXhjbGtbRE1BTVVYX05SXTsNCisJ
dTMyCQkJZG1hbXV4X25yOw0KIAlzdHJ1Y3QgbXV0ZXgJCWZzbF9lZG1hX211dGV4Ow0KIAl1MzIJ
CQluX2NoYW5zOw0KIAlpbnQJCQl0eGlycTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9mc2wt
ZWRtYS5jIGIvZHJpdmVycy9kbWEvZnNsLWVkbWEuYw0KaW5kZXggZDY0MWVmOC4uN2I2NWVmNCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL2Zz
bC1lZG1hLmMNCkBAIC05Niw3ICs5Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2NoYW4gKmZzbF9l
ZG1hX3hsYXRlKHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmRtYV9zcGVjLA0KIAlzdHJ1Y3QgZnNs
X2VkbWFfZW5naW5lICpmc2xfZWRtYSA9IG9mZG1hLT5vZl9kbWFfZGF0YTsNCiAJc3RydWN0IGRt
YV9jaGFuICpjaGFuLCAqX2NoYW47DQogCXN0cnVjdCBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbjsN
Ci0JdW5zaWduZWQgbG9uZyBjaGFuc19wZXJfbXV4ID0gZnNsX2VkbWEtPm5fY2hhbnMgLyBETUFN
VVhfTlI7DQorCXVuc2lnbmVkIGxvbmcgY2hhbnNfcGVyX211eCA9IGZzbF9lZG1hLT5uX2NoYW5z
IC8gZnNsX2VkbWEtPmRtYW11eF9ucjsNCiANCiAJaWYgKGRtYV9zcGVjLT5hcmdzX2NvdW50ICE9
IDIpDQogCQlyZXR1cm4gTlVMTDsNCkBAIC0yMDYsNiArMjA2LDcgQEAgc3RhdGljIGludCBmc2xf
ZWRtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIC1FTk9N
RU07DQogDQogCWZzbF9lZG1hLT52ZXJzaW9uID0gdjE7DQorCWZzbF9lZG1hLT5kbWFtdXhfbnIg
PSBETUFNVVhfTlI7DQogCWZzbF9lZG1hLT5uX2NoYW5zID0gY2hhbnM7DQogCW11dGV4X2luaXQo
JmZzbF9lZG1hLT5mc2xfZWRtYV9tdXRleCk7DQogDQpAQCAtMjE3LDcgKzIxOCw3IEBAIHN0YXRp
YyBpbnQgZnNsX2VkbWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJZnNs
X2VkbWFfc2V0dXBfcmVncyhmc2xfZWRtYSk7DQogCXJlZ3MgPSAmZnNsX2VkbWEtPnJlZ3M7DQog
DQotCWZvciAoaSA9IDA7IGkgPCBETUFNVVhfTlI7IGkrKykgew0KKwlmb3IgKGkgPSAwOyBpIDwg
ZnNsX2VkbWEtPmRtYW11eF9ucjsgaSsrKSB7DQogCQljaGFyIGNsa25hbWVbMzJdOw0KIA0KIAkJ
cmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAxICsgaSk7
DQpAQCAtMjk1LDcgKzI5Niw3IEBAIHN0YXRpYyBpbnQgZnNsX2VkbWFfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycigmcGRldi0+ZGV2
LA0KIAkJCSJDYW4ndCByZWdpc3RlciBGcmVlc2NhbGUgZURNQSBlbmdpbmUuICglZClcbiIsIHJl
dCk7DQotCQlmc2xfZGlzYWJsZV9jbG9ja3MoZnNsX2VkbWEsIERNQU1VWF9OUik7DQorCQlmc2xf
ZGlzYWJsZV9jbG9ja3MoZnNsX2VkbWEsIGZzbF9lZG1hLT5kbWFtdXhfbnIpOw0KIAkJcmV0dXJu
IHJldDsNCiAJfQ0KIA0KQEAgLTMwNCw3ICszMDUsNyBAQCBzdGF0aWMgaW50IGZzbF9lZG1hX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlkZXZfZXJyKCZwZGV2LT5kZXYs
DQogCQkJIkNhbid0IHJlZ2lzdGVyIEZyZWVzY2FsZSBlRE1BIG9mX2RtYS4gKCVkKVxuIiwgcmV0
KTsNCiAJCWRtYV9hc3luY19kZXZpY2VfdW5yZWdpc3RlcigmZnNsX2VkbWEtPmRtYV9kZXYpOw0K
LQkJZnNsX2Rpc2FibGVfY2xvY2tzKGZzbF9lZG1hLCBETUFNVVhfTlIpOw0KKwkJZnNsX2Rpc2Fi
bGVfY2xvY2tzKGZzbF9lZG1hLCBmc2xfZWRtYS0+ZG1hbXV4X25yKTsNCiAJCXJldHVybiByZXQ7
DQogCX0NCiANCkBAIC0zMjMsNyArMzI0LDcgQEAgc3RhdGljIGludCBmc2xfZWRtYV9yZW1vdmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJZnNsX2VkbWFfY2xlYW51cF92Y2hhbigm
ZnNsX2VkbWEtPmRtYV9kZXYpOw0KIAlvZl9kbWFfY29udHJvbGxlcl9mcmVlKG5wKTsNCiAJZG1h
X2FzeW5jX2RldmljZV91bnJlZ2lzdGVyKCZmc2xfZWRtYS0+ZG1hX2Rldik7DQotCWZzbF9kaXNh
YmxlX2Nsb2Nrcyhmc2xfZWRtYSwgRE1BTVVYX05SKTsNCisJZnNsX2Rpc2FibGVfY2xvY2tzKGZz
bF9lZG1hLCBmc2xfZWRtYS0+ZG1hbXV4X25yKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KLS0gDQoy
LjcuNA0KDQo=

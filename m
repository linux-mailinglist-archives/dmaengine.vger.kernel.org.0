Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 555DD1606E
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfEGJQn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:16:43 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:13655
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbfEGJQm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfBzwycpDbBPAgXCL4wNNcnI5vI7RJR5MGCklB6myHU=;
 b=TF3F9lhYrwMAs/VEa1xdG/fwILZZYiCewTSHLsHIg9aHpJZ6U+BaKTGLFg/6Kgv2oxU4YKyUdQvWCuSbrFM7IRNiYoqwbyArFyuJYdkThKAQnNMKMsxNKzqsbsPdSe26zPqMHZSc/uchu52cskPAT35bTalk9wF23khY+FrqBhs=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3184.eurprd04.prod.outlook.com (10.170.229.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 09:16:31 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:31 +0000
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
Subject: [PATCH v3 09/14] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Thread-Topic: [PATCH v3 09/14] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Index: AQHVBLWPS151QmkLjkKpxV9/3Wj8wg==
Date:   Tue, 7 May 2019 09:16:31 +0000
Message-ID: <1557249513-4903-10-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: cc85cf58-79fe-46d9-89bf-08d6d2ccb19c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3184;
x-ms-traffictypediagnostic: VI1PR04MB3184:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB31845D5B20BE51AC74BBC50089310@VI1PR04MB3184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(478600001)(2906002)(7416002)(68736007)(966005)(81156014)(8676002)(4326008)(6116002)(81166006)(86362001)(2201001)(2501003)(476003)(256004)(446003)(11346002)(14444005)(2616005)(6512007)(6306002)(486006)(8936002)(3846002)(110136005)(6436002)(36756003)(5660300002)(66066001)(99286004)(54906003)(7736002)(66446008)(64756008)(66556008)(102836004)(66476007)(14454004)(25786009)(73956011)(71190400001)(71200400001)(66946007)(305945005)(386003)(6486002)(53936002)(50226002)(6506007)(76176011)(186003)(52116002)(26005)(316002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3184;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CT8O8Arxef0FuwlguPXA1D40wnLPb1nP5G44mr68pMaS7EBalGqcYLaGS9SkDtijlufu66Hn9Ef8xnnJa2aj7GpV2P00bl2ptrlYTWCVL1d7BoLENf8LnxtdSm39LWXMWNTWor5GxlGaxqVH8M47SQXP1npURzpuSGIoQvX6jIhjbsGSVURxlOlrdKEoFeROeQGJ8cYncK9S2AkoJ9gGqeCZYowvZ49Nl9++AYGS7knw/X0Xg3VON7FUt4J75j+hJDHvo6L9AoZSUnFH2pBxY5Q5iAQEf5O1R69YksQkLv8MczOl43WVTnBxLpQvfMGZy0spNyqtuRFHsfeu88lG4kfy+uWjpxZ368WNLegWwYuCmCts4eT9GPK8ZzPNP7E3iB7SdMpiU/F2KpGqz/v+5xAdXbHbzeC85aH5dM7yD2c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc85cf58-79fe-46d9-89bf-08d6d2ccb19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:31.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3184
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RUNTUEkgaXNzdWUgZml4ZWQgZnJvbSBpLm14NnVsIGF0IGhhcmR3YXJlIGxldmVsLCBubyBuZWVk
DQpFUlIwMDkxNjUgYW55bW9yZSBvbiB0aG9zZSBjaGlwcyBzdWNoIGFzIGkubXg4bXEuIEFkZCBp
Lm14NnN4DQpmcm9tIHdoZXJlIGkubXg2dWwgc291cmNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5j
IHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
CiAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMN
CmluZGV4IDM1MmIwZDUuLmE0OTVjN2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jDQorKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQpAQCAtNDE5LDYgKzQxOSwxMyBAQCBz
dHJ1Y3Qgc2RtYV9kcml2ZXJfZGF0YSB7DQogCWludCBudW1fZXZlbnRzOw0KIAlzdHJ1Y3Qgc2Rt
YV9zY3JpcHRfc3RhcnRfYWRkcnMJKnNjcmlwdF9hZGRyczsNCiAJYm9vbCBjaGVja19yYXRpbzsN
CisJLyoNCisJICogZWNzcGkgRVJSMDA5MTY1IGZpeGVkIHNob3VsZCBiZSBkb25lIGluIHNkbWEg
c2NyaXB0DQorCSAqIGFuZCBpdCBoYXMgYmVlbiBmaXhlZCBpbiBzb2MgZnJvbSBpLm14NnVsLg0K
KwkgKiBwbGVhc2UgZ2V0IG1vcmUgaW5mb3JtYXRpb24gZnJvbSB0aGUgYmVsb3cgbGluazoNCisJ
ICogaHR0cHM6Ly93d3cubnhwLmNvbS9kb2NzL2VuL2VycmF0YS9JTVg2RFFDRS5wZGYNCisJICov
DQorCWJvb2wgZWNzcGlfZml4ZWQ7DQogfTsNCiANCiBzdHJ1Y3Qgc2RtYV9lbmdpbmUgew0KQEAg
LTUzOSw2ICs1NDYsMzEgQEAgc3RhdGljIHN0cnVjdCBzZG1hX2RyaXZlcl9kYXRhIHNkbWFfaW14
NnEgPSB7DQogCS5zY3JpcHRfYWRkcnMgPSAmc2RtYV9zY3JpcHRfaW14NnEsDQogfTsNCiANCitz
dGF0aWMgc3RydWN0IHNkbWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHNkbWFfc2NyaXB0X2lteDZzeCA9
IHsNCisJLmFwXzJfYXBfYWRkciA9IDY0MiwNCisJLnVhcnRfMl9tY3VfYWRkciA9IDgxNywNCisJ
Lm1jdV8yX2FwcF9hZGRyID0gNzQ3LA0KKwkudWFydHNoXzJfbWN1X2FkZHIgPSAxMDMyLA0KKwku
bWN1XzJfc2hwX2FkZHIgPSA5NjAsDQorCS5hcHBfMl9tY3VfYWRkciA9IDY4MywNCisJLnNocF8y
X21jdV9hZGRyID0gODkxLA0KKwkuc3BkaWZfMl9tY3VfYWRkciA9IDExMDAsDQorCS5tY3VfMl9z
cGRpZl9hZGRyID0gMTEzNCwNCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3Qgc2RtYV9kcml2ZXJfZGF0
YSBzZG1hX2lteDZzeCA9IHsNCisJLmNobmVuYmwwID0gU0RNQV9DSE5FTkJMMF9JTVgzNSwNCisJ
Lm51bV9ldmVudHMgPSA0OCwNCisJLnNjcmlwdF9hZGRycyA9ICZzZG1hX3NjcmlwdF9pbXg2c3gs
DQorfTsNCisNCitzdGF0aWMgc3RydWN0IHNkbWFfZHJpdmVyX2RhdGEgc2RtYV9pbXg2dWwgPSB7
DQorCS5jaG5lbmJsMCA9IFNETUFfQ0hORU5CTDBfSU1YMzUsDQorCS5udW1fZXZlbnRzID0gNDgs
DQorCS5zY3JpcHRfYWRkcnMgPSAmc2RtYV9zY3JpcHRfaW14NnN4LA0KKwkuZWNzcGlfZml4ZWQg
PSB0cnVlLA0KK307DQorDQogc3RhdGljIHN0cnVjdCBzZG1hX3NjcmlwdF9zdGFydF9hZGRycyBz
ZG1hX3NjcmlwdF9pbXg3ZCA9IHsNCiAJLmFwXzJfYXBfYWRkciA9IDY0NCwNCiAJLnVhcnRfMl9t
Y3VfYWRkciA9IDgxOSwNCkBAIC01ODQsOSArNjE2LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlX2lkIHNkbWFfZGV2dHlwZXNbXSA9IHsNCiAJCS5uYW1lID0gImlteDZx
LXNkbWEiLA0KIAkJLmRyaXZlcl9kYXRhID0gKHVuc2lnbmVkIGxvbmcpJnNkbWFfaW14NnEsDQog
CX0sIHsNCisJCS5uYW1lID0gImlteDZzeC1zZG1hIiwNCisJCS5kcml2ZXJfZGF0YSA9ICh1bnNp
Z25lZCBsb25nKSZzZG1hX2lteDZzeCwNCisJfSwgew0KIAkJLm5hbWUgPSAiaW14N2Qtc2RtYSIs
DQogCQkuZHJpdmVyX2RhdGEgPSAodW5zaWduZWQgbG9uZykmc2RtYV9pbXg3ZCwNCiAJfSwgew0K
KwkJLm5hbWUgPSAiaW14NnVsLXNkbWEiLA0KKwkJLmRyaXZlcl9kYXRhID0gKHVuc2lnbmVkIGxv
bmcpJnNkbWFfaW14NnVsLA0KKwl9LCB7DQogCQkubmFtZSA9ICJpbXg4bXEtc2RtYSIsDQogCQku
ZHJpdmVyX2RhdGEgPSAodW5zaWduZWQgbG9uZykmc2RtYV9pbXg4bXEsDQogCX0sIHsNCkBAIC02
MDIsNyArNjQwLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc2RtYV9kdF9p
ZHNbXSA9IHsNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14MzUtc2RtYSIsIC5kYXRhID0gJnNk
bWFfaW14MzUsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDMxLXNkbWEiLCAuZGF0YSA9
ICZzZG1hX2lteDMxLCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgyNS1zZG1hIiwgLmRh
dGEgPSAmc2RtYV9pbXgyNSwgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnN4LXNkbWEi
LCAuZGF0YSA9ICZzZG1hX2lteDZzeCwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N2Qt
c2RtYSIsIC5kYXRhID0gJnNkbWFfaW14N2QsIH0sDQorCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlt
eDZ1bC1zZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXg2dWwsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtcS1zZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXg4bXEsIH0sDQogCXsgLyogc2VudGlu
ZWwgKi8gfQ0KIH07DQpAQCAtMTE2Niw4ICsxMjA2LDE3IEBAIHN0YXRpYyBpbnQgc2RtYV9jb25m
aWdfY2hhbm5lbChzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pDQogCQkJaWYgKHNkbWFjLT5wZXJpcGhl
cmFsX3R5cGUgPT0gSU1YX0RNQVRZUEVfQVNSQ19TUCB8fA0KIAkJCSAgICBzZG1hYy0+cGVyaXBo
ZXJhbF90eXBlID09IElNWF9ETUFUWVBFX0FTUkMpDQogCQkJCXNkbWFfc2V0X3dhdGVybWFya2xl
dmVsX2Zvcl9wMnAoc2RtYWMpOw0KLQkJfSBlbHNlDQorCQl9IGVsc2Ugew0KKwkJCS8qDQorCQkJ
ICogRVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgbm8gZXJyYXRhIG5lZWQsDQorCQkJICog
c2V0IGJpdDMxIHRvIGxldCBzZG1hIHNjcmlwdCBza2lwIHRoZSBlcnJhdGEuDQorCQkJICovDQor
CQkJaWYgKHNkbWFjLT5wZXJpcGhlcmFsX3R5cGUgPT0gSU1YX0RNQVRZUEVfQ1NQSSAmJg0KKwkJ
CSAgICBzZG1hYy0+ZGlyZWN0aW9uID09IERNQV9NRU1fVE9fREVWICYmDQorCQkJICAgIHNkbWFj
LT5zZG1hLT5kcnZkYXRhLT5lY3NwaV9maXhlZCkNCisJCQkJX19zZXRfYml0KDMxLCAmc2RtYWMt
PndhdGVybWFya19sZXZlbCk7DQogCQkJX19zZXRfYml0KHNkbWFjLT5ldmVudF9pZDAsIHNkbWFj
LT5ldmVudF9tYXNrKTsNCisJCX0NCiANCiAJCS8qIEFkZHJlc3MgKi8NCiAJCXNkbWFjLT5zaHBf
YWRkciA9IHNkbWFjLT5wZXJfYWRkcmVzczsNCi0tIA0KMi43LjQNCg0K

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5A16070
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfEGJQ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:16:58 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:57499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbfEGJQ6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty+NeUuEjZSg4Rw8zZhrdypRduOUc/wIbBosqPyPia0=;
 b=yIdgOXmwnRvq5itGJ8Gk8zl+W1gglFeFAVZIHDowok6M+msr9NpsLvSFhzgxSXd+CJ2ThqdZYy+qF1F1r3mQ2BboYGc6kOV9EmpRyZm3pIWSinnVvjmhe+68xrq1QS/Yd7zuYCbqje+P++7co19GzPMwl1pAh32U8LvHsUyehKc=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:16:13 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:13 +0000
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
Subject: [PATCH v3 06/14] spi: imx: fix ERR009165
Thread-Topic: [PATCH v3 06/14] spi: imx: fix ERR009165
Thread-Index: AQHVBLWEuFpHOQnu6U2WCKaGedJC3w==
Date:   Tue, 7 May 2019 09:16:13 +0000
Message-ID: <1557249513-4903-7-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: e7451482-eede-4d7a-978e-08d6d2cca698
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5005;
x-ms-traffictypediagnostic: VI1PR04MB5005:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB5005DD91D3E09F4F3BA4759889310@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(386003)(6506007)(2501003)(36756003)(102836004)(6486002)(26005)(8676002)(4326008)(5660300002)(25786009)(68736007)(52116002)(76176011)(186003)(2201001)(6306002)(6512007)(53936002)(3846002)(71200400001)(14444005)(66556008)(966005)(86362001)(66446008)(64756008)(476003)(66476007)(7416002)(305945005)(2906002)(11346002)(7736002)(66066001)(6116002)(99286004)(54906003)(256004)(14454004)(2616005)(73956011)(110136005)(6436002)(50226002)(8936002)(81156014)(81166006)(66946007)(316002)(71190400001)(486006)(478600001)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lmr+FY3+TChpLev9OPRQxuCRYLzA5C+q2anrx+MEPkhtaIgmxj6x3ldlV6hL7oH+jJtYLOnXQMhjFbyZK/3kWEyxWHim6IFK6sa3x6xv1mGHzHq8FTyFSU+ed8NC6qonEFb3qn83DnxHM7mCUV1VzZpRNzqFvkCeSvgx8H6o2pMYO9jy2jocRq1Lt8oiKeERupfJuQuIbnGc1DvEFjSoW2TvsovJsuUd1kJhde1qIZLy03zyoq6GAM87xnShlSuEk5LhEGckmHiaX/FtKd83VbkOKTlizqfdMOw+lYno55igkksmNZi3FujnQRqgS3+HKqpZUVsKuEv6YBT6zJ8ibxU6C0v26c6W5A1dmCU/e5KgB4TO876tFHJZQBm4koyuHgxbL4iQXSexN8xbfb3SSiAOKuQ0+VCurDtWG55mp8w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7451482-eede-4d7a-978e-08d6d2cca698
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:13.1954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Q2hhbmdlIHRvIFhDSCAgbW9kZSBldmVuIGluIGRtYSBtb2RlLCBwbGVhc2UgcmVmZXIgdG8gdGhl
IGJlbG93DQplcnJhdGE6DQpodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZE
UUNFLnBkZg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+
DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktaW14LmMgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zcGkvc3BpLWlteC5jIGIvZHJpdmVycy9zcGkvc3BpLWlteC5jDQppbmRl
eCAwOWM5YTFlLi42Nzk1OTEwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zcGkvc3BpLWlteC5jDQor
KysgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCkBAIC01ODUsOCArNTg1LDkgQEAgc3RhdGljIGlu
dCBteDUxX2Vjc3BpX3ByZXBhcmVfdHJhbnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lt
eCwNCiAJY3RybCB8PSBteDUxX2Vjc3BpX2Nsa2RpdihzcGlfaW14LCB0LT5zcGVlZF9oeiwgJmNs
ayk7DQogCXNwaV9pbXgtPnNwaV9idXNfY2xrID0gY2xrOw0KIA0KKwkvKiBFUlIwMDkxNjU6IHdv
cmsgaW4gWEhDIG1vZGUgYXMgUElPICovDQogCWlmIChzcGlfaW14LT51c2VkbWEpDQotCQljdHJs
IHw9IE1YNTFfRUNTUElfQ1RSTF9TTUM7DQorCQljdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01D
Ow0KIA0KIAl3cml0ZWwoY3RybCwgc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfQ1RSTCk7DQog
DQpAQCAtNjEyLDEyICs2MTMsMTQgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBhcmVfdHJh
bnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwNCiANCiBzdGF0aWMgdm9pZCBteDUx
X3NldHVwX3dtbChzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14KQ0KIHsNCisJdTMyIHR4X3dt
bCA9IDA7DQorDQogCS8qDQogCSAqIENvbmZpZ3VyZSB0aGUgRE1BIHJlZ2lzdGVyOiBzZXR1cCB0
aGUgd2F0ZXJtYXJrDQogCSAqIGFuZCBlbmFibGUgRE1BIHJlcXVlc3QuDQogCSAqLw0KIAl3cml0
ZWwoTVg1MV9FQ1NQSV9ETUFfUlhfV01MKHNwaV9pbXgtPndtbCAtIDEpIHwNCi0JCU1YNTFfRUNT
UElfRE1BX1RYX1dNTChzcGlfaW14LT53bWwpIHwNCisJCU1YNTFfRUNTUElfRE1BX1RYX1dNTCh0
eF93bWwpIHwNCiAJCU1YNTFfRUNTUElfRE1BX1JYVF9XTUwoc3BpX2lteC0+d21sKSB8DQogCQlN
WDUxX0VDU1BJX0RNQV9URURFTiB8IE1YNTFfRUNTUElfRE1BX1JYREVOIHwNCiAJCU1YNTFfRUNT
UElfRE1BX1JYVERFTiwgc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfRE1BKTsNCkBAIC0xMTcx
LDcgKzExNzQsMTEgQEAgc3RhdGljIGludCBzcGlfaW14X2RtYV9jb25maWd1cmUoc3RydWN0IHNw
aV9tYXN0ZXIgKm1hc3RlcikNCiAJdHguZGlyZWN0aW9uID0gRE1BX01FTV9UT19ERVY7DQogCXR4
LmRzdF9hZGRyID0gc3BpX2lteC0+YmFzZV9waHlzICsgTVhDX0NTUElUWERBVEE7DQogCXR4LmRz
dF9hZGRyX3dpZHRoID0gYnVzd2lkdGg7DQotCXR4LmRzdF9tYXhidXJzdCA9IHNwaV9pbXgtPndt
bDsNCisJLyoNCisJICogRm9yIEVSUjAwOTE2NSB3aXRoIHR4X3dtbCA9IDAgY291bGQgZW5sYXJn
ZSBidXJzdCBzaXplIHRvIGZpZm8gc2l6ZQ0KKwkgKiB0byBzcGVlZCB1cCBmaWZvIGZpbGxpbmcg
YXMgcG9zc2libGUuDQorCSAqLw0KKwl0eC5kc3RfbWF4YnVyc3QgPSBzcGlfaW14LT5kZXZ0eXBl
X2RhdGEtPmZpZm9fc2l6ZTsNCiAJcmV0ID0gZG1hZW5naW5lX3NsYXZlX2NvbmZpZyhtYXN0ZXIt
PmRtYV90eCwgJnR4KTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycihzcGlfaW14LT5kZXYsICJU
WCBkbWEgY29uZmlndXJhdGlvbiBmYWlsZWQgd2l0aCAlZFxuIiwgcmV0KTsNCkBAIC0xMjY1LDEw
ICsxMjcyLDYgQEAgc3RhdGljIGludCBzcGlfaW14X3NkbWFfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgsDQogew0KIAlpbnQgcmV0Ow0KIA0KLQkv
KiB1c2UgcGlvIG1vZGUgZm9yIGkubXg2ZGwgY2hpcCBUS1QyMzgyODUgKi8NCi0JaWYgKG9mX21h
Y2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLGlteDZkbCIpKQ0KLQkJcmV0dXJuIDA7DQotDQogCXNw
aV9pbXgtPndtbCA9IHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+Zmlmb19zaXplIC8gMjsNCiANCiAJ
LyogUHJlcGFyZSBmb3IgVFggRE1BOiAqLw0KLS0gDQoyLjcuNA0KDQo=

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7467216056
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEGJQF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:16:05 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:41622
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfEGJQF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfwnvc3K8QGX0wDh9tfJHNbMun62ZXLaxv+aLZ1evlc=;
 b=syptcpmwc8TsXxMoiP9VDQfmMw0q29knA+DMAwlvtY347xz/w5bI5a0LzZC25KpzYZaEfIybzz2O5h9IMgTeg6MpDrkhxzgHBvlN/79zzeBO9VNOtpGpOdvMxnfKHDsBGNaISGtULe6AHnkpPFGeOjs4Vb6J5lQh9NstjErICOQ=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3184.eurprd04.prod.outlook.com (10.170.229.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 09:16:00 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:00 +0000
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
Subject: [PATCH v3 04/14] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Topic: [PATCH v3 04/14] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Index: AQHVBLV8RmnHyhKro0eQ/4um+L0i4A==
Date:   Tue, 7 May 2019 09:16:00 +0000
Message-ID: <1557249513-4903-5-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 24377e37-7111-4c3c-7861-08d6d2cc9eb2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3184;
x-ms-traffictypediagnostic: VI1PR04MB3184:
x-microsoft-antispam-prvs: <VI1PR04MB3184DF355682712AF80AFA0C89310@VI1PR04MB3184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(478600001)(2906002)(7416002)(4744005)(68736007)(81156014)(8676002)(4326008)(6116002)(81166006)(86362001)(2201001)(2501003)(476003)(256004)(446003)(11346002)(2616005)(6512007)(486006)(8936002)(3846002)(110136005)(6436002)(36756003)(5660300002)(66066001)(99286004)(54906003)(7736002)(66446008)(64756008)(66556008)(102836004)(66476007)(14454004)(25786009)(73956011)(71190400001)(71200400001)(66946007)(305945005)(386003)(6486002)(53936002)(50226002)(6506007)(76176011)(186003)(52116002)(26005)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3184;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TBU7V/UFuApPOMiJ66ANMuFlcNExVMefeleE5bynDnVgZFQN6rHLECFULkl4afQaZOJDUuUMOIxf2dDp6J/A/fv8/TJS3qfSaxpyEPl60Yql8go9Sh33+QtdUi31xyKfvA48drsDWoj5wJRZea5DG0KL8R1ccnTWJ+2IEsGGA/Ac70vDPJwZoadGGTLeyBMiVAQkRi+o4JzDmoieAkBd/tCnjDvDcD5OFuOaRpQ4uu+xR2La5iEbBxLuvrkE7iMIh6/Qn2UwRqYLotsHtwb1bXSxtzfWUi2qwoG0d5gv76Eg6SZrZMx2kwyVBuxjj29mYm0IeOpTIOy2U3SwpKrjv7+OT9BY1rJGNlg/lWBUzChqQkjXZZfwGxNCuZJzfAulM2BSHVqItURNyiJOjdaNFIPwIXh9iDdWQQ+mFdGzDWI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24377e37-7111-4c3c-7861-08d6d2cc9eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:00.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3184
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

U2luY2Ugc2RtYV90cmFuc2Zlcl9pbml0KCkgd2lsbCBkbyBzZG1hX2xvYWRfY29udGV4dCBiZWZv
cmUgYW55DQpzZG1hIHRyYW5zZmVyLCBubyBuZWVkIG9uY2UgbW9yZSBpbiBzZG1hX2NvbmZpZ19j
aGFubmVsKCkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgfCA1ICstLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDQwN2E1NmUu
Ljg2YTMxYjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2
ZXJzL2RtYS9pbXgtc2RtYS5jDQpAQCAtMTEzNCw3ICsxMTM0LDYgQEAgc3RhdGljIHZvaWQgc2Rt
YV9zZXRfd2F0ZXJtYXJrbGV2ZWxfZm9yX3AycChzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYykN
CiBzdGF0aWMgaW50IHNkbWFfY29uZmlnX2NoYW5uZWwoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0K
IHsNCiAJc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMgPSB0b19zZG1hX2NoYW4oY2hhbik7DQot
CWludCByZXQ7DQogDQogCXNkbWFfZGlzYWJsZV9jaGFubmVsKGNoYW4pOw0KIA0KQEAgLTExNzQs
OSArMTE3Myw3IEBAIHN0YXRpYyBpbnQgc2RtYV9jb25maWdfY2hhbm5lbChzdHJ1Y3QgZG1hX2No
YW4gKmNoYW4pDQogCQlzZG1hYy0+d2F0ZXJtYXJrX2xldmVsID0gMDsgLyogRklYTUU6IE0zX0JB
U0VfQUREUkVTUyAqLw0KIAl9DQogDQotCXJldCA9IHNkbWFfbG9hZF9jb250ZXh0KHNkbWFjKTsN
Ci0NCi0JcmV0dXJuIHJldDsNCisJcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBpbnQgc2RtYV9z
ZXRfY2hhbm5lbF9wcmlvcml0eShzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYywNCi0tIA0KMi43
LjQNCg0K

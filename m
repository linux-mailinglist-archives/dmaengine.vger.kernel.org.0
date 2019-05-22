Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AED260F6
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfEVKAG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:06 -0400
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:46150
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729145AbfEVKAF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhaLCxWugmrtg+aneJiqRbKnyiUWWd9fuZwy1x/Q554=;
 b=Bdns/ajbig9sLYkG/Aw4bGbj1eQJZFxjwmmLrnOdiZ+Dsauht3yxoXKiB84gilXmyYZlKx2IdkgwIQL9f5uo4HujXlXAVr1z3F3msAJH8/Yt4oqRiKS9KUD9iHuXA7xlhbf3Jau7TrGIdeyh2IyUK4O39TU7WGlXfe/pGlsPOwo=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3103.eurprd04.prod.outlook.com (10.170.229.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:02 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:02 +0000
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
Subject: [PATCH v4 04/14] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Topic: [PATCH v4 04/14] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Index: AQHVEIUf43QK9vx3606EzlouCVI5BQ==
Date:   Wed, 22 May 2019 10:00:02 +0000
Message-ID: <1558548188-1155-5-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 94581b27-3765-472f-aee8-08d6de9c41e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3103;
x-ms-traffictypediagnostic: VI1PR04MB3103:
x-microsoft-antispam-prvs: <VI1PR04MB31039EABE46FBE300A13C61689000@VI1PR04MB3103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(68736007)(81166006)(2201001)(2501003)(52116002)(71200400001)(14454004)(186003)(256004)(26005)(53936002)(7736002)(25786009)(81156014)(305945005)(8936002)(4326008)(86362001)(8676002)(50226002)(71190400001)(486006)(6512007)(5660300002)(6436002)(66946007)(73956011)(498600001)(446003)(66446008)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(99286004)(386003)(6506007)(2906002)(4744005)(54906003)(76176011)(36756003)(11346002)(110136005)(7416002)(2616005)(6486002)(102836004)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3103;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TbVNFyneFjZAD4r71WI0DO39iN2SmAJh34hHxZr4CzmX3wBVuIlxZbHVaareB0HNpOJHDcWEAr3YABjBQZNGDXTM7YvGUxWbLlyCB4Nve/yXbAMYiT29QXvHlgM1RZi9dQX5AdCCiOfrk+JENIJIhIqVQI5goPw1T8BRKgVn5aBA1D3qVldB9w7G+cVxknzvFKuVo29GDqHv5q7s+hlJsEzf7MINsxJxfjoj/Ib+f9C1M2qz8dXIBcFUs0d0SeWeeea6Vd3qiLVVa9z3N8Xj9HWPMNZhMk2qKhaPkTrqeMJRpCL9O1i0bKT3VrmaB7cL7Vgs6aRW/vhgSQ/xF1lEmrYDIpKusPBdTAxzthNWxzGM2PhA/HW+nkRkXjdTjIDn1GdViv8yF6fo+a0XH54i94PV1tjNqV7y20jKftbq16U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94581b27-3765-472f-aee8-08d6de9c41e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:02.7978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

U2luY2Ugc2RtYV90cmFuc2Zlcl9pbml0KCkgd2lsbCBkbyBzZG1hX2xvYWRfY29udGV4dCBiZWZv
cmUgYW55DQpzZG1hIHRyYW5zZmVyLCBubyBuZWVkIG9uY2UgbW9yZSBpbiBzZG1hX2NvbmZpZ19j
aGFubmVsKCkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCkFja2VkLWJ5OiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KLS0tDQogZHJpdmVy
cy9kbWEvaW14LXNkbWEuYyB8IDUgKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5j
IGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KaW5kZXggNDA3YTU2ZS4uODZhMzFiNCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1h
LmMNCkBAIC0xMTM0LDcgKzExMzQsNiBAQCBzdGF0aWMgdm9pZCBzZG1hX3NldF93YXRlcm1hcmts
ZXZlbF9mb3JfcDJwKHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KIHN0YXRpYyBpbnQgc2Rt
YV9jb25maWdfY2hhbm5lbChzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pDQogew0KIAlzdHJ1Y3Qgc2Rt
YV9jaGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFuKTsNCi0JaW50IHJldDsNCiANCiAJ
c2RtYV9kaXNhYmxlX2NoYW5uZWwoY2hhbik7DQogDQpAQCAtMTE3NCw5ICsxMTczLDcgQEAgc3Rh
dGljIGludCBzZG1hX2NvbmZpZ19jaGFubmVsKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikNCiAJCXNk
bWFjLT53YXRlcm1hcmtfbGV2ZWwgPSAwOyAvKiBGSVhNRTogTTNfQkFTRV9BRERSRVNTICovDQog
CX0NCiANCi0JcmV0ID0gc2RtYV9sb2FkX2NvbnRleHQoc2RtYWMpOw0KLQ0KLQlyZXR1cm4gcmV0
Ow0KKwlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGludCBzZG1hX3NldF9jaGFubmVsX3ByaW9y
aXR5KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjLA0KLS0gDQoyLjcuNA0KDQo=

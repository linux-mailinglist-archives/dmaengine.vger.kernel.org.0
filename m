Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C918926115
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 12:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfEVKAi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 06:00:38 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:28654
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbfEVKAh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 May 2019 06:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct68dR1Lh5CraaVS62exIjxqn/tFhxqLEnSbpighZMw=;
 b=bhP3+/dS2lfiR64yOtxeD3aa0UMpKfekmajllg3Z6UJ3HPKE453mNr/p2Z7e4Lm7G5G6Md+QRAwyBZkGVJyx6dxtxTs8nvW7rQnIJQAit82x7rb0l0Wl/S/QIeKVqI8sIqpw7yCRcMR+uVGL6XZgOkrjB4YEjhX4ln3slE1MWKs=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:00:32 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:32 +0000
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
Subject: [PATCH v4 09/14] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Thread-Topic: [PATCH v4 09/14] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Index: AQHVEIUxNfPurw4hgUio/AV0jNSOUQ==
Date:   Wed, 22 May 2019 10:00:32 +0000
Message-ID: <1558548188-1155-10-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 72bc11d2-524c-4d50-3644-08d6de9c53c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3149;
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB3149F6A4CD7DD4659096BA3389000@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2501003)(446003)(11346002)(2616005)(186003)(68736007)(26005)(5660300002)(476003)(86362001)(71190400001)(50226002)(54906003)(110136005)(66066001)(76176011)(486006)(4326008)(7736002)(52116002)(2201001)(71200400001)(36756003)(6512007)(99286004)(7416002)(6306002)(386003)(8676002)(6506007)(305945005)(53936002)(81166006)(66446008)(25786009)(64756008)(81156014)(6436002)(256004)(6486002)(966005)(102836004)(14454004)(73956011)(8936002)(498600001)(2906002)(66946007)(66476007)(14444005)(66556008)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k7gy1jyVxSCcl/6of9kIpPSsWgwdILDphp5ov0z0VfacoqCAMA7wjjOacvVkBPG246phqN8J0DzWtgriGIaxvXeh5CLxQsupqGGFSGJK59uS3hXchHPfHZD+bXXRjt0w3UtgeqrVSuikOUVRh1M6gesw/vJi45H6pGGaol6B0ukF2hfBhHEPliDu7mR27RYLNYDNb2qA2uBd2SpbAqqmtBKVqk6nwxjAqojU+JVPYSZ9mo+JXQ6axGBVpKXk2jivURLBfiAHbc8t8y62mGOdAhTlen50Yb/i9oIXPTrgnwmU8mfZafKy7X0vFIG0BUDhrbnpWrZV6hqjCQCYv1csZzH2NcgHCmHRV0rPIGDeCJslxGCkrINEMDurSP2wjMMntUEAItaYPfEc2JJsK2t69+luWVqpcRtI522ZymXOMFQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bc11d2-524c-4d50-3644-08d6de9c53c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:32.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RUNTUEkgaXNzdWUgZml4ZWQgZnJvbSBpLm14NnVsIGF0IGhhcmR3YXJlIGxldmVsLCBubyBuZWVk
DQpFUlIwMDkxNjUgYW55bW9yZSBvbiB0aG9zZSBjaGlwcyBzdWNoIGFzIGkubXg4bXEuIEFkZCBp
Lm14NnN4DQpmcm9tIHdoZXJlIGkubXg2dWwgc291cmNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQpBY2tlZC1ieTogVmlub2QgS291bCA8dmtvdWxA
a2VybmVsLm9yZz4NCi0tLQ0KIGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgfCA1MSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA1MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KaW5kZXggMzUyYjBkNS4u
YTQ5NWM3ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCisrKyBiL2RyaXZl
cnMvZG1hL2lteC1zZG1hLmMNCkBAIC00MTksNiArNDE5LDEzIEBAIHN0cnVjdCBzZG1hX2RyaXZl
cl9kYXRhIHsNCiAJaW50IG51bV9ldmVudHM7DQogCXN0cnVjdCBzZG1hX3NjcmlwdF9zdGFydF9h
ZGRycwkqc2NyaXB0X2FkZHJzOw0KIAlib29sIGNoZWNrX3JhdGlvOw0KKwkvKg0KKwkgKiBlY3Nw
aSBFUlIwMDkxNjUgZml4ZWQgc2hvdWxkIGJlIGRvbmUgaW4gc2RtYSBzY3JpcHQNCisJICogYW5k
IGl0IGhhcyBiZWVuIGZpeGVkIGluIHNvYyBmcm9tIGkubXg2dWwuDQorCSAqIHBsZWFzZSBnZXQg
bW9yZSBpbmZvcm1hdGlvbiBmcm9tIHRoZSBiZWxvdyBsaW5rOg0KKwkgKiBodHRwczovL3d3dy5u
eHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZEUUNFLnBkZg0KKwkgKi8NCisJYm9vbCBlY3NwaV9m
aXhlZDsNCiB9Ow0KIA0KIHN0cnVjdCBzZG1hX2VuZ2luZSB7DQpAQCAtNTM5LDYgKzU0NiwzMSBA
QCBzdGF0aWMgc3RydWN0IHNkbWFfZHJpdmVyX2RhdGEgc2RtYV9pbXg2cSA9IHsNCiAJLnNjcmlw
dF9hZGRycyA9ICZzZG1hX3NjcmlwdF9pbXg2cSwNCiB9Ow0KIA0KK3N0YXRpYyBzdHJ1Y3Qgc2Rt
YV9zY3JpcHRfc3RhcnRfYWRkcnMgc2RtYV9zY3JpcHRfaW14NnN4ID0gew0KKwkuYXBfMl9hcF9h
ZGRyID0gNjQyLA0KKwkudWFydF8yX21jdV9hZGRyID0gODE3LA0KKwkubWN1XzJfYXBwX2FkZHIg
PSA3NDcsDQorCS51YXJ0c2hfMl9tY3VfYWRkciA9IDEwMzIsDQorCS5tY3VfMl9zaHBfYWRkciA9
IDk2MCwNCisJLmFwcF8yX21jdV9hZGRyID0gNjgzLA0KKwkuc2hwXzJfbWN1X2FkZHIgPSA4OTEs
DQorCS5zcGRpZl8yX21jdV9hZGRyID0gMTEwMCwNCisJLm1jdV8yX3NwZGlmX2FkZHIgPSAxMTM0
LA0KK307DQorDQorc3RhdGljIHN0cnVjdCBzZG1hX2RyaXZlcl9kYXRhIHNkbWFfaW14NnN4ID0g
ew0KKwkuY2huZW5ibDAgPSBTRE1BX0NITkVOQkwwX0lNWDM1LA0KKwkubnVtX2V2ZW50cyA9IDQ4
LA0KKwkuc2NyaXB0X2FkZHJzID0gJnNkbWFfc2NyaXB0X2lteDZzeCwNCit9Ow0KKw0KK3N0YXRp
YyBzdHJ1Y3Qgc2RtYV9kcml2ZXJfZGF0YSBzZG1hX2lteDZ1bCA9IHsNCisJLmNobmVuYmwwID0g
U0RNQV9DSE5FTkJMMF9JTVgzNSwNCisJLm51bV9ldmVudHMgPSA0OCwNCisJLnNjcmlwdF9hZGRy
cyA9ICZzZG1hX3NjcmlwdF9pbXg2c3gsDQorCS5lY3NwaV9maXhlZCA9IHRydWUsDQorfTsNCisN
CiBzdGF0aWMgc3RydWN0IHNkbWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHNkbWFfc2NyaXB0X2lteDdk
ID0gew0KIAkuYXBfMl9hcF9hZGRyID0gNjQ0LA0KIAkudWFydF8yX21jdV9hZGRyID0gODE5LA0K
QEAgLTU4NCw5ICs2MTYsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Vf
aWQgc2RtYV9kZXZ0eXBlc1tdID0gew0KIAkJLm5hbWUgPSAiaW14NnEtc2RtYSIsDQogCQkuZHJp
dmVyX2RhdGEgPSAodW5zaWduZWQgbG9uZykmc2RtYV9pbXg2cSwNCiAJfSwgew0KKwkJLm5hbWUg
PSAiaW14NnN4LXNkbWEiLA0KKwkJLmRyaXZlcl9kYXRhID0gKHVuc2lnbmVkIGxvbmcpJnNkbWFf
aW14NnN4LA0KKwl9LCB7DQogCQkubmFtZSA9ICJpbXg3ZC1zZG1hIiwNCiAJCS5kcml2ZXJfZGF0
YSA9ICh1bnNpZ25lZCBsb25nKSZzZG1hX2lteDdkLA0KIAl9LCB7DQorCQkubmFtZSA9ICJpbXg2
dWwtc2RtYSIsDQorCQkuZHJpdmVyX2RhdGEgPSAodW5zaWduZWQgbG9uZykmc2RtYV9pbXg2dWws
DQorCX0sIHsNCiAJCS5uYW1lID0gImlteDhtcS1zZG1hIiwNCiAJCS5kcml2ZXJfZGF0YSA9ICh1
bnNpZ25lZCBsb25nKSZzZG1hX2lteDhtcSwNCiAJfSwgew0KQEAgLTYwMiw3ICs2NDAsOSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzZG1hX2R0X2lkc1tdID0gew0KIAl7IC5j
b21wYXRpYmxlID0gImZzbCxpbXgzNS1zZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXgzNSwgfSwNCiAJ
eyAuY29tcGF0aWJsZSA9ICJmc2wsaW14MzEtc2RtYSIsIC5kYXRhID0gJnNkbWFfaW14MzEsIH0s
DQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDI1LXNkbWEiLCAuZGF0YSA9ICZzZG1hX2lteDI1
LCB9LA0KKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg2c3gtc2RtYSIsIC5kYXRhID0gJnNkbWFf
aW14NnN4LCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg3ZC1zZG1hIiwgLmRhdGEgPSAm
c2RtYV9pbXg3ZCwgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnVsLXNkbWEiLCAuZGF0
YSA9ICZzZG1hX2lteDZ1bCwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXNkbWEi
LCAuZGF0YSA9ICZzZG1hX2lteDhtcSwgfSwNCiAJeyAvKiBzZW50aW5lbCAqLyB9DQogfTsNCkBA
IC0xMTY2LDggKzEyMDYsMTcgQEAgc3RhdGljIGludCBzZG1hX2NvbmZpZ19jaGFubmVsKHN0cnVj
dCBkbWFfY2hhbiAqY2hhbikNCiAJCQlpZiAoc2RtYWMtPnBlcmlwaGVyYWxfdHlwZSA9PSBJTVhf
RE1BVFlQRV9BU1JDX1NQIHx8DQogCQkJICAgIHNkbWFjLT5wZXJpcGhlcmFsX3R5cGUgPT0gSU1Y
X0RNQVRZUEVfQVNSQykNCiAJCQkJc2RtYV9zZXRfd2F0ZXJtYXJrbGV2ZWxfZm9yX3AycChzZG1h
Yyk7DQotCQl9IGVsc2UNCisJCX0gZWxzZSB7DQorCQkJLyoNCisJCQkgKiBFUlIwMDkxNjUgZml4
ZWQgZnJvbSBpLm14NnVsLCBubyBlcnJhdGEgbmVlZCwNCisJCQkgKiBzZXQgYml0MzEgdG8gbGV0
IHNkbWEgc2NyaXB0IHNraXAgdGhlIGVycmF0YS4NCisJCQkgKi8NCisJCQlpZiAoc2RtYWMtPnBl
cmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1BVFlQRV9DU1BJICYmDQorCQkJICAgIHNkbWFjLT5kaXJl
Y3Rpb24gPT0gRE1BX01FTV9UT19ERVYgJiYNCisJCQkgICAgc2RtYWMtPnNkbWEtPmRydmRhdGEt
PmVjc3BpX2ZpeGVkKQ0KKwkJCQlfX3NldF9iaXQoMzEsICZzZG1hYy0+d2F0ZXJtYXJrX2xldmVs
KTsNCiAJCQlfX3NldF9iaXQoc2RtYWMtPmV2ZW50X2lkMCwgc2RtYWMtPmV2ZW50X21hc2spOw0K
KwkJfQ0KIA0KIAkJLyogQWRkcmVzcyAqLw0KIAkJc2RtYWMtPnNocF9hZGRyID0gc2RtYWMtPnBl
cl9hZGRyZXNzOw0KLS0gDQoyLjcuNA0KDQo=

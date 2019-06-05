Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2E35541
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2019 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFEC3z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 22:29:55 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:43746
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbfFEC3z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jun 2019 22:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6qZGpI4QRBs3W02mzSiZc1GvSSv8/ZjCPUZaZjyAp4=;
 b=fN9xw8hSRnRF1OtFw4ULRBqi5Rer/6zI6isX+XCAN7pv1p5c+nL00ywauw5F9g+hB0ekDk1I6LJU4KMD6s3pe7FE6RLJAShW7PA6OGwz4U49sCJn+YRNsqImLxv3zTVG4lEXMLSHWYXOUKI1Ofc1ihheIG5aijn1SAO0EXsmm4o=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6622.eurprd04.prod.outlook.com (20.179.235.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 02:29:49 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a13e:6f61:e9e6:16d7]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a13e:6f61:e9e6:16d7%7]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 02:29:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 7/8] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Topic: [PATCH v3 7/8] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Index: AQHVFf3w64fBGh9CDU+v4q34sjQaM6aLeIYAgAFvu4A=
Date:   Wed, 5 Jun 2019 02:29:49 +0000
Message-ID: <1559730811.24019.18.camel@nxp.com>
References: <20190529090848.34350-1-yibin.gong@nxp.com>
         <20190529090848.34350-8-yibin.gong@nxp.com>
         <20190604123722.GF15118@vkoul-mobl>
In-Reply-To: <20190604123722.GF15118@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6c1cc3-bb8e-4a12-45e7-08d6e95daef4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6622;
x-ms-traffictypediagnostic: VE1PR04MB6622:
x-microsoft-antispam-prvs: <VE1PR04MB6622DEAC9561F3775D4A8C5489160@VE1PR04MB6622.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(73956011)(5640700003)(256004)(54906003)(66556008)(66946007)(53936002)(25786009)(6436002)(91956017)(76116006)(66446008)(66476007)(64756008)(11346002)(68736007)(446003)(316002)(6512007)(14444005)(478600001)(486006)(81166006)(1730700003)(14454004)(103116003)(66066001)(50226002)(8676002)(7736002)(4326008)(81156014)(8936002)(305945005)(2351001)(71200400001)(36756003)(71190400001)(3846002)(102836004)(6486002)(2616005)(6916009)(2501003)(6246003)(6116002)(229853002)(186003)(76176011)(86362001)(6506007)(7416002)(53546011)(99286004)(5660300002)(26005)(476003)(2906002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6622;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4HKLtxUqrWLLNHvSE39mT73CU3beFmD39OuYD4B/f50e7/bYR1hwzhAV6kgH0rLoVakFuecPTW2hPfNGnfQdv1DOBXVumsu42461the1IYBIc89geYq/PobfuhzilLXpAH/bmd9bAiHXu/GVnLl5q/J7E+afE6K2NAVQ9Kw4g5yRttOOQtosKFUKrdylJ7bqjrriQCBwdty1WI9MTRs07d/Lb8GRRfM2NGeQbJr/vMLIKEXA4GnegBpJ1x5tOtcGh8Z9JbJLInb7SAn0kdT+XJ2GG5MxCLyIBhdhm3rvmLTkne+iFUdGMzB/yUGQuAQqHRwHHn4nGlkJhexT3lxwaZSDw1zEr/vEYSnov0ty4oMAlm3oMQrIDwQAd4h2u86x5dc434W3pV18IbYoHO85449TcwGVCDjl5YcFMfkXcrQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCDB9CFC168A9744A7FADBCB85A023F5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6c1cc3-bb8e-4a12-45e7-08d6e95daef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 02:29:49.5118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6622
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNi0wNCBhdCAxMjozNyArMDAwMCwgVmlub2QgS291bCB3cm90ZToNCj4gT24gMjkt
MDUtMTksIDE3OjA4LCB5aWJpbi5nb25nQG54cC5jb20gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTog
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiA+IA0KPiA+IMKgIEFkZCBlZG1hMiBm
b3IgaS5teDd1bHAgYnkgdmVyc2lvbiB2Mywgc2luY2UgdjIgaGFzIGFscmVhZHkNCj4gV2h5IGxl
YWRpbmcgc3BhY2VzIGF0IHN0YXJ0IG9mIGxpbmU/DQpTb3JyeSBmb3IgdGhlIHR5cG8sIHdpbGwg
Zml4IGluIG5leHQgdmVyc2lvbg0KPiANCj4gPiANCj4gPiBiZWVuIHVzZWQgYnkgbWNmLWVkbWEu
DQo+ID4gVGhlIGJpZyBjaGFuZ2VzIGJhc2VkIG9uIHYxIGFyZSBiZWxvd3M6DQo+ID4gMS4gb25s
eSBvbmUgZG1hbXV4Lg0KPiA+IDIuIGFub3RoZXIgY2xvY2sgZG1hX2NsayBleGNlcHQgZG1hbXV4
IGNsay4NCj4gPiAzLiAxNiBpbmRlcGVuZGVudCBpbnRlcnJ1cHRzIGluc3RlYWQgb2Ygb25seSBv
bmUgaW50ZXJydXB0IGZvcg0KPiA+IGFsbCBjaGFubmVscy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2
ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYyB8IDE4ICsrKysrKysrKysrLQ0KPiA+IMKgZHJpdmVy
cy9kbWEvZnNsLWVkbWEtY29tbW9uLmggfMKgwqAzICsrDQo+ID4gwqBkcml2ZXJzL2RtYS9mc2wt
ZWRtYS5jwqDCoMKgwqDCoMKgwqDCoHwgNjcNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDg3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZnNs
LWVkbWEtY29tbW9uLmMgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS0NCj4gPiBjb21tb24uYw0KPiA+
IGluZGV4IDQ1ZDcwZDMuLjBkOTkxNWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9kbWEvZnNs
LWVkbWEtY29tbW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYw0K
PiA+IEBAIC05MCw2ICs5MCwxOSBAQCBzdGF0aWMgdm9pZCBtdXhfY29uZmlndXJlOChzdHJ1Y3Qg
ZnNsX2VkbWFfY2hhbg0KPiA+ICpmc2xfY2hhbiwgdm9pZCBfX2lvbWVtICphZGRyLA0KPiA+IMKg
CWlvd3JpdGU4KHZhbDgsIGFkZHIgKyBvZmYpOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gK3ZvaWQg
bXV4X2NvbmZpZ3VyZTMyKHN0cnVjdCBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbiwgdm9pZCBfX2lv
bWVtDQo+ID4gKmFkZHIsDQo+ID4gKwkJwqDCoMKgwqDCoHUzMiBvZmYsIHUzMiBzbG90LCBib29s
IGVuYWJsZSkNCj4gPiArew0KPiA+ICsJdTMyIHZhbDsNCj4gPiArDQo+ID4gKwlpZiAoZW5hYmxl
KQ0KPiA+ICsJCXZhbCA9IEVETUFNVVhfQ0hDRkdfRU5CTCA8PCAyNCB8IHNsb3Q7DQo+ID4gKwll
bHNlDQo+ID4gKwkJdmFsID0gRURNQU1VWF9DSENGR19ESVM7DQo+ID4gKw0KPiA+ICsJaW93cml0
ZTMyKHZhbCwgYWRkciArIG9mZiAqIDQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+IMKgdm9pZCBmc2xf
ZWRtYV9jaGFuX211eChzdHJ1Y3QgZnNsX2VkbWFfY2hhbiAqZnNsX2NoYW4sDQo+ID4gwqAJCQl1
bnNpZ25lZCBpbnQgc2xvdCwgYm9vbCBlbmFibGUpDQo+ID4gwqB7DQo+ID4gQEAgLTEwMiw3ICsx
MTUsMTAgQEAgdm9pZCBmc2xfZWRtYV9jaGFuX211eChzdHJ1Y3QgZnNsX2VkbWFfY2hhbg0KPiA+
ICpmc2xfY2hhbiwNCj4gPiDCoAltdXhhZGRyID0gZnNsX2NoYW4tPmVkbWEtPm11eGJhc2VbY2gg
LyBjaGFuc19wZXJfbXV4XTsNCj4gPiDCoAlzbG90ID0gRURNQU1VWF9DSENGR19TT1VSQ0Uoc2xv
dCk7DQo+ID4gwqANCj4gPiAtCW11eF9jb25maWd1cmU4KGZzbF9jaGFuLCBtdXhhZGRyLCBjaF9v
ZmYsIHNsb3QsIGVuYWJsZSk7DQo+ID4gKwlpZiAoZnNsX2NoYW4tPmVkbWEtPnZlcnNpb24gPT0g
djMpDQo+ID4gKwkJbXV4X2NvbmZpZ3VyZTMyKGZzbF9jaGFuLCBtdXhhZGRyLCBjaF9vZmYsIHNs
b3QsDQo+ID4gZW5hYmxlKTsNCj4gPiArCWVsc2UNCj4gPiArCQltdXhfY29uZmlndXJlOChmc2xf
Y2hhbiwgbXV4YWRkciwgY2hfb2ZmLCBzbG90LA0KPiA+IGVuYWJsZSk7DQo+ID4gwqB9DQo+ID4g
wqBFWFBPUlRfU1lNQk9MX0dQTChmc2xfZWRtYV9jaGFuX211eCk7DQo+ID4gwqANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmggYi9kcml2ZXJzL2RtYS9mc2wt
ZWRtYS0NCj4gPiBjb21tb24uaA0KPiA+IGluZGV4IDAxNGFiNzQuLjA3NDgyZDIgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmgNCj4gPiArKysgYi9kcml2ZXJz
L2RtYS9mc2wtZWRtYS1jb21tb24uaA0KPiA+IEBAIC0xMjUsNiArMTI1LDcgQEAgc3RydWN0IGZz
bF9lZG1hX2NoYW4gew0KPiA+IMKgCWRtYV9hZGRyX3QJCQlkbWFfZGV2X2FkZHI7DQo+ID4gwqAJ
dTMyCQkJCWRtYV9kZXZfc2l6ZTsNCj4gPiDCoAllbnVtIGRtYV9kYXRhX2RpcmVjdGlvbgkJZG1h
X2RpcjsNCj4gPiArCWNoYXIJCQkJY2hhbl9uYW1lWzE2XTsNCj4gPiDCoH07DQo+ID4gwqANCj4g
PiDCoHN0cnVjdCBmc2xfZWRtYV9kZXNjIHsNCj4gPiBAQCAtMTM5LDYgKzE0MCw3IEBAIHN0cnVj
dCBmc2xfZWRtYV9kZXNjIHsNCj4gPiDCoGVudW0gZWRtYV92ZXJzaW9uIHsNCj4gPiDCoAl2MSwg
LyogMzJjaCwgVnlicmlkLCBtcGM1N3gsIGV0YyAqLw0KPiA+IMKgCXYyLCAvKiA2NGNoIENvbGRm
aXJlICovDQo+ID4gKwl2MywgLyogMzJjaCwgaS5teDd1bHAgKi8NCj4gPiDCoH07DQo+ID4gwqAN
Cj4gPiDCoHN0cnVjdCBmc2xfZWRtYV9kcnZkYXRhIHsNCj4gPiBAQCAtMTU0LDYgKzE1Niw3IEBA
IHN0cnVjdCBmc2xfZWRtYV9lbmdpbmUgew0KPiA+IMKgCXZvaWQgX19pb21lbQkJKm1lbWJhc2U7
DQo+ID4gwqAJdm9pZCBfX2lvbWVtCQkqbXV4YmFzZVtETUFNVVhfTlJdOw0KPiA+IMKgCXN0cnVj
dCBjbGsJCSptdXhjbGtbRE1BTVVYX05SXTsNCj4gPiArCXN0cnVjdCBjbGsJCSpkbWFjbGs7DQo+
ID4gwqAJdTMyCQkJZG1hbXV4X25yOw0KPiA+IMKgCXN0cnVjdCBtdXRleAkJZnNsX2VkbWFfbXV0
ZXg7DQo+ID4gwqAJY29uc3Qgc3RydWN0IGZzbF9lZG1hX2RydmRhdGEgKmRydmRhdGE7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLmMgYi9kcml2ZXJzL2RtYS9mc2wtZWRt
YS5jDQo+ID4gaW5kZXggY2YxODMwMS4uNDViMjZkNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2RtYS9mc2wtZWRtYS5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvZnNsLWVkbWEuYw0KPiA+IEBA
IC0xNjUsNiArMTY1LDUxIEBAIGZzbF9lZG1hX2lycV9pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gPiAqcGRldiwgc3RydWN0IGZzbF9lZG1hX2VuZ2luZSAqZnNsX2VkbWENCj4gPiDCoAly
ZXR1cm4gMDsNCj4gPiDCoH0NCj4gPiDCoA0KPiA+ICtzdGF0aWMgaW50DQo+ID4gK2ZzbF9lZG1h
Ml9pcnFfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsJCcKgwqDCoHN0
cnVjdCBmc2xfZWRtYV9lbmdpbmUgKmZzbF9lZG1hKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gKwlpbnQgaSwgcmV0LCBpcnE7
DQo+ID4gKwlpbnQgY291bnQgPSAwOw0KPiBTdXBlcmZsb3VzIGluaXRpYWxpemF0aW9uIG9mIGNv
dW50IQ0KV291bGQgZml4IGl0IGluIHY0Lg0KPiANCj4gPiANCj4gPiArDQo+ID4gKwljb3VudCA9
IG9mX2lycV9jb3VudChucCk7DQo+ID4gKwlkZXZfaW5mbygmcGRldi0+ZGV2LCAiJXMgRm91bmQg
JWQgaW50ZXJydXB0c1xyXG4iLA0KPiA+IF9fZnVuY19fLCBjb3VudCk7DQo+IENvbnNpZGVyIHVz
aW5nIGRlYnVnIGxldmVsLi4NCldvdWxkIGRvd25ncmFkZSBwcmludCBsZXZlbCBpbiB2NC4NCj4g
DQo+ID4gDQo+ID4gKwlpZiAoY291bnQgPD0gMikgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRl
diwgIkludGVycnVwdHMgaW4gRFRTIG5vdA0KPiA+IGNvcnJlY3QuXG4iKTsNCj4gPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArCS8qDQo+ID4gKwnCoCogMTYgY2hhbm5lbCBpbmRl
cGVuZGVudCBpbnRlcnJ1cHRzICsgMSBlcnJvciBpbnRlcnJ1cHQNCj4gPiBvbiBpLm14N3VscC4N
Cj4gPiArCcKgKiAyIGNoYW5uZWwgc2hhcmUgb25lIGludGVycnVwdCwgZm9yIGV4YW1wbGUsIGNo
MC9jaDE2LA0KPiA+IGNoMS9jaDE3Li4uDQo+ID4gKwnCoCogRm9yIG5vdywganVzdCBzaW1wbHkg
cmVxdWVzdCBpcnEgd2l0aG91dCBJUlFGX1NIQVJFRA0KPiA+IGZsYWcsIHNpbmNlIDE2DQo+ID4g
KwnCoCogY2hhbm5lbHMgYXJlIGVub3VnaCBvbiBpLm14N3VscCB3aG9zZSBNNCBkb21haW4gb3du
DQo+ID4gc29tZSBwZXJpcGhlcmFscy4NCj4gPiArCcKgKi8NCj4gPiArCWZvciAoaSA9IDA7IGkg
PCBjb3VudDsgaSsrKSB7DQo+ID4gKwkJaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBpKTsN
Cj4gPiArCQlpZiAoaXJxIDwgMCkNCj4gPiArCQkJcmV0dXJuIC1FTlhJTzsNCj4gPiArDQo+ID4g
KwkJc3ByaW50Zihmc2xfZWRtYS0+Y2hhbnNbaV0uY2hhbl9uYW1lLCAiZURNQTItDQo+ID4gQ0gl
MDJkIiwgaSk7DQo+ID4gKw0KPiA+ICsJCS8qIFRoZSBsYXN0IElSUSBpcyBmb3IgZURNQSBlcnIg
Ki8NCj4gPiArCQlpZiAoaSA9PSBjb3VudCAtIDEpDQo+ID4gKwkJCXJldCA9IGRldm1fcmVxdWVz
dF9pcnEoJnBkZXYtPmRldiwgaXJxLA0KPiA+ICsJCQkJCQlmc2xfZWRtYV9lcnJfaGFuZGwNCj4g
PiBlciwNCj4gPiArCQkJCQkJMCwgImVETUEyLUVSUiIsDQo+ID4gZnNsX2VkbWEpOw0KPiA+ICsJ
CWVsc2UNCj4gPiArDQo+IGVtcHR5IGxpbmUgaXMgd2FzdGUgaGVyZQ0KPiANCj4gPiANCj4gPiAr
CQkJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnEsDQo+ID4gKwkJCQkJCWZz
bF9lZG1hX3R4X2hhbmRsZQ0KPiA+IHIsIDAsDQo+ID4gKwkJCQkJCWZzbF9lZG1hLQ0KPiA+ID5j
aGFuc1tpXS5jaGFuX25hbWUsDQo+ID4gKwkJCQkJCWZzbF9lZG1hKTsNCj4gPiArCQlpZiAocmV0
KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0K
PiA+ICt9DQo+ID4gKw0KPiA+IMKgc3RhdGljIHZvaWQgZnNsX2VkbWFfaXJxX2V4aXQoDQo+ID4g
wqAJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHN0cnVjdA0KPiA+IGZzbF9lZG1hX2Vu
Z2luZSAqZnNsX2VkbWEpDQo+ID4gwqB7DQo+ID4gQEAgLTE5MSw4ICsyMzYsMTYgQEAgc3RhdGlj
IHN0cnVjdCBmc2xfZWRtYV9kcnZkYXRhIHZmNjEwX2RhdGEgPSB7DQo+ID4gwqAJLnNldHVwX2ly
cSA9IGZzbF9lZG1hX2lycV9pbml0LA0KPiA+IMKgfTsNCj4gPiDCoA0KPiA+ICtzdGF0aWMgc3Ry
dWN0IGZzbF9lZG1hX2RydmRhdGEgaW14N3VscF9kYXRhID0gew0KPiA+ICsJLnZlcnNpb24gPSB2
MywNCj4gPiArCS5kbWFtdXhzID0gMSwNCj4gPiArCS5oYXNfZG1hY2xrID0gdHJ1ZSwNCj4gPiAr
CS5zZXR1cF9pcnEgPSBmc2xfZWRtYTJfaXJxX2luaXQsDQo+ID4gK307DQo+ID4gKw0KPiA+IMKg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZnNsX2VkbWFfZHRfaWRzW10gPSB7DQo+
ID4gwqAJeyAuY29tcGF0aWJsZSA9ICJmc2wsdmY2MTAtZWRtYSIsIC5kYXRhID0gJnZmNjEwX2Rh
dGF9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC1lZG1hIiwgLmRhdGEgPQ0K
PiA+ICZpbXg3dWxwX2RhdGF9LA0KPiA+IMKgCXsgLyogc2VudGluZWwgKi8gfQ0KPiA+IMKgfTsN
Cj4gPiDCoE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGZzbF9lZG1hX2R0X2lkcyk7DQo+ID4gQEAg
LTI0Miw2ICsyOTUsMjAgQEAgc3RhdGljIGludCBmc2xfZWRtYV9wcm9iZShzdHJ1Y3QNCj4gPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gwqAJZnNsX2VkbWFfc2V0dXBfcmVncyhmc2xfZWRt
YSk7DQo+ID4gwqAJcmVncyA9ICZmc2xfZWRtYS0+cmVnczsNCj4gPiDCoA0KPiA+ICsJaWYgKGRy
dmRhdGEtPmhhc19kbWFjbGspIHsNCj4gPiArCQlmc2xfZWRtYS0+ZG1hY2xrID0gZGV2bV9jbGtf
Z2V0KCZwZGV2LT5kZXYsDQo+ID4gImRtYSIpOw0KPiA+ICsJCWlmIChJU19FUlIoZnNsX2VkbWEt
PmRtYWNsaykpIHsNCj4gPiArCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiTWlzc2luZyBETUEgYmxv
Y2sNCj4gPiBjbG9jay5cbiIpOw0KPiA+ICsJCQlyZXR1cm4gUFRSX0VSUihmc2xfZWRtYS0+ZG1h
Y2xrKTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShm
c2xfZWRtYS0+ZG1hY2xrKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIkRNQSBjbGsgYmxvY2sNCj4gPiBmYWlsZWQuXG4iKTsNCj4gPiArCQkJcmV0dXJu
IHJldDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+IMKgCWZvciAoaSA9IDA7IGkgPCBm
c2xfZWRtYS0+ZG1hbXV4X25yOyBpKyspIHsNCj4gPiDCoAkJY2hhciBjbGtuYW1lWzMyXTsNCj4g
PiDCoA0KPiA+IC0twqANCj4gPiAyLjcuNA==

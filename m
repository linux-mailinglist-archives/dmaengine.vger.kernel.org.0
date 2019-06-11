Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B93C172
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 05:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbfFKDET (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 23:04:19 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:64830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390817AbfFKDET (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 23:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw5rB/4vZe6ey0+JDJ38/4Uc0xPPuou7Ty8heKvxXuE=;
 b=sNPgEYMmSkPtG75gxmeEB//KmLvYU0jTW/IGYx9jWfVW/OOke75/VM4iVHkOGanQRtKwjvsIZrBKCVGTf5JBioQaDR+gj+bT7zFqe6e+xzPqYJovUKncqHVaFh0TTyUFcFguDFCXE0yPn3GM0E3kwwDO7G/DcN2TOLp3hsPVPQM=
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (20.179.247.83) by
 AM6PR04MB4023.eurprd04.prod.outlook.com (52.135.161.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 03:04:12 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c066:9c0e:7eeb:f82c]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c066:9c0e:7eeb:f82c%7]) with mapi id 15.20.1965.011; Tue, 11 Jun 2019
 03:04:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 15/15] dmaengine: imx-sdma: add uart rom script
Thread-Topic: [PATCH v5 15/15] dmaengine: imx-sdma: add uart rom script
Thread-Index: AQHVH2TZ6KArzVJjCEKmpzk602iIRKaU2MsAgAF0OoA=
Date:   Tue, 11 Jun 2019 03:04:12 +0000
Message-ID: <1560251269.9731.41.camel@nxp.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
         <20190610081753.11422-16-yibin.gong@nxp.com>
         <20190610125534.GQ9160@vkoul-mobl.Dlink>
In-Reply-To: <20190610125534.GQ9160@vkoul-mobl.Dlink>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f67439f-20ad-45c8-69bd-08d6ee197b18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4023;
x-ms-traffictypediagnostic: AM6PR04MB4023:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR04MB4023A1D1ED7D02F38EB4DAC989ED0@AM6PR04MB4023.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(54906003)(76116006)(316002)(8936002)(91956017)(6916009)(76176011)(2351001)(26005)(186003)(66066001)(66476007)(99286004)(86362001)(53936002)(50226002)(102836004)(53546011)(6506007)(66946007)(73956011)(8676002)(1730700003)(66556008)(2501003)(5660300002)(64756008)(4326008)(6246003)(66446008)(25786009)(81156014)(81166006)(71190400001)(103116003)(71200400001)(68736007)(6486002)(229853002)(5640700003)(305945005)(2906002)(7416002)(7736002)(478600001)(966005)(6116002)(3846002)(6306002)(36756003)(476003)(6512007)(486006)(6436002)(256004)(2616005)(11346002)(14444005)(446003)(14454004)(45080400002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4023;H:AM6PR04MB6630.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F/8AzZDq+wCR1Fms+sS9NZa27f75aozbrJ7iGIVJxnvozhj9/KCa5eOJHQeKzZDilGRCrU93WSPbEpXxtkGAf6LnvXqdgscWaCJAiBUReUvtVQ99WhP/YwClnUHEAV8t3ztEfY1QbdkjZyZ9WCS+cOg4E5xJbXKpmWbtjOw7Zn9z5OWvgSawlhmehtMLf1UfJJnV0aia55Odh6RVjQ4PRqN7M6Frx7FPsYggJHqHTCs44mCpSdaf9Y4tuFfcP/rUENpeaFPeGfzVAMAb0jt97YqKDgPPLUTR79WzY1SHcxngomt6KgKIqnGJduzhJndTCmY0NP7xCDQ5kmjsynhrkScY+7RWUJcQUGS9c4jLTm1xS4bybw9REmclTwgk3WOFE4Ke7KrGyUffCmdiqmNv07YXGNVa+aRvbduxaVqUo3c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D7E76014612004390E68113066BA45F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67439f-20ad-45c8-69bd-08d6ee197b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 03:04:12.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4023
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNi0xMCBhdCAxMjo1NSArMDAwMCwgVmlub2QgS291bCB3cm90ZToNCj4gT24gMTAt
MDYtMTksIDE2OjE3LCB5aWJpbi5nb25nQG54cC5jb20gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTog
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiA+IA0KPiA+IEZvciB0aGUgY29tcGF0
aWJpbGl0eSBvZiBOWFAgaW50ZXJuYWwgbGVnYWN5IGtlcm5lbCBiZWZvcmUgNC4xOQ0KPiA+IHdo
aWNoDQo+ID4gaXMgYmFzZWQgb24gdWFydCByYW0gc2NyaXB0IGFuZCB1cHN0cmVhbWluZyBrZXJu
ZWwgYmFzZWQgb24gdWFydA0KPiA+IHJvbQ0KPiA+IHNjcmlwdCwgYWRkIGJvdGggdWFydCByYW0v
cm9tIHNjcmlwdCBpbiBsYXRlc3Qgc2RtYSBmaXJtd2FyZS4gQnkNCj4gPiBkZWZhdWx0DQo+ID4g
dWFydCByb20gc2NyaXB0IHVzZWQuDQo+ID4gQmVzaWRlcywgYWRkIHR3byBtdWx0aS1maWZvIHNj
cmlwdHMgZm9yIFNBSS9QRE0gb24gaS5teDhtLzhtbSBhbmQNCj4gPiBhZGQNCj4gPiBiYWNrIHFz
cGkgc2NyaXB0IG1pc3MgZm9yIHY0KGkubXg3ZC84bS84bW0gZmFtaWx5LCBidXQgdjMgaXMgZm9y
DQo+ID4gaS5teDYpLg0KPiA+IA0KPiA+IHJvbSBzY3JpcHQ6DQo+ID4gCXVhcnRfMl9tY3VfYWRk
cg0KPiA+IAl1YXJ0c2hfMl9tY3VfYWRkciAvKiB0aHJvdWdoIHNwYmEgYnVzICovDQo+ID4gcmFt
IHNjcmlwdDoNCj4gPiAJdWFydF8yX21jdV9yYW1fYWRkcg0KPiA+IAl1YXJ0c2hfMl9tY3VfcmFt
X2FkZHIgLyogdGhyb3VnaCBzcGJhIGJ1cyAqLw0KPiA+IA0KPiA+IFBsZWFzZSBnZXQgbGF0ZXN0
IHNkbWEgZmlybXdhcmUgZnJvbSB0aGUgYmVsb3cgYW5kIHB1dCB0aGVtIGludG8NCj4gPiB0aGUg
cGF0aA0KPiA+ICgvbGliL2Zpcm13YXJlL2lteC9zZG1hLyk6DQo+ID4gaHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZw0KPiA+
IGl0Lmtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRmZpcm13
YXJlJTJGbGludXgNCj4gPiAtZmlybXdhcmUuZ2l0JmFtcDtkYXRhPTAyJTdDMDElN0N5aWJpbi5n
b25nJTQwbnhwLmNvbSU3QzZhNzgzM2U4YTA5DQo+ID4gMzQ0ZDk5NTFlMDhkNmVkYTM1ZmM1JTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3Qw0KPiA+IDYzNjk1NzY4
MzI3ODE5MDI3OSZhbXA7c2RhdGE9UkhleXBFT1JFaVBHbUt2ZWc2Z1lQeSUyRk1nOER6ejRKcGNI
c20NCj4gPiAlMkJiZHhsem8lM0QmYW1wO3Jlc2VydmVkPTANCj4gPiAvdHJlZS9pbXgvc2RtYQ0K
PiBIb3cgZG9lcyB0aGlzIHdvcmsgd2l0aCBmb2xrcyBoYXZlIG9sZGVyIGZpcm13YXJlPw0KVGhl
IG9sZGVyIFNETUEgUkFNIHNjcmlwdChmaXJtd2FyZSkgd2lsbCBicmVhayB0aGUgdWFydCBkcml2
ZXIgb2YNCnVwc3RyZWFtaW5nIGtlcm5lbCBmb3IgdGhlc2UgeWVhcnMsIHRoaXMgaXMgd2h5IEx1
Y2FzIHJhaXNlIHVhcnQgZHJpdmVyDQpwYXRjaCAoY29tbWl0IDkwNWMwZGVjYWQyOCkgdG8gdXNl
IFJPTSBzY3JpcHQgaW5zdGVhZC4gVGhlcmUgYXJlIHR3bw0Kd2F5cyB0byBmaXggdWFydCBpc3N1
ZTogb25lIGlzIGNoZWNraW5nICdJZGxlIENvbmRpdGlvbg0KRGV0ZWN0aW9uJy8nQWdpbmcgdGlt
ZXInIGluIFJBTSBzY3JpcHQgYW5kIGVuYWJsZSAnSURMRScgaW4gdWFydA0KZHJpdmVyLCBhbm90
aGVyIGlzIG9ubHkgY2hlY2tpbmcgJ0FnaW5nIHRpbWVyJyBpbiBST00gc2NyaXB0IGFuZA0KYWRq
dXN0aW5nIFJYIEZJRk8gYnVyc3QgbGVuZ3RoIG9uZSB3b3JkIGxlc3MgdG8gZW5zdXJlIGF0IGxl
YXN0IG9uZQ0Kd29yZCBsZWZ0IGZvcmV2ZXIgaW4gUlggRklGTyB3aGljaCBpcyB0aGUgdHJpZ2dl
ciByZXF1aXJlbWVudCBvZiAnQWdpbmcNCnRpbWVyJyhTbyBubyBuZWVkICdJRExFJywgJ0FnaW5n
IHRpbWUnIGlzIGVub3VnaCkgLiBGU0wvTlhQIGludGVybmFsDQprZXJuZWwgZ28gd2l0aCB0aGUg
Zmlyc3Qgb3B0aW9uLCB3aGlsZSB1cHN0cmVhbWluZyBrZXJuZWwgZ28gd2l0aCB0aGUNCnNlY29u
ZC4gU2luY2UgTHVjYXMncyBwYXRjaCBhc3N1bWUgUk9NIHNjcmlwdCB1c2VkIGluIGtlcm5lbCBh
bmQNCmRpc2FibGUgJ0lETEUnLCB1cHN0cmVhbWluZyBrZXJuZWwgYnJva2VuIGluIHVhcnQgZHJp
dmVyIHdpdGggb2xkZXINCmZpcm13YXJlIGZvciB0aGVzZSB5ZWFycy4gU28gdGhpcyBwYXRjaCBp
cyBqdXN0IGZvciBmaXggdGhpcw0KY29tcGF0aWJpbGl0eSBpc3N1ZSB3aXRoIHRoZSByYW0gc2Ny
aXB0KG9sZGVyIGZpcm13YXJlKSB1cGRhdGVkIGluDQpsaW51eC1maXJtd2FyZShkb25lIGFscmVh
ZHkuKSwgdGh1cyBib3RoIFJBTSBzY3JpcHQgYW5kIFJPTSBzY3JpcHQgY2FuDQp3b3JrIGluIGtl
cm5lbC4gQmVzaWRlcywga2VybmVsIHdpdGggdGhlIGxhdGVzdCBSQU0gZmlybXdhcmUgYW5kIHRo
aXMNCnBhdGNoIHNldCBjYW4gd29ya2Fyb3VuZCBlY3NwaSBpc3N1ZSB3aXRob3V0IGFueSBmdW5j
dGlvbiBicmVhayB3aGljaA0KTHVjYXMgY29uY2VybmVkIGFib3V0Lg0KPiANCj4gPiANCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gwqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgfMKgwqA0ICsrLS0NCj4gPiDCoGluY2x1ZGUvbGludXgvcGxhdGZv
cm1fZGF0YS9kbWEtaW14LXNkbWEuaCB8IDEwICsrKysrKysrLS0NCj4gPiDCoDIgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4g
PiBpbmRleCBmN2MxNTBkLi5kZWVhOWFhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2lt
eC1zZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+ID4gQEAgLTE3MzMs
OCArMTczMyw4IEBAIHN0YXRpYyB2b2lkIHNkbWFfaXNzdWVfcGVuZGluZyhzdHJ1Y3QNCj4gPiBk
bWFfY2hhbiAqY2hhbikNCj4gPiDCoA0KPiA+IMKgI2RlZmluZSBTRE1BX1NDUklQVF9BRERSU19B
UlJBWV9TSVpFX1YxCTM0DQo+ID4gwqAjZGVmaW5lIFNETUFfU0NSSVBUX0FERFJTX0FSUkFZX1NJ
WkVfVjIJMzgNCj4gPiAtI2RlZmluZSBTRE1BX1NDUklQVF9BRERSU19BUlJBWV9TSVpFX1YzCTQx
DQo+ID4gLSNkZWZpbmUgU0RNQV9TQ1JJUFRfQUREUlNfQVJSQVlfU0laRV9WNAk0Mg0KPiA+ICsj
ZGVmaW5lIFNETUFfU0NSSVBUX0FERFJTX0FSUkFZX1NJWkVfVjMJNDUNCj4gPiArI2RlZmluZSBT
RE1BX1NDUklQVF9BRERSU19BUlJBWV9TSVpFX1Y0CTQ2DQo+ID4gwqANCj4gPiDCoHN0YXRpYyB2
b2lkIHNkbWFfYWRkX3NjcmlwdHMoc3RydWN0IHNkbWFfZW5naW5lICpzZG1hLA0KPiA+IMKgCQlj
b25zdCBzdHJ1Y3Qgc2RtYV9zY3JpcHRfc3RhcnRfYWRkcnMgKmFkZHIpDQo+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNkbWEuaA0KPiA+IGIvaW5j
bHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2RtYS5oDQo+ID4gaW5kZXggZjc5NGZl
ZS4uZTEyZDJlOCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEv
ZG1hLWlteC1zZG1hLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1h
LWlteC1zZG1hLmgNCj4gPiBAQCAtMjAsMTIgKzIwLDEyIEBAIHN0cnVjdCBzZG1hX3NjcmlwdF9z
dGFydF9hZGRycyB7DQo+ID4gwqAJczMyIHBlcl8yX2ZpcmlfYWRkcjsNCj4gPiDCoAlzMzIgbWN1
XzJfZmlyaV9hZGRyOw0KPiA+IMKgCXMzMiB1YXJ0XzJfcGVyX2FkZHI7DQo+ID4gLQlzMzIgdWFy
dF8yX21jdV9hZGRyOw0KPiA+ICsJczMyIHVhcnRfMl9tY3VfcmFtX2FkZHI7DQo+ID4gwqAJczMy
IHBlcl8yX2FwcF9hZGRyOw0KPiA+IMKgCXMzMiBtY3VfMl9hcHBfYWRkcjsNCj4gPiDCoAlzMzIg
cGVyXzJfcGVyX2FkZHI7DQo+ID4gwqAJczMyIHVhcnRzaF8yX3Blcl9hZGRyOw0KPiA+IC0JczMy
IHVhcnRzaF8yX21jdV9hZGRyOw0KPiA+ICsJczMyIHVhcnRzaF8yX21jdV9yYW1fYWRkcjsNCj4g
PiDCoAlzMzIgcGVyXzJfc2hwX2FkZHI7DQo+ID4gwqAJczMyIG1jdV8yX3NocF9hZGRyOw0KPiA+
IMKgCXMzMiBhdGFfMl9tY3VfYWRkcjsNCj4gPiBAQCAtNTIsNyArNTIsMTMgQEAgc3RydWN0IHNk
bWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHsNCj4gPiDCoAlzMzIgemNhbmZkXzJfbWN1X2FkZHI7DQo+
ID4gwqAJczMyIHpxc3BpXzJfbWN1X2FkZHI7DQo+ID4gwqAJczMyIG1jdV8yX2Vjc3BpX2FkZHI7
DQo+ID4gKwlzMzIgbWN1XzJfc2FpX2FkZHI7DQo+ID4gKwlzMzIgc2FpXzJfbWN1X2FkZHI7DQo+
ID4gKwlzMzIgdWFydF8yX21jdV9hZGRyOw0KPiA+ICsJczMyIHVhcnRzaF8yX21jdV9hZGRyOw0K
PiA+IMKgCS8qIEVuZCBvZiB2MyBhcnJheSAqLw0KPiA+ICsJczMyIG1jdV8yX3pxc3BpX2FkZHI7
DQo+ID4gKwkvKiBFbmQgb2YgdjQgYXJyYXkgKi8NCj4gPiDCoH07DQo+ID4gwqANCj4gPiDCoC8q
Kg0KPiA+IC0twqANCj4gPiAyLjcuNA==

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD22E4E22B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFUImy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 04:42:54 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:38051
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfFUImx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Jun 2019 04:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hoo+tm9VZ+sRD64Cd9rYL+QABUs8tsZzF/6horhT2Q=;
 b=n8B9g9nmRbZmp+0W8BmgxhdzO2UXzkaRKy5ReQwTG7fxBLlw+WxGjEVF5ifu7d07HNw42BCnwicDjXPy4gCSBvXsZTVag52QKxuAwrjdcumSP4xsAwz0SyzUBPj9j7zxGHL3DhTRN5hrwxs5NiK7Lu0EAW2cIPcofJcseRTHqQs=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6510.eurprd04.prod.outlook.com (20.179.233.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Fri, 21 Jun 2019 08:42:48 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 08:42:48 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v5 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHVH2TJLciVMMA/RkWvOa+lK6Q+X6amYm4A
Date:   Fri, 21 Jun 2019 08:42:48 +0000
Message-ID: <1561135476.7537.5.camel@nxp.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
In-Reply-To: <20190610081753.11422-1-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59a4f3f5-e79e-4562-9734-08d6f62470a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6510;
x-ms-traffictypediagnostic: VE1PR04MB6510:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VE1PR04MB65104A7ED2224C33A5B37F9089E70@VE1PR04MB6510.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(4326008)(66066001)(53546011)(25786009)(54906003)(76176011)(26005)(316002)(99286004)(2906002)(6246003)(53936002)(186003)(102836004)(6512007)(256004)(14444005)(7416002)(6486002)(229853002)(476003)(50226002)(2616005)(446003)(5660300002)(11346002)(305945005)(66446008)(2501003)(71190400001)(6436002)(71200400001)(66946007)(486006)(478600001)(6306002)(110136005)(68736007)(45080400002)(91956017)(76116006)(86362001)(6116002)(3846002)(8936002)(2201001)(103116003)(81166006)(81156014)(966005)(8676002)(36756003)(73956011)(14454004)(7736002)(66476007)(64756008)(66556008)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6510;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lwEaIYDm2uXmEf/qjdk2OjwG7g5XwDXbQzzy5/hETnwA2BVflCB/k0daaSwyMYmmVVkSUUfXgohb5IkGfxCtEhetwlAmG2B4zXKEThafh92pIktk3yAgtQhSLY06AIoodyT9mPv5D43OtNcz2tEtfInvRHnlG0npe8TuwTbT9rXZtQgCSMjXaRTbjxPO/gmASkf5hSHSNIsi/YpG4hGR79tIvLhcN3QHCeSydQFnQxk6juD0d7D3I1csS5bClCLg1vK6511gUggnQpmTHpn8TTKjf3Deqhmw6GgKwHlH4NAHvEg9WNTPh4zochOzJ3LXyNW/PiXskTntX4NHaSe5WwbCEvwxHdHTR8R8+8EYUccSc0eopiIrlpY7a6KpEmYHf+MuCe3XObOwTu3FyVEx2WirVhqK+6y3dC6zaS7ri7Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DD48EB19266B94CB45FA603ABACCE29@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a4f3f5-e79e-4562-9734-08d6f62470a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 08:42:48.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6510
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGVsbG8gU2hhd24vV2lsbCwNCsKgIERvIHlvdSBoYXZlIGNvbW1lbnRzIGZvciB0aGlzIFY1IHBh
dGNoIHNldD8gSSBnb3QgdGFncyBmcm9tIE1hcmssDQpWaW5vZCBhbmQgUm9iLg0KDQpPbiAyMDE5
LTA2LTEwIGF0IDA4OjE3ICswMDAwLCB5aWJpbi5nb25nQG54cC5jb20gd3JvdGU6DQo+IEZyb206
IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gDQo+IMKgIFRoZXJlIGlzIGVjc3Bp
IEVSUjAwOTE2NSBvbiBpLm14Ni83IHNvYyBmYW1pbHksIHdoaWNoIGNhdXNlIEZJRk8NCj4gdHJh
bnNmZXIgdG8gYmUgc2VuZCB0d2ljZSBpbiBETUEgbW9kZS4gUGxlYXNlIGdldCBtb3JlIGluZm9y
bWF0aW9uDQo+IGZyb206DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dw0KPiAubnhwLmNvbSUyRmRvY3MlMkZlbiUy
RmVycmF0YSUyRklNWDZEUUNFLnBkZiZhbXA7ZGF0YT0wMiU3QzAxJTdDeWliaW4NCj4gLmdvbmcl
NDBueHAuY29tJTdDNjdkM2U3OGZlNWVmNDQyOGIzYWYwOGQ2ZWQ3YmViNzQlN0M2ODZlYTFkM2Jj
MmI0YzZmDQo+IGE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNjk1NzUxMzgxNDk3MDQxMiZh
bXA7c2RhdGE9JTJGOXNickRFbUlwdQ0KPiBPYXpjSUFWcElyRUxaTUVqTzk0JTJCamVuN3dPT2xW
c1ZrJTNEJmFtcDtyZXNlcnZlZD0wLiBUaGUgd29ya2Fyb3VuZA0KPiBpcyBhZGRpbmcNCj4gbmV3
IHNkbWEgcmFtIHNjcmlwdCB3aGljaCB3b3JrcyBpbiBYQ0jCoMKgbW9kZSBhcyBQSU8gaW5zaWRl
IHNkbWENCj4gaW5zdGVhZA0KPiBvZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xE
JyBzaG91bGQgYmUgMC4gVGhlIGlzc3VlIHNob3VsZA0KPiBiZQ0KPiBleGlzdCBvbiBhbGwgbGVn
YWN5IGkubXg2Lzcgc29jIGZhbWlseSBiZWZvcmUgaS5teDZ1bC4NCj4gwqAgTlhQIGZpeCB0aGlz
IGRlc2lnbiBpc3N1ZSBmcm9tIGkubXg2dWwsIHNvIG5ld2VyIGNoaXBzIGluY2x1ZGluZw0KPiBp
Lm14NnVsLw0KPiA2dWxsLzZzbGwgZG8gbm90IG5lZWQgdGhpcyB3b3JrYXJvdWQgYW55bW9yZS4g
QWxsIG90aGVyIGkubXg2LzcvOA0KPiBjaGlwcw0KPiBzdGlsbCBuZWVkIHRoaXMgd29ya2Fyb3Vk
LiBUaGlzIHBhdGNoIHNldCBhZGQgbmV3ICdmc2wsaW14NnVsLWVjc3BpJw0KPiBmb3IgZWNzcGkg
ZHJpdmVyIGFuZCAnZWNzcGlfZml4ZWQnIGluIHNkbWEgZHJpdmVyIHRvIGNob29zZSBpZiBuZWVk
DQo+IGVycmF0YQ0KPiBvciBub3QuDQo+IMKgIFRoZSBmaXJzdCB0d28gcmV2ZXJ0ZWQgcGF0Y2hl
cyBzaG91bGQgYmUgdGhlIHNhbWUgaXNzdWUsIHRob3VnaCwgaXQNCj4gc2VlbXMgJ2ZpeGVkJyBi
eSBjaGFuZ2luZyB0byBvdGhlciBzaHAgc2NyaXB0LiBIb3BlIFNlYW4gb3IgU2FzY2hhDQo+IGNv
dWxkDQo+IGhhdmUgdGhlIGNoYW5jZSB0byB0ZXN0IHRoaXMgcGF0Y2ggc2V0IGlmIGNvdWxkIGZp
eCB0aGVpciBpc3N1ZXMuDQo+IMKgIEJlc2lkZXMsIGVuYWJsZSBzZG1hIHN1cHBvcnQgZm9yIGku
bXg4bW0vOG1xIGFuZCBmaXggZWNzcGkxIG5vdA0KPiB3b3JrDQo+IG9uIGkubXg4bW0gYmVjYXVz
ZSB0aGUgZXZlbnQgaWQgaXMgemVyby4NCj4gDQo+IFBTOg0KPiDCoMKgwqBQbGVhc2UgZ2V0IHNk
bWEgZmlybXdhcmUgZnJvbSBiZWxvdyBsaW51eC1maXJtd2FyZSBhbmQgY29weSBpdCB0bw0KPiB5
b3VyDQo+IGxvY2FsIHJvb3RmcyAvbGliL2Zpcm13YXJlL2lteC9zZG1hLg0KPiBodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZn
aXQNCj4gLmtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRmZp
cm13YXJlJTJGbGludXgtDQo+IGZpcm13YXJlLmdpdCUyRnRyZWUlMkZpbXglMkZzZG1hJmFtcDtk
YXRhPTAyJTdDMDElN0N5aWJpbi5nb25nJTQwbnhwLg0KPiBjb20lN0M2N2QzZTc4ZmU1ZWY0NDI4
YjNhZjA4ZDZlZDdiZWI3NCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzANCj4gMTYzNSU3
QzAlN0MxJTdDNjM2OTU3NTEzODE0OTcwNDEyJmFtcDtzZGF0YT14WEhCV3BTYVNMbU1vc2IlMkZh
ak9BaVhuDQo+IG5reGFZVjZIQ3QyNU9PemdSTGJJJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiB2
MjoNCj4gwqAgMS5BZGQgY29tbWl0IGxvZyBmb3IgcmV2ZXJ0ZWQgcGF0Y2hlcy4NCj4gwqAgMi5B
ZGQgY29tbWVudCBmb3IgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZlci4NCj4gwqAgMy5BZGQg
J2ZzbCxpbXg2c2xsLWVjc3BpJyBjb21wYXRpYmxlIGluc3RlYWQgb2YgJ2ZzbCxpbXg2dWwtZWNz
cGknDQo+IMKgwqDCoMKgcmF0aGVyIHRoYW4gcmVtb3ZlLg0KPiB2MzoNCj4gwqAgMS5Db25maXJt
IHdpdGggZGVzaWduIHRlYW0gbWFrZSBzdXJlIEVSUjAwOTE2NSBmaXhlZCBvbg0KPiBpLm14NnVs
L2kubXg2dWxsDQo+IMKgwqDCoMKgL2kubXg2c2xsLCBub3QgZml4ZWQgb24gaS5teDhtLzhtbSBh
bmQgb3RoZXIgaS5teDYvNyBsZWdhY3kNCj4gY2hpcHMuDQo+IMKgwqDCoMKgQ29ycmVjdCBkdHMg
cmVsYXRlZCBkdHMgcGF0Y2ggaW4gdjIuDQo+IMKgIDIuQ2xlYW4gZXJhdHRhIGluZm9ybWF0aW9u
IGluIGJpbmRpbmcgZG9jIGFuZCBuZXcgJ3R4X2dsaXRjaF9maXhlZCcNCj4gZmxhZw0KPiDCoMKg
wqDCoGluIHNwaS1pbXggZHJpdmVyIHRvIHN0YXRlIEVSUjAwOTE2NSBmaXhlZCBvciBub3QuDQo+
IMKgIDMuRW5sYXJnZSBidXJzdCBzaXplIHRvIGZpZm8gc2l6ZSBmb3IgdHggc2luY2UgdHhfd21s
IHNldCB0byAwIGluDQo+IHRoZQ0KPiDCoMKgwqDCoGVycmF0YSB3b3JrYXJvdWQsIHRodXMgaW1w
cm92ZSBwZXJmb3JtYW5jZSBhcyBwb3NzaWJsZS4NCj4gdjQ6DQo+IMKgIDEuYWRkIEFjayB0YWcg
ZnJvbSBNYXJrIGFuZCBWaW5vZA0KPiDCoCAyLiByZW1vdmUgY2hlY2tpbmcgJ2V2ZW50X2lkMScg
emVybyBhcyAnZXZlbnRfaWQwJy4NCj4gdjU6DQo+IMKgIDEuQWRkIGFub3RoZXIgcGF0Y2ggZm9y
IGNvbXBhdGlibGUgd2l0aCB0aGUgY3VycmVudCB1YXJ0IGRyaXZlcg0KPiB3aGljaA0KPiDCoMKg
wqDCoHVzaW5nIHJvbSBzY3JpcHQsIHNvIGJvdGggdWFydCByYW0gc2NyaXB0IGFuZCByb20gc2Ny
aXB0DQo+IHN1cHBvcnRlZA0KPiDCoMKgwqDCoGluIGxhdGVzdCBmaXJtd2FyZSwgYnkgZGVmYXVs
dCB1YXJ0IHJvbSBzY3JpcHQgdXNlZC4gVUFSVCBkcml2ZXINCj4gwqDCoMKgwqB3aWxsIGJlIGJy
b2tlbiB3aXRob3V0IHRoaXMgcGF0Y2guIExhdGVzdCBzZG1hIGZpcm13YXJlIGhhcyBiZWVuDQo+
IMKgwqDCoMKgYWxyZWFkeSB1cGRhdGVkIGluIGxpbnV4LWZpcm13YXJlLsKgDQo+IA0KPiBSb2Jp
biBHb25nICgxNSk6DQo+IMKgIFJldmVydCAiQVJNOiBkdHM6IGlteDZxOiBVc2UgY29ycmVjdCBT
RE1BIHNjcmlwdCBmb3IgU1BJNSBjb3JlIg0KPiDCoCBSZXZlcnQgIkFSTTogZHRzOiBpbXg2OiBV
c2UgY29ycmVjdCBTRE1BIHNjcmlwdCBmb3IgU1BJIGNvcmVzIg0KPiDCoCBSZXZlcnQgImRtYWVu
Z2luZTogaW14LXNkbWE6IHJlZmluZSB0byBsb2FkIGNvbnRleHQgb25seSBvbmNlIg0KPiDCoCBk
bWFlbmdpbmU6IGlteC1zZG1hOiByZW1vdmUgZHVwaWxpY2F0ZWQgc2RtYV9sb2FkX2NvbnRleHQN
Cj4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogYWRkIG1jdV8yX2Vjc3BpIHNjcmlwdA0KPiDCoCBz
cGk6IGlteDogZml4IEVSUjAwOTE2NQ0KPiDCoCBzcGk6IGlteDogcmVtb3ZlIEVSUjAwOTE2NSB3
b3JrYXJvdW5kIG9uIGkubXg2dWwNCj4gwqAgc3BpOiBpbXg6IGFkZCBuZXcgaS5teDZ1bCBjb21w
YXRpYmxlIG5hbWUgaW4gYmluZGluZyBkb2MNCj4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogcmVt
b3ZlIEVSUjAwOTE2NSBvbiBpLm14NnVsDQo+IMKgIGRtYTogaW14LXNkbWE6IGFkZCBpLm14NnVs
LzZzeCBjb21wYXRpYmxlIG5hbWUNCj4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogZml4IGVjc3Bp
MSByeCBkbWEgbm90IHdvcmsgb24gaS5teDhtbQ0KPiDCoCBBUk06IGR0czogaW14NnVsOiBhZGQg
ZG1hIHN1cHBvcnQgb24gZWNzcGkNCj4gwqAgQVJNOiBkdHM6IGlteDZzbGw6IGNvcnJlY3Qgc2Rt
YSBjb21wYXRpYmxlDQo+IMKgIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBTRE1BIG9uIGkubXg4
bXEvOG1tDQo+IMKgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCB1YXJ0IHJvbSBzY3JpcHQNCj4g
DQo+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHTCoMKgwqDC
oMKgwqDCoHzCoMKgMiArDQo+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgt
Y3NwaS50eHTCoMKgwqDCoMKgwqDCoHzCoMKgMSArDQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnEuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDC
oDIgKy0NCj4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2nCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDggKy0NCj4gwqBhcmNoL2FybS9ib290L2R0
cy9pbXg2c2xsLmR0c2nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8
wqDCoDIgKy0NCj4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzacKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqA4ICsrDQo+IMKgYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB8wqDCoDMgKw0KPiDCoGRyaXZlcnMvZG1hL2lteC1zZG1hLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCA4OA0KPiArKysrKysr
KysrKysrKysrLS0tLS0tDQo+IMKgZHJpdmVycy9zcGkvc3BpLWlteC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCA2MQ0KPiArKysr
KysrKysrKystLS0NCj4gwqBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1h
LmjCoMKgwqDCoMKgwqDCoMKgwqB8IDExICsrLQ0KPiDCoDEwIGZpbGVzIGNoYW5nZWQsIDE0NSBp
bnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSkNCj4g

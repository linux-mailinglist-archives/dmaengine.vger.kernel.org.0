Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9F21693
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2019 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfEQJzH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 May 2019 05:55:07 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:50309
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbfEQJzG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 May 2019 05:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBtKDo4K3fjrrQQDnUN4wLSnnBckF45qEfyMsdqOG9k=;
 b=pJax3FNOvuifM+bNbyl6gibRL4MNZQyrzPZtmYWuOodONbF6c15vCj/C3Jw/F1bdwnJVbOEX8gXoJ/z1iA3JVYXrdY4SjnhvJR1IyBwtDVTAVL9K+kwmY2N27Gsi0H1E6JTqXuNf1C8g1di3U0TcjBWf3SyX0k1mmKMySIIXqak=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4847.eurprd04.prod.outlook.com (20.177.49.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 09:54:57 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::d85b:d2:194c:2b94%4]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 09:54:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v3 00/14] add ecspi ERR009165 for i.mx6/7 soc
 family
Thread-Topic: [EXT] Re: [PATCH v3 00/14] add ecspi ERR009165 for i.mx6/7 soc
 family
Thread-Index: AQHVBLVtTlA9AoCGPEiNrQoWVi6lD6Zo098AgAbXFQA=
Date:   Fri, 17 May 2019 09:54:55 +0000
Message-ID: <1558115932.2569.7.camel@nxp.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
         <1557739890.3997.1.camel@pengutronix.de>
In-Reply-To: <1557739890.3997.1.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c0498e1-5acd-46ad-29ee-08d6daadb81d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4847;
x-ms-traffictypediagnostic: VI1PR04MB4847:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB484716448C0BA1AAE97DA13E890B0@VI1PR04MB4847.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(189003)(199004)(66946007)(110136005)(478600001)(73956011)(8936002)(6486002)(6116002)(2906002)(66556008)(66476007)(64756008)(54906003)(45080400002)(229853002)(7416002)(3846002)(6512007)(50226002)(66066001)(2201001)(5660300002)(71190400001)(71200400001)(2501003)(6436002)(966005)(86362001)(6306002)(14454004)(66446008)(7736002)(36756003)(91956017)(446003)(2616005)(11346002)(14444005)(102836004)(6506007)(476003)(99286004)(186003)(305945005)(26005)(81156014)(81166006)(76116006)(486006)(103116003)(256004)(53546011)(8676002)(4326008)(53936002)(6246003)(316002)(76176011)(68736007)(25786009)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4847;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uuOjGTHZb/ROCHg9oi5P5qEzwxJpBFcD/lBugn8qc0A6A7g/O0iSrrw4q2eGh/cJveV6FskPiV0+kTGZs1WTY9JOWGlzRtAcZHpF1o+RxYBFPYRb+75Q2eNxAOSUsltD2Crz+UPrbHzA5SOHNAopv5kmGuD1djeRIXZJzqogeKD4A1+VD5e5vk5n+GBFFw7jj7XepecAVkjz3HfqaVHrty/sGcBRSy8xNr4ELYmBjOlKDEedCwNe0oe62rcudc4URDV3jCsnRoscCm+kRLeDMHz4bYSjFRSra982W2SwUgHpnQNzQK50/bdPPONQ34DLyK2KR392XXMjp2D5GxWajc2OZxJdUlWU5WKMxzD98goTL8a9Ubt8tX5e5ufz18nFzhr16ZhEWReAoB53FXgqg5mt+cQzwOoFGPJ+pdDvoU0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF094952BA67E6458AFB211805B746ED@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0498e1-5acd-46ad-29ee-08d6daadb81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 09:54:57.1209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4847
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNS0xMyBhdCAwOTozMSArMDAwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+IFBTOg0K
PiA+IMKgIFBsZWFzZSBnZXQgc2RtYSBmaXJtd2FyZSBmcm9tIGJlbG93IGxpbnV4LWZpcm13YXJl
IGFuZCBjb3B5IGl0IHRvDQo+ID4geW91cg0KPiA+IGxvY2FsIHJvb3RmcyAvbGliL2Zpcm13YXJl
L2lteC9zZG1hLg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmcNCj4gPiBpdC5rZXJuZWwub3JnJTJGcHViJTJGc2Nt
JTJGbGludXglMkZrZXJuZWwlMkZnaXQlMkZmaXJtd2FyZSUyRmxpbnV4DQo+ID4gLWZpcm13YXJl
LmdpdCUyRnRyZWUlMkZpbXglMkZzZG1hJmFtcDtkYXRhPTAyJTdDMDElN0N5aWJpbi5nb25nJTQw
bg0KPiA+IHhwLmNvbSU3QzU3ZWIzMGMwM2M5MzQ1ZTJjMjdlMDhkNmQ3ODVjY2EzJTdDNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTkNCj4gPiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjkzMzM2Njk5NTY5
MjQzMCZhbXA7c2RhdGE9d0xLYTJxd2tJTWxOJTJCZWVEDQo+ID4gNExPR0UlMkZ0SUZ6dkdLWHlJ
aG9aNEZla3I0dkklM0QmYW1wO3Jlc2VydmVkPTANCj4gVGhpcyBzZXJpZXMgaXMgdW5maXQgZm9y
IG1lcmdpbmcsIGFzIGxvbmcgYXMgaXQgZGVwZW5kcyBvbiBhIFNETUEgUkFNDQo+IHNjcmlwdCB0
aGF0IGlzIGtub3duIHRvIGJyZWFrIHNlcmlhbCBETUEuIFdoZW4gY2FuIHdlIGV4cGVjdCB0byBn
ZXQgYQ0KPiBmaXJtd2FyZSB2ZXJzaW9uIHdpdGggdGhlIGJyb2tlbiBzZXJpYWwgc2NyaXB0IHJl
bW92ZWQgb3V0IGludG8gdGhlDQo+IHB1YmxpYz8NCkhpIEx1Y2FzLA0KwqAgSSB3YW50IHRvIHNl
bnQgYW5vdGhlciBwYXRjaCBmb3IgZml4aW5nIFVBUlQgZmFpbHVyZSBvbiByYW0gc2NyaXB0DQps
YXRlciBhZnRlciB0aGlzIGVjc3BpIHBhdGNoIHNldCBhY2NlcHRlZC4gQnV0IG5vdyBJJ20gc3Rp
bGwgd2FpdGluZw0KZm9yIGFjayBmcm9tIFZpbm9kIHdobyBpcyBvd25lciBvZiBkbWFlbmdpbmUu
DQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiANCj4gPiB2MjoNCj4gPiDCoCAxLiBh
ZGQgY29tbWl0IGxvZyBmb3IgcmV2ZXJ0ZWQgcGF0Y2hlcy4NCj4gPiDCoCAyLiBhZGQgY29tbWVu
dCBmb3IgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZlci4NCj4gPiDCoCAzLiBhZGQgJ2ZzbCxp
bXg2c2xsLWVjc3BpJyBjb21wYXRpYmxlIGluc3RlYWQgb2YgJ2ZzbCxpbXg2dWwtDQo+ID4gZWNz
cGknDQo+ID4gwqDCoMKgwqDCoHJhdGhlciB0aGFuIHJlbW92ZS4NCj4gPiB2MzoNCj4gPiDCoCAx
LiBjb25maXJtIHdpdGggZGVzaWduIHRlYW0gbWFrZSBzdXJlIEVSUjAwOTE2NSBmaXhlZCBvbg0K
PiA+IGkubXg2dWwvaS5teDZ1bGwNCj4gPiDCoCAvaS5teDZzbGwsIG5vdCBmaXhlZCBvbiBpLm14
OG0vOG1tIGFuZCBvdGhlciBpLm14Ni83IGxlZ2FjeQ0KPiA+IGNoaXBzLg0KPiA+IMKgIENvcnJl
Y3QgZHRzIHJlbGF0ZWQgZHRzIHBhdGNoIGluIHYyLg0KPiA+IMKgIDIuIGNsZWFuIGVyYXR0YSBp
bmZvcm1hdGlvbiBpbiBiaW5kaW5nIGRvYyBhbmQgbmV3DQo+ID4gJ3R4X2dsaXRjaF9maXhlZCcg
ZmxhZw0KPiA+IMKgIGluIHNwaS1pbXggZHJpdmVyIHRvIHN0YXRlIEVSUjAwOTE2NSBmaXhlZCBv
ciBub3QuDQo+ID4gwqAgMy4gRW5sYXJnZSBidXJzdCBzaXplIHRvIGZpZm8gc2l6ZSBmb3IgdHgg
c2luY2UgdHhfd21sIHNldCB0byAwDQo+ID4gaW4gdGhlDQo+ID4gwqAgZXJyYXRhIHdvcmthcm91
ZCwgdGh1cyBpbXByb3ZlIHBlcmZvcm1hbmNlIGFzIHBvc3NpYmxlLg0KPiA+IA0KPiA+IFJvYmlu
IEdvbmcgKDE0KToNCj4gPiDCoCBSZXZlcnQgIkFSTTogZHRzOiBpbXg2cTogVXNlIGNvcnJlY3Qg
U0RNQSBzY3JpcHQgZm9yIFNQSTUgY29yZSINCj4gPiDCoCBSZXZlcnQgIkFSTTogZHRzOiBpbXg2
OiBVc2UgY29ycmVjdCBTRE1BIHNjcmlwdCBmb3IgU1BJIGNvcmVzIg0KPiA+IMKgIFJldmVydCAi
ZG1hZW5naW5lOiBpbXgtc2RtYTogcmVmaW5lIHRvIGxvYWQgY29udGV4dCBvbmx5IG9uY2UiDQo+
ID4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogcmVtb3ZlIGR1cGlsaWNhdGVkIHNkbWFfbG9hZF9j
b250ZXh0DQo+ID4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogYWRkIG1jdV8yX2Vjc3BpIHNjcmlw
dA0KPiA+IMKgIHNwaTogaW14OiBmaXggRVJSMDA5MTY1DQo+ID4gwqAgc3BpOiBpbXg6IHJlbW92
ZSBFUlIwMDkxNjUgd29ya2Fyb3VuZCBvbiBpLm14NnVsDQo+ID4gwqAgZHQtYmluZGluZ3M6IHNw
aTogaW14OiBhZGQgbmV3IGkubXg2dWwgY29tcGF0aWJsZSBuYW1lDQo+ID4gwqAgZG1hZW5naW5l
OiBpbXgtc2RtYTogcmVtb3ZlIEVSUjAwOTE2NSBvbiBpLm14NnVsDQo+ID4gwqAgZHQtYmluZGlu
Z3M6IGRtYTogaW14LXNkbWE6IGFkZCBpLm14NnVsLzZzeCBjb21wYXRpYmxlIG5hbWUNCj4gPiDC
oCBkbWFlbmdpbmU6IGlteC1zZG1hOiBmaXggZWNzcGkxIHJ4IGRtYSBub3Qgd29yayBvbiBpLm14
OG1tDQo+ID4gwqAgQVJNOiBkdHM6IGlteDZ1bDogYWRkIGRtYSBzdXBwb3J0IG9uIGVjc3BpDQo+
ID4gwqAgQVJNOiBkdHM6IGlteDZzbGw6IGNvcnJlY3Qgc2RtYSBjb21wYXRpYmxlDQo+ID4gwqAg
YXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIFNETUEgb24gaS5teDhtcS84bW0NCj4gPiANCj4gPiDC
oC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0wqDCoMKgwqDCoMKg
wqB8wqDCoDIgKw0KPiA+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3Nw
aS50eHTCoMKgwqDCoMKgwqDCoHzCoMKgMSArDQo+ID4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg2
cS5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKg
MiArLQ0KPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqA4ICstLQ0KPiA+IMKgYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnNsbC5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfMKgwqAyICstDQo+ID4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzacKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqA4ICsrKw0KPiA+IMKgYXJj
aC9hcm02NC9jb25maWdzL2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB8wqDCoDMgKw0KPiA+IMKgZHJpdmVycy9kbWEvaW14LXNkbWEuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IDc4
DQo+ID4gKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+IMKgZHJpdmVycy9zcGkvc3BpLWlteC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfCA2MQ0KPiA+ICsrKysrKysrKysrKysrLS0tDQo+ID4gwqBpbmNsdWRlL2xpbnV4L3BsYXRm
b3JtX2RhdGEvZG1hLWlteC1zZG1hLmjCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDEgKw0KPiA+IMKg
MTAgZmlsZXMgY2hhbmdlZCwgMTMyIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPiA=

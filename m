Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1CD52603
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 10:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfFYIGE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 04:06:04 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:11637
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727853AbfFYIGD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 04:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2LUMeCQ+J9dr+fINbQsTEmlTXqTkl7cFZWGDiKW1Qc=;
 b=JsQ+f4/qo07JHz7Yu0naN9QNBjbjfNBeNV0b5PLfx47pU5+iupBeJftKuQQ9WOkSyq3l9lCKwDbrK3CQfRaRV/8VPZZSeL3jc/SBiDaqO6nTyVk29zmLsi7Cs+f8/p5W8va0v4K8XwWmUn9bWj4jv6PQwUiTsuTrEoGrvXQH3tc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6381.eurprd04.prod.outlook.com (20.179.232.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 08:05:58 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 08:05:58 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v5 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHVH2TJLciVMMA/RkWvOa+lK6Q+X6amYm4AgAOi/oCAAg2asA==
Date:   Tue, 25 Jun 2019 08:05:58 +0000
Message-ID: <VE1PR04MB6638F8B75E96F4A04BBC4CEE89E30@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <1561135476.7537.5.camel@nxp.com> <20190624001643.GB3800@dragon>
In-Reply-To: <20190624001643.GB3800@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01069c00-9654-4b15-38d1-08d6f943f4bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6381;
x-ms-traffictypediagnostic: VE1PR04MB6381:
x-microsoft-antispam-prvs: <VE1PR04MB638138669A14A8A0569AB9A689E30@VE1PR04MB6381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(189003)(199004)(13464003)(33656002)(6436002)(25786009)(55016002)(9686003)(305945005)(53936002)(6116002)(3846002)(54906003)(6306002)(4326008)(316002)(486006)(478600001)(446003)(71200400001)(229853002)(71190400001)(476003)(68736007)(66446008)(64756008)(81156014)(76176011)(53546011)(256004)(7696005)(66476007)(66066001)(66946007)(5660300002)(73956011)(11346002)(81166006)(76116006)(99286004)(8676002)(6506007)(14444005)(7736002)(74316002)(66556008)(8936002)(52536014)(14454004)(26005)(186003)(86362001)(6916009)(6246003)(2906002)(102836004)(966005)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6381;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1vL9o+BkucvazL8NzhxzHOoZl5w3tqbe3J8k3O1J/OS30CliOzhbQgkAWn4VovW5hYAYLkpCo7nMEhe3mtPrX4YodmO77r9Q+ReAy407lThDwgqbC85hOgYuLsAcf7coJaf95ABCa+oSzTIGr6yfD5+qYfbBMS/sFEXxcQ+bzKVyqKjpRBwwUAuHtPq9dPRlsSurZGu5084f/ilsA1NUntzv4qArK05k2ymmFlpxrgCbf/4A8OSaETNnKB3A82Yo65XJYvA93RzJtTKiIeynigf00zMM7TLdeJOqfWZQZ79y97eOgyIAtyiXoB80+5ADGq39C/mGel25xKZ0ggGTieADxC2whVtpNaHq46NcMfl/8b/46VHKvOvVkZr05e4I2Gc0tCm5zC5HLrq+aFNQShLr+ClTIb1ZXa8TB+hmJr0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01069c00-9654-4b15-38d1-08d6f943f4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 08:05:58.2370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6381
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhhbmtzIFNoYXduLiBJZiBubyBjb21tZW50IGhlcmUsIEkgdGhpbmsgeW91IGNhbiBtZXJnZSBk
dHMgcGF0Y2ggZmlyc3RseSBpbiB5b3VyIHRyZWUgc2luY2UNCnRob3NlIGR0cyBwYXRjaGVzIGFy
ZSBoYXJtbGVzcywgTWFyayBhbmQgVmlub2Qgd291bGQgbWVyZ2UgU1BJL0RNQSBwYXRjaGVzIGlu
dG8NCnRoZWlyIHRyZWVzPyBIb3BlIGlteC9zcGkvZG1hZW5naW4gdHJlZXMgY291bGQgbWVyZ2Ug
aW50byB0aGUgc2FtZSByYyBvbiBsaW51eC1uZXh0LCBvdGhlcndpc2UNClNQSSBmdW5jdGlvbiBt
YXliZSBicm9rZW4uDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNoYXdu
IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOeW5tDbmnIgyNOaXpSA4OjE3
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDAvMTVdIGFkZCBlY3NwaSBFUlIwMDkxNjUgZm9y
IGkubXg2Lzcgc29jIGZhbWlseQ0KPiANCj4gT24gRnJpLCBKdW4gMjEsIDIwMTkgYXQgMDg6NDI6
NDhBTSArMDAwMCwgUm9iaW4gR29uZyB3cm90ZToNCj4gPiBIZWxsbyBTaGF3bi9XaWxsLA0KPiA+
IMKgIERvIHlvdSBoYXZlIGNvbW1lbnRzIGZvciB0aGlzIFY1IHBhdGNoIHNldD8gSSBnb3QgdGFn
cyBmcm9tIE1hcmssDQo+ID4gVmlub2QgYW5kIFJvYi4NCj4gDQo+IEknbSBmaW5lIHdpdGggdGhl
IERUUyBjaGFuZ2UsIGJ1dCBub3Qgc3VyZSBob3cgdGhlIHNlcmllcyBzaG91bGQgYmUgbWVyZ2Vk
Lg0KPiANCj4gU2hhd24NCj4gDQo+ID4NCj4gPiBPbiAyMDE5LTA2LTEwIGF0IDA4OjE3ICswMDAw
LCB5aWJpbi5nb25nQG54cC5jb20gd3JvdGU6DQo+ID4gPiBGcm9tOiBSb2JpbiBHb25nIDx5aWJp
bi5nb25nQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gwqAgVGhlcmUgaXMgZWNzcGkgRVJSMDA5MTY1
IG9uIGkubXg2Lzcgc29jIGZhbWlseSwgd2hpY2ggY2F1c2UgRklGTw0KPiA+ID4gdHJhbnNmZXIg
dG8gYmUgc2VuZCB0d2ljZSBpbiBETUEgbW9kZS4gUGxlYXNlIGdldCBtb3JlIGluZm9ybWF0aW9u
DQo+ID4gPiBmcm9tOg0KPiA+ID4gaHR0cHM6Ly93d3cNCj4gPiA+IC5ueHAuY29tJTJGZG9jcyUy
RmVuJTJGZXJyYXRhJTJGSU1YNkRRQ0UucGRmJmFtcDtkYXRhPTAyJTdDMDENCj4gJTdDeWliaQ0K
PiA+ID4gbg0KPiA+ID4gLmdvbmclNDBueHAuY29tJTdDNjdkM2U3OGZlNWVmNDQyOGIzYWYwOGQ2
ZWQ3YmViNzQlN0M2ODZlYTFkDQo+IDNiYzJiNGM2DQo+ID4gPiBmDQo+ID4gPg0KPiBhOTJjZDk5
YzVjMzAxNjM1JTdDMCU3QzElN0M2MzY5NTc1MTM4MTQ5NzA0MTImYW1wO3NkYXRhPSUyRjlzDQo+
IGJyREVtSXANCj4gPiA+IHUgT2F6Y0lBVnBJckVMWk1Fak85NCUyQmplbjd3T09sVnNWayUzRCZh
bXA7cmVzZXJ2ZWQ9MC4gVGhlDQo+ID4gPiB3b3JrYXJvdW5kIGlzIGFkZGluZyBuZXcgc2RtYSBy
YW0gc2NyaXB0IHdoaWNoIHdvcmtzIGluIFhDSMKgwqBtb2RlIGFzDQo+ID4gPiBQSU8gaW5zaWRl
IHNkbWEgaW5zdGVhZCBvZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xEJw0KPiA+
ID4gc2hvdWxkIGJlIDAuIFRoZSBpc3N1ZSBzaG91bGQgYmUgZXhpc3Qgb24gYWxsIGxlZ2FjeSBp
Lm14Ni83IHNvYw0KPiA+ID4gZmFtaWx5IGJlZm9yZSBpLm14NnVsLg0KPiA+ID4gwqAgTlhQIGZp
eCB0aGlzIGRlc2lnbiBpc3N1ZSBmcm9tIGkubXg2dWwsIHNvIG5ld2VyIGNoaXBzIGluY2x1ZGlu
Zw0KPiA+ID4gaS5teDZ1bC8gNnVsbC82c2xsIGRvIG5vdCBuZWVkIHRoaXMgd29ya2Fyb3VkIGFu
eW1vcmUuIEFsbCBvdGhlcg0KPiA+ID4gaS5teDYvNy84IGNoaXBzIHN0aWxsIG5lZWQgdGhpcyB3
b3JrYXJvdWQuIFRoaXMgcGF0Y2ggc2V0IGFkZCBuZXcNCj4gPiA+ICdmc2wsaW14NnVsLWVjc3Bp
Jw0KPiA+ID4gZm9yIGVjc3BpIGRyaXZlciBhbmQgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZl
ciB0byBjaG9vc2UgaWYgbmVlZA0KPiA+ID4gZXJyYXRhIG9yIG5vdC4NCj4gPiA+IMKgIFRoZSBm
aXJzdCB0d28gcmV2ZXJ0ZWQgcGF0Y2hlcyBzaG91bGQgYmUgdGhlIHNhbWUgaXNzdWUsIHRob3Vn
aCwNCj4gPiA+IGl0IHNlZW1zICdmaXhlZCcgYnkgY2hhbmdpbmcgdG8gb3RoZXIgc2hwIHNjcmlw
dC4gSG9wZSBTZWFuIG9yDQo+ID4gPiBTYXNjaGEgY291bGQgaGF2ZSB0aGUgY2hhbmNlIHRvIHRl
c3QgdGhpcyBwYXRjaCBzZXQgaWYgY291bGQgZml4DQo+ID4gPiB0aGVpciBpc3N1ZXMuDQo+ID4g
PiDCoCBCZXNpZGVzLCBlbmFibGUgc2RtYSBzdXBwb3J0IGZvciBpLm14OG1tLzhtcSBhbmQgZml4
IGVjc3BpMSBub3QNCj4gPiA+IHdvcmsgb24gaS5teDhtbSBiZWNhdXNlIHRoZSBldmVudCBpZCBp
cyB6ZXJvLg0KPiA+ID4NCj4gPiA+IFBTOg0KPiA+ID4gwqDCoMKgUGxlYXNlIGdldCBzZG1hIGZp
cm13YXJlIGZyb20gYmVsb3cgbGludXgtZmlybXdhcmUgYW5kIGNvcHkgaXQgdG8NCj4gPiA+IHlv
dXIgbG9jYWwgcm9vdGZzIC9saWIvZmlybXdhcmUvaW14L3NkbWEuDQo+ID4gPiBodHRwczovL2dp
dA0KPiA+ID4gLmtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUy
RmZpcm13YXJlJTJGbGludXgtDQo+ID4gPg0KPiBmaXJtd2FyZS5naXQlMkZ0cmVlJTJGaW14JTJG
c2RtYSZhbXA7ZGF0YT0wMiU3QzAxJTdDeWliaW4uZ29uZyU0MA0KPiBueHAuDQo+ID4gPg0KPiBj
b20lN0M2N2QzZTc4ZmU1ZWY0NDI4YjNhZjA4ZDZlZDdiZWI3NCU3QzY4NmVhMWQzYmMyYjRjNmZh
OTJjZDkNCj4gOWM1YzMNCj4gPiA+IDANCj4gPiA+DQo+IDE2MzUlN0MwJTdDMSU3QzYzNjk1NzUx
MzgxNDk3MDQxMiZhbXA7c2RhdGE9eFhIQldwU2FTTG1Nb3NiDQo+ICUyRmFqT0FpWA0KPiA+ID4g
bg0KPiA+ID4gbmt4YVlWNkhDdDI1T096Z1JMYkklM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+DQo+
ID4gPiB2MjoNCj4gPiA+IMKgIDEuQWRkIGNvbW1pdCBsb2cgZm9yIHJldmVydGVkIHBhdGNoZXMu
DQo+ID4gPiDCoCAyLkFkZCBjb21tZW50IGZvciAnZWNzcGlfZml4ZWQnIGluIHNkbWEgZHJpdmVy
Lg0KPiA+ID4gwqAgMy5BZGQgJ2ZzbCxpbXg2c2xsLWVjc3BpJyBjb21wYXRpYmxlIGluc3RlYWQg
b2YgJ2ZzbCxpbXg2dWwtZWNzcGknDQo+ID4gPiDCoMKgwqDCoHJhdGhlciB0aGFuIHJlbW92ZS4N
Cj4gPiA+IHYzOg0KPiA+ID4gwqAgMS5Db25maXJtIHdpdGggZGVzaWduIHRlYW0gbWFrZSBzdXJl
IEVSUjAwOTE2NSBmaXhlZCBvbg0KPiA+ID4gaS5teDZ1bC9pLm14NnVsbA0KPiA+ID4gwqDCoMKg
wqAvaS5teDZzbGwsIG5vdCBmaXhlZCBvbiBpLm14OG0vOG1tIGFuZCBvdGhlciBpLm14Ni83IGxl
Z2FjeQ0KPiA+ID4gY2hpcHMuDQo+ID4gPiDCoMKgwqDCoENvcnJlY3QgZHRzIHJlbGF0ZWQgZHRz
IHBhdGNoIGluIHYyLg0KPiA+ID4gwqAgMi5DbGVhbiBlcmF0dGEgaW5mb3JtYXRpb24gaW4gYmlu
ZGluZyBkb2MgYW5kIG5ldyAndHhfZ2xpdGNoX2ZpeGVkJw0KPiA+ID4gZmxhZw0KPiA+ID4gwqDC
oMKgwqBpbiBzcGktaW14IGRyaXZlciB0byBzdGF0ZSBFUlIwMDkxNjUgZml4ZWQgb3Igbm90Lg0K
PiA+ID4gwqAgMy5FbmxhcmdlIGJ1cnN0IHNpemUgdG8gZmlmbyBzaXplIGZvciB0eCBzaW5jZSB0
eF93bWwgc2V0IHRvIDAgaW4NCj4gPiA+IHRoZQ0KPiA+ID4gwqDCoMKgwqBlcnJhdGEgd29ya2Fy
b3VkLCB0aHVzIGltcHJvdmUgcGVyZm9ybWFuY2UgYXMgcG9zc2libGUuDQo+ID4gPiB2NDoNCj4g
PiA+IMKgIDEuYWRkIEFjayB0YWcgZnJvbSBNYXJrIGFuZCBWaW5vZA0KPiA+ID4gwqAgMi4gcmVt
b3ZlIGNoZWNraW5nICdldmVudF9pZDEnIHplcm8gYXMgJ2V2ZW50X2lkMCcuDQo+ID4gPiB2NToN
Cj4gPiA+IMKgIDEuQWRkIGFub3RoZXIgcGF0Y2ggZm9yIGNvbXBhdGlibGUgd2l0aCB0aGUgY3Vy
cmVudCB1YXJ0IGRyaXZlcg0KPiA+ID4gd2hpY2gNCj4gPiA+IMKgwqDCoMKgdXNpbmcgcm9tIHNj
cmlwdCwgc28gYm90aCB1YXJ0IHJhbSBzY3JpcHQgYW5kIHJvbSBzY3JpcHQNCj4gPiA+IHN1cHBv
cnRlZA0KPiA+ID4gwqDCoMKgwqBpbiBsYXRlc3QgZmlybXdhcmUsIGJ5IGRlZmF1bHQgdWFydCBy
b20gc2NyaXB0IHVzZWQuIFVBUlQgZHJpdmVyDQo+ID4gPiDCoMKgwqDCoHdpbGwgYmUgYnJva2Vu
IHdpdGhvdXQgdGhpcyBwYXRjaC4gTGF0ZXN0IHNkbWEgZmlybXdhcmUgaGFzIGJlZW4NCj4gPiA+
IMKgwqDCoMKgYWxyZWFkeSB1cGRhdGVkIGluIGxpbnV4LWZpcm13YXJlLg0KPiA+ID4NCj4gPiA+
IFJvYmluIEdvbmcgKDE1KToNCj4gPiA+IMKgIFJldmVydCAiQVJNOiBkdHM6IGlteDZxOiBVc2Ug
Y29ycmVjdCBTRE1BIHNjcmlwdCBmb3IgU1BJNSBjb3JlIg0KPiA+ID4gwqAgUmV2ZXJ0ICJBUk06
IGR0czogaW14NjogVXNlIGNvcnJlY3QgU0RNQSBzY3JpcHQgZm9yIFNQSSBjb3JlcyINCj4gPiA+
IMKgIFJldmVydCAiZG1hZW5naW5lOiBpbXgtc2RtYTogcmVmaW5lIHRvIGxvYWQgY29udGV4dCBv
bmx5IG9uY2UiDQo+ID4gPiDCoCBkbWFlbmdpbmU6IGlteC1zZG1hOiByZW1vdmUgZHVwaWxpY2F0
ZWQgc2RtYV9sb2FkX2NvbnRleHQNCj4gPiA+IMKgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCBt
Y3VfMl9lY3NwaSBzY3JpcHQNCj4gPiA+IMKgIHNwaTogaW14OiBmaXggRVJSMDA5MTY1DQo+ID4g
PiDCoCBzcGk6IGlteDogcmVtb3ZlIEVSUjAwOTE2NSB3b3JrYXJvdW5kIG9uIGkubXg2dWwNCj4g
PiA+IMKgIHNwaTogaW14OiBhZGQgbmV3IGkubXg2dWwgY29tcGF0aWJsZSBuYW1lIGluIGJpbmRp
bmcgZG9jDQo+ID4gPiDCoCBkbWFlbmdpbmU6IGlteC1zZG1hOiByZW1vdmUgRVJSMDA5MTY1IG9u
IGkubXg2dWwNCj4gPiA+IMKgIGRtYTogaW14LXNkbWE6IGFkZCBpLm14NnVsLzZzeCBjb21wYXRp
YmxlIG5hbWUNCj4gPiA+IMKgIGRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBlY3NwaTEgcnggZG1h
IG5vdCB3b3JrIG9uIGkubXg4bW0NCj4gPiA+IMKgIEFSTTogZHRzOiBpbXg2dWw6IGFkZCBkbWEg
c3VwcG9ydCBvbiBlY3NwaQ0KPiA+ID4gwqAgQVJNOiBkdHM6IGlteDZzbGw6IGNvcnJlY3Qgc2Rt
YSBjb21wYXRpYmxlDQo+ID4gPiDCoCBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgU0RNQSBvbiBp
Lm14OG1xLzhtbQ0KPiA+ID4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogYWRkIHVhcnQgcm9tIHNj
cmlwdA0KPiA+ID4NCj4gPiA+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgt
c2RtYS50eHTCoMKgwqDCoMKgwqDCoHzCoMKgMiArDQo+ID4gPiDCoC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0wqDCoMKgwqDCoMKgwqB8wqDCoDEgKw0KPiA+ID4g
wqBhcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgMiArLQ0KPiA+ID4gwqBhcmNoL2FybS9ib290L2R0cy9p
bXg2cWRsLmR0c2nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDC
oDggKy0NCj4gPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqAyICstDQo+ID4gPiDCoGFyY2gvYXJt
L2Jvb3QvZHRzL2lteDZ1bC5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB8wqDCoDggKysNCj4gPiA+IMKgYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZ8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDMgKw0KPiA+
ID4gwqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgODgNCj4gPiA+ICsrKysrKysrKysrKysrKyst
LS0tLS0NCj4gPiA+IMKgZHJpdmVycy9zcGkvc3BpLWlteC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCA2MQ0KPiA+ID4gKysrKysr
KysrKysrLS0tDQo+ID4gPiDCoGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNk
bWEuaMKgwqDCoMKgwqDCoMKgwqDCoHwgMTEgKystDQo+ID4gPiDCoDEwIGZpbGVzIGNoYW5nZWQs
IDE0NSBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSkNCj4gPiA+DQo=

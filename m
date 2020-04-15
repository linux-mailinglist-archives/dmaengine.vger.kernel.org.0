Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32CA1AA95E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634017AbgDOOGU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 10:06:20 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:35254
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633951AbgDOOGR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 10:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEnOjYGxE34jC0Uy+ymaLmNCgzC+oAlzBr/7bncj9NhHNS+4PkTO8KpZFoXgxiFjSDcOrXlX2vT0LtKL8QAHrnigp55UAH/jnGLdYSbRuH9rp6au+DncCy3h0Ah/VBM0+meXCfSA2OHfVEYGzsOPGioifsQcHxJ+yY5owtqfFV9t0XzXvOT7pWvhIa/zHR5ZvGiZKAhVtgEXu2ZIZxw7x6zQ+x/ynJmo/wGeWBropi3Cioz2t5+v+5Nhgt6mE1aGJ54eTkiJ4MixJc1I077RnOQvRr74hQ4Sj7dr+e7xOTvjTYMcNBn4SO4c3AhqkfW8cBxf+x+CwvO1dW9eClxzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMkVlUwUIanYqi27DHk/5CVh6hwbNbnoytghIDK2gMw=;
 b=YepMgtM/Gsr74ngedzNSczdDei8NWXl2jixzWQ8qNp7Dcwnj4BUul2GTirIa3PZrJ2qJHq4WTNP10zz0B+ZestCoOSLA42Ez25EldEKBScJp3ZbpIvg85F6NVVXOTVyfpF+aE2RYvX6gaiS9qFC1hKBrfLCITafNERFfcagO4vSy1E6JAqeEgBT6bM9s0yOdSP2wMWqjElw5ASI/rgIBM1uW9sdE+Kd5Uavwydc8VE30iz3IYbDqygxkEY+tjOPXohHTJiXGT4TQ8ikqoUVedzLp7iOxlnFXHBOQ79g3O+VsHFXJ2oeu6ULM6wOLOIxi37AxU7DWhWpRk9FeDnfgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMkVlUwUIanYqi27DHk/5CVh6hwbNbnoytghIDK2gMw=;
 b=K08vQLwguVhykzbWetoSGcv65OUDeyNZxKG0Qtjaq7ZJwz8KLG5cP5KvxN8hTrv4RUlGfdG4jLoGWFMhyLBKWmOCGIoMfeW2pHbiRL03qiBl9SmSsxP1ikrNDO8ddXE5MthYjd5NYWWJR/eh+8I8gMzN4GtrlXAglUdedLrSJ6s=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6704.eurprd04.prod.outlook.com (2603:10a6:803:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Wed, 15 Apr
 2020 14:06:12 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 14:06:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHV93/7B768gsXihk2i42KIYKNYiqh6JquAgABGloA=
Date:   Wed, 15 Apr 2020 14:06:11 +0000
Message-ID: <VE1PR04MB6638479E728795FA28F7614A89DB0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
 <CANh8QzwanSewjJ98HL_yR1juiHo1RN77JQyNNKrMrud3B0dnww@mail.gmail.com>
In-Reply-To: <CANh8QzwanSewjJ98HL_yR1juiHo1RN77JQyNNKrMrud3B0dnww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [183.192.239.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87fe4f26-beab-48e6-eb1e-08d7e1462754
x-ms-traffictypediagnostic: VE1PR04MB6704:|VE1PR04MB6704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6704324F6B7CB16875706E5489DB0@VE1PR04MB6704.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(966005)(186003)(64756008)(33656002)(66446008)(81156014)(6916009)(5660300002)(7416002)(76116006)(316002)(8676002)(52536014)(54906003)(478600001)(83080400001)(66556008)(66476007)(66946007)(86362001)(8936002)(71200400001)(26005)(55016002)(45080400002)(7696005)(6506007)(9686003)(2906002)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrW1o9UWANAF2hJ6m5XHJx8I6uZzAD/nlS/AgFF2DtuRyWzX6Lh+SG9PyM3mXu1+i0ldVZLzTyxO5QkLNEXhmc61z3dOPg+xf+XWT/eKS93ptM2RvBCFeyMqe66N3584VY1kKJnwDFYDSItNH7ju/AXMFFVg0oqNE0yDQ0At5RdOM4I+7VT/jAba4yHuQHCtevtEZsaQDnwBX0tYyrNj5oMOnRBekAmrrLxMC1a2/feAE9JPLNFKi4CNfPDeQQMIso32RbI9VEIYPobYLOWWgUxDJOd/FJtSUwjNzSgcxUUxqPwcrM+QKT6AlbFpKhC2i/ZDB/VUk+XRm3jG0SkdthQF61PsoeTP9QjytzbYjJDcHmdpf21N6sBobUcTHEKmLgnbE/IfixPUUUwH4jlWAlX3LHt9X2g0xbW1pcxDhqqULhJCMu6NtT1xuuGGMrojkFnozwxIa4yRSh0g2/hzncpCxRQMZXQP9Qydl6SLBOY1fkNaZqr49r8WRpwYnjw9Sb0OWxqhPMerXkUUfw0pPg==
x-ms-exchange-antispam-messagedata: BIAP8AE0QmRTfz/6Yu5n5ffDJ8UaNGZuJT5S/EkIB+SST+sUx19s5RJSnB8Eku3hcea0TTxKPzSzsskd+mqWSihPXaDT3WyMqUOuYoIV5IP10vZDMOJ4C9sh9kJTLa4IJdRL7F9xt0oTGHhqsglRoA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fe4f26-beab-48e6-eb1e-08d7e1462754
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 14:06:11.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kt8RvLTh088XiEvPR8PwflHDUPPTLu9S6WQgxewzjOmnrzKA6JuTR3bsFo5FAKlfnip2d2nkzEKn/XG8pEHHGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6704
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wNC8xNSAxNzo0NyBGdXp6ZXksIE1hcnRpbiA8bWFydGluLmZ1enpleUBmbG93Ymly
ZC5ncm91cD4gd3JvdGU6ZA0KPiBIaSBSb2JpbiwNCj4gDQo+IA0KPiBPbiBXZWQsIDExIE1hciAy
MDIwIGF0IDA5OjM1LCBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gVGhlcmUgaXMgZWNzcGkgRVJSMDA5MTY1IG9uIGkubXg2Lzcgc29jIGZhbWlseSwgd2hp
Y2ggY2F1c2UgRklGTw0KPiA+IHRyYW5zZmVyIHRvIGJlIHNlbmQgdHdpY2UgaW4gRE1BIG1vZGUu
IFBsZWFzZSBnZXQgbW9yZSBpbmZvcm1hdGlvbiBmcm9tOg0KPiA+IGh0dHBzOi8vZXVyMDEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dy4NCj4g
Pg0KPiBueHAuY29tJTJGZG9jcyUyRmVuJTJGZXJyYXRhJTJGSU1YNkRRQ0UucGRmJmFtcDtkYXRh
PTAyJTdDMDElN0MNCj4geWliaW4uZw0KPiA+DQo+IG9uZyU0MG54cC5jb20lN0NhZjNhZDg2NmQz
Mjc0ZmNlMmFhZjA4ZDdlMTIxZmZiOCU3QzY4NmVhMWQzYmMyYjRjDQo+IDZmYTkyDQo+ID4NCj4g
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdDNjM3MjI1NDA4NDUwOTg5MjcyJmFtcDtzZGF0YT1hdjMl
MkZuU2FQDQo+IHBRNnJIbGttRkFvb1pTNlA4Zm54QyUyQm03c0pyQmczMGRVWnMlM0QmYW1wO3Jl
c2VydmVkPTAuIFRoZQ0KPiB3b3JrYXJvdW5kIGlzIGFkZGluZyBuZXcgc2RtYSByYW0gc2NyaXB0
IHdoaWNoIHdvcmtzIGluIFhDSCAgbW9kZSBhcyBQSU8NCj4gaW5zaWRlIHNkbWEgaW5zdGVhZCBv
ZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xEJyBzaG91bGQgYmUgMC4NCj4gVGhl
IGlzc3VlIHNob3VsZCBiZSBleGlzdCBvbiBhbGwgbGVnYWN5IGkubXg2Lzcgc29jIGZhbWlseSBi
ZWZvcmUgaS5teDZ1bC4NCj4gPiBOWFAgZml4IHRoaXMgZGVzaWduIGlzc3VlIGZyb20gaS5teDZ1
bCwgc28gbmV3ZXIgY2hpcHMgaW5jbHVkaW5nDQo+ID4gaS5teDZ1bC8gNnVsbC82c2xsIGRvIG5v
dCBuZWVkIHRoaXMgd29ya2Fyb3VkIGFueW1vcmUuIEFsbCBvdGhlcg0KPiA+IGkubXg2LzcvOCBj
aGlwcyBzdGlsbCBuZWVkIHRoaXMgd29ya2Fyb3VkLiBUaGlzIHBhdGNoIHNldCBhZGQgbmV3DQo+
ICdmc2wsaW14NnVsLWVjc3BpJw0KPiA+IGZvciBlY3NwaSBkcml2ZXIgYW5kICdlY3NwaV9maXhl
ZCcgaW4gc2RtYSBkcml2ZXIgdG8gY2hvb3NlIGlmIG5lZWQNCj4gPiBlcnJhdGEgb3Igbm90Lg0K
PiA+IFRoZSBmaXJzdCB0d28gcmV2ZXJ0ZWQgcGF0Y2hlcyBzaG91bGQgYmUgdGhlIHNhbWUgaXNz
dWUsIHRob3VnaCwgaXQNCj4gPiBzZWVtcyAnZml4ZWQnIGJ5IGNoYW5naW5nIHRvIG90aGVyIHNo
cCBzY3JpcHQuIEhvcGUgU2VhbiBvciBTYXNjaGENCj4gPiBjb3VsZCBoYXZlIHRoZSBjaGFuY2Ug
dG8gdGVzdCB0aGlzIHBhdGNoIHNldCBpZiBjb3VsZCBmaXggdGhlaXIgaXNzdWVzLg0KPiA+IEJl
c2lkZXMsIGVuYWJsZSBzZG1hIHN1cHBvcnQgZm9yIGkubXg4bW0vOG1xIGFuZCBmaXggZWNzcGkx
IG5vdCB3b3JrDQo+ID4gb24gaS5teDhtbSBiZWNhdXNlIHRoZSBldmVudCBpZCBpcyB6ZXJvLg0K
PiA+DQo+ID4gUFM6DQo+ID4gICAgUGxlYXNlIGdldCBzZG1hIGZpcm13YXJlIGZyb20gYmVsb3cg
bGludXgtZmlybXdhcmUgYW5kIGNvcHkgaXQgdG8NCj4gPiB5b3VyIGxvY2FsIHJvb3RmcyAvbGli
L2Zpcm13YXJlL2lteC9zZG1hLg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC4NCj4gPg0KPiBrZXJuZWwub3Jn
JTJGcHViJTJGc2NtJTJGbGludXglMkZrZXJuZWwlMkZnaXQlMkZmaXJtd2FyZSUyRmxpbnV4LWZp
cm0NCj4gdw0KPiA+DQo+IGFyZS5naXQlMkZ0cmVlJTJGaW14JTJGc2RtYSZhbXA7ZGF0YT0wMiU3
QzAxJTdDeWliaW4uZ29uZyU0MG54cC5jbw0KPiBtJTdDDQo+ID4NCj4gYWYzYWQ4NjZkMzI3NGZj
ZTJhYWYwOGQ3ZTEyMWZmYjglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNQ0KPiAl
N0MNCj4gPg0KPiAwJTdDMSU3QzYzNzIyNTQwODQ1MDk5OTI2NCZhbXA7c2RhdGE9JTJCZ2NvR0px
VUtBa1piYyUyQlhndFhQc3ANCj4gZDZYN3AwRw0KPiA+IERzN25keUhZNGkxd3AwJTNEJmFtcDty
ZXNlcnZlZD0wDQo+ID4NCj4gDQo+IEEgY291cGxlIG9mIHF1ZXN0aW9ucw0KPiANCj4gMSkgSXMg
dGhpcyBzZXJpZXMgbmVlZGVkIGZvciB0aGUgaS5NWDZETD8gKHRoZSBkb2N1bWVudCB5b3UgbGlu
a2VkIG9ubHkgc2VlbXMNCj4gdG8gbWVudGlvbiBpLk1YNkQvUQ0KWWVzLCBpdCdzIG5lZWRlZCBm
b3IgYWxsIGkubXg2IGxlZ2FjeSBjaGlwcyBpbmNsdWRlIGkuTVg2REwgc2luY2UgdGhleSBzaGFy
ZSB0aGUgc2FtZSBlY3NwaSBJUC4gU2hvdyB0aGUgaS5NWDZEL1EgZG9jdW1lbnQgYXMgYSBzYW1w
bGUuDQo+IDIpIElmIHRoZSBsYXRlcnN0IFNETUEgZmlybXdhcmUgbWVudGlvbm5lZCBhYm92ZSBp
cyB1c2VkIHdpbGwgdGhpcyBicmVhaw0KPiBzeXN0ZW1zIHJ1bm5pbmcgbWFpbmxpbmUga2VybmVs
cyB3aXRob3V0IHRoaXMgcGF0Y2ggc2VyaWVzIGFwcGxpZWQ/DQpObyBiYXNpYyBmdW5jdGlvbiBi
cm9rZW4gd2l0aCB0aGUgbGF0ZXN0IFNETUEgZmlybXdhcmUgYW5kIG1haW5saW5lIGtlcm5lbCB3
aXRob3V0IHRoaXMgcGF0Y2ggc2VyaWVzLCBidXQgdGhlIGVjc3BpIGlzc3VlIEVSUjAwOTE2NSBp
cyBzdGlsbCBoZXJlIHRoZW4uDQo=

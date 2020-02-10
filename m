Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC593157488
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2020 13:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgBJM2w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Feb 2020 07:28:52 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:38894
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726950AbgBJM2v (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Feb 2020 07:28:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOprDAeVfo0mO4iG9EqS4e+HWmZu1VSGLViumG7w0OgUcbJLGsTIBl4d8tIWIfDuv8doC+lPamZZJhqpNZMaTiHyWElffCLm6TC1MJ8gWDsJA3lpKuMA+Qcghv282qf0bVCvvqJZKAQsuSe5wDPE3OTOfXMMFUJQSBRop3yMICrhrrIUzwTgCmWt4IDgdjmibEITNqXs8XIpHKxF5HSDJwV+i9Aryxq/DZNW+xgXEpI4jToHZ/JcMxDm7cXdhFmGfEgaMJjrI/S1ulKRReXxgfwMsDLtmpIxAtoz8dhOPWDjFSBVhjW+AgK4Wfo8VMTyxMU0h5v52e0fVPskyTQ/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1wmNYYDYPTr7WKKA8rVMT331HPcD7Klzmesc+l+300=;
 b=QFeBjH1d7D+4EJzrAPngH+gzKnD5HhTtLz1tBPv4qE8ABt/SVB3I2Ee8w7dcLjocYJeL7wVOqqBdwV/8aW6biBJ3D5hBMqBqPtWEKQMMfHAUbftpKbpHSDxyp6D8ti7WncQqP/yEbnj6elzgqu6/DVfBYpc7gSGC4rJctw3bexFvS9CovHCiga7Ebzdys7S8jCgcDOeMldtjxKVxjoh7gAIby0uyZtcNQZoxI5So668ZQgFBqm51Ki3G7DLHfsqmdoKm/cUbSBRLnfoxQNDtaadx6lifjj88FhkIBFTInXm4f7Cza0rXdmBVhoPjdX+DcWrXfQvwdMDh4IB40WkwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1wmNYYDYPTr7WKKA8rVMT331HPcD7Klzmesc+l+300=;
 b=AD6I60z9T1NOC0emYpc9cTwOpygOoFzijFAZ205K5C/b1uo68m+UE9sI8yds9Oz0lp2oSEPxM/+aoYRorw/dRlJze6hh8aGoagZYzeuEbQROSyu2yYTmf7GSzHoGWJCwiRGcUsIXXHgEq0GsLmG4SKiDMBwkudXia9OE0qXdDmA=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6655.eurprd04.prod.outlook.com (20.179.232.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 12:28:43 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 12:28:43 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Topic: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHVH2TUeqmuIEjDz0ugonhEiODBJqc7eN4AgAFtyHCAADyMgIACPgtwgNANLoCABhHsUA==
Date:   Mon, 10 Feb 2020 12:28:43 +0000
Message-ID: <VE1PR04MB6638D7886CBADAFF47E5497C89190@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190610081753.11422-12-yibin.gong@nxp.com>
 <29cf9f29-bdb4-94db-00b0-56ec36386f7a@kontron.de>
 <VE1PR04MB6638639EF4F580E04689538E89870@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <1307d229-4c49-80e3-04ba-377c0caeae9c@kontron.de>
 <VE1PR04MB6638B066EE28781A3C21973D89810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <862c498f-3c15-fac4-4f17-a30c2e11bb3e@kontron.de>
In-Reply-To: <862c498f-3c15-fac4-4f17-a30c2e11bb3e@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [183.192.236.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95a45a6e-8ce7-49f2-b8e0-08d7ae24c4ba
x-ms-traffictypediagnostic: VE1PR04MB6655:|VE1PR04MB6655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6655CA16FE3531FE81AE842289190@VE1PR04MB6655.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(4326008)(8936002)(7696005)(6506007)(53546011)(33656002)(86362001)(71200400001)(26005)(186003)(7416002)(2906002)(8676002)(81166006)(81156014)(9686003)(52536014)(5660300002)(66946007)(76116006)(316002)(6916009)(66446008)(64756008)(66556008)(66476007)(55016002)(54906003)(4001150100001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6655;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+q3GFhxN7qvU2vq75T/vlMbR+cLXs8y70lXjA8IQPWsQGwOjmmkwnY20Yh0PnLIirajyEktobH+QD60uxsovw7ObCCAHPEW/5zxmIlRKRCwKZdLoa03UjGrU05VrqkXw3cFDkni668bw4ZGSGOyOTU2Kn/XBfALDrDupZyusj0WxVHzLhZxmZ+rzFQpCmOf7tPpaL7R8KOETB8tu0kM9baxYDfV5MmxYkRP9AQcl97dp5gqJM+7jujrsIg9h0FEyYR83QLCZ4FBADrXrOLOZ1nHjYE1iJYCIZuVg4JJfzTIumHC9RDa4ND7pC9VNtMLGWXZr0Gmu46OABkcIJJ6tckAekDt7grmVWlLjcfUC/quqpa77H60FGzEcos0a5yocFj/e+iOn7umd/5Jso+1OQ3AhplFZ++7B7gIRzTMHco5w8FmmEJRPpsLSkSCu3hW
x-ms-exchange-antispam-messagedata: X6C9XTwwcxzeAFv6/h/J3wC3bI7YUtK6l4FtRYf7zQR+Sp4GHAOlJgiYqlmTAq/kmpV4WQHDDQok77CUXSFSyRbtCgM+NmM0f8st7+rbRaDz+Gx4vKfEAqMLZdVlrYwsq/1gy77+IK7XSZrb94Amrg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a45a6e-8ce7-49f2-b8e0-08d7ae24c4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 12:28:43.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKstzxSzm30AUrJWV16YlBM+qMf2swgMMy9cliWyYtjMEvzYkABUSHuEBxOWlZK0Ewcz2qFgO/HCsNN9HVduHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6655
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wMi8wNiBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24u
ZGU+IHdyb3RlOg0KPiANCj4gSGksDQo+IE9uIDI3LjA5LjE5IDAzOjU1LCBSb2JpbiBHb25nIHdy
b3RlOg0KPiA+IE9uIDIwMTktOS0yNSAyMjo1MyBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNj
aHJlbXBmQGtvbnRyb24uZGU+IHdyb3RlOg0KPiA+PiBPbiAyNS4wOS4xOSAxMzoyNiwgUm9iaW4g
R29uZyB3cm90ZToNCj4gPj4+IE9uIDIwMTktOS0yNCAyMToyOCBTY2hyZW1wZiBGcmllZGVyIDxm
cmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+ID4+IHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4g
SGkgUm9iaW4sDQo+ID4+Pj4NCj4gPj4+Pj4gRnJvbTogUm9iaW4gR29uZyA8eWliaW4uZ29uZyBh
dCBueHAuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiBCZWNhdXNlIHRoZSBudW1iZXIgb2YgZWNzcGkx
IHJ4IGV2ZW50IG9uIGkubXg4bW0gaXMgMCwgdGhlDQo+ID4+Pj4+IGNvbmRpdGlvbiBjaGVjayBp
Z25vcmUgc3VjaCBzcGVjaWFsIGNhc2Ugd2l0aG91dCBkbWEgY2hhbm5lbA0KPiA+Pj4+PiBlbmFi
bGVkLCB3aGljaCBjYXVzZWQNCj4gPj4+Pj4gZWNzcGkxIHJ4IHdvcmtzIGZhaWxlZC4gQWN0dWFs
bHksIG5vIG5lZWQgdG8gY2hlY2sNCj4gPj4+Pj4gZXZlbnRfaWQwL2V2ZW50X2lkMSBhbmQgcmVw
bGFjZSBjaGVja2luZyAnZXZlbnRfaWQxJyB3aXRoDQo+ID4+Pj4+ICdETUFfREVWX1RPX0RFVics
IHNvIHRoYXQgY29uZmlndXJlDQo+ID4+Pj4+IGV2ZW50X2lkMSBvbmx5IGluIGNhc2UgREVWX1RP
X0RFVi4NCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4u
Z29uZyBhdCBueHAuY29tPg0KPiA+Pj4+PiBBY2tlZC1ieTogVmlub2QgS291bCA8dmtvdWwgYXQg
a2VybmVsLm9yZz4NCj4gPj4+Pg0KPiA+Pj4+IEkgaGF2ZSBhIGN1c3RvbSBib2FyZCB3aXRoIGku
TVg4TU0gYW5kIFNQSSBmbGFzaCBvbiBlY3NwaTEuIEknbQ0KPiA+Pj4+IGN1cnJlbnRseSB0ZXN0
aW5nIHdpdGggdjUuMyBhbmQgYXMgU1BJIGRpZG4ndCB3b3JrLCBJIHRyaWVkIHR3bw0KPiA+Pj4+
IGRpZmZlcmVudA0KPiA+PiB0aGluZ3M6DQo+ID4+Pj4NCj4gPj4+PiAxLiBSZW1vdmluZyAnZG1h
cycgYW5kICdkbWEtbmFtZXMnIGZyb20gdGhlIGVjc3BpMSBub2RlIGluDQo+ID4+IGlteDhtbS5k
dHNpLA0KPiA+Pj4+ICAgICAgIHRvIHVzZSBQSU8gaW5zdGVhZCBvZiBETUEuIFRoaXMgd29ya3Mg
YXMgZXhwZWN0ZWQgYW5kIHRoZSBkcml2ZXINCj4gPj4+PiAgICAgICBib290cyB3aXRoIHRoZSBm
b2xsb3dpbmcgbWVzc2FnZXM6DQo+ID4+Pj4NCj4gPj4+PiAgICAgICAgICAgc3BpX2lteCAzMDgy
MDAwMC5zcGk6IGRtYSBzZXR1cCBlcnJvciAtMTksIHVzZSBwaW8NCj4gPj4+PiAgICAgICAgICAg
bTI1cDgwIHNwaTAuMDogbXgyNXY4MDM1ZiAoMTAyNCBLYnl0ZXMpDQo+ID4+Pj4gICAgICAgICAg
IHNwaV9pbXggMzA4MjAwMDAuc3BpOiBwcm9iZWQNCj4gPj4+Pg0KPiA+Pj4+IDIuIEFwcGx5aW5n
IHlvdXIgcGF0Y2hzZXQgYW5kIHVzZSBETUEuIEluIHRoaXMgY2FzZSwgdGhlIGZsYXNoIGFsc28N
Cj4gPj4+PiAgICAgICB3b3JrcyBmaW5lLCBidXQgdGhlcmUgYXJlIHNvbWUgZXJyb3IgbWVzc2Fn
ZXMgcHJpbnRlZCB3aGlsZQ0KPiA+PiBib290aW5nOg0KPiA+Pj4+DQo+ID4+Pj4gICAgICAgICAg
IHNwaV9tYXN0ZXIgc3BpMDogSS9PIEVycm9yIGluIERNQSBSWA0KPiA+Pj4+ICAgICAgICAgICBt
MjVwODAgc3BpMC4wOiBTUEkgdHJhbnNmZXIgZmFpbGVkOiAtMTEwDQo+ID4+Pj4gICAgICAgICAg
IHNwaV9tYXN0ZXIgc3BpMDogZmFpbGVkIHRvIHRyYW5zZmVyIG9uZSBtZXNzYWdlIGZyb20gcXVl
dWUNCj4gPj4+PiAgICAgICAgICAgbTI1cDgwIHNwaTAuMDogbXgyNXY4MDM1ZiAoMTAyNCBLYnl0
ZXMpDQo+ID4+Pj4gICAgICAgICAgIHNwaV9pbXggMzA4MjAwMDAuc3BpOiBwcm9iZWQNCj4gPj4+
Pg0KPiA+Pj4+IEl0IHdvdWxkIGJlIGdyZWF0IHRvIGdldCB5b3VyIHBhdGNoZXMgbWVyZ2VkIGFu
ZCBmaXggU1BJICsgRE1BLCBidXQNCj4gPj4+PiBmb3IgaS5NWDhNTSwgd2UgbmVlZCB0byBnZXQg
cmlkIG9mIHRoZSBlcnJvciBtZXNzYWdlcy4gRG8geW91IGhhdmUNCj4gPj4+PiBhbiBpZGVhLCB3
aGF0J3Mgd3Jvbmc/DQo+ID4+DQo+ID4+PiBDb3VsZCB5b3UgY2hlY2sgaWYgdGhlIGxlbmd0aCBv
ZiBzcGkgbWVzc2FnZSBpcyBiaWdnZXIgdGhhbg0KPiA+Pj4gZmlmb19zaXplIGR1cmluZyBzcGlf
bm9yIHByb2JlPyBJZiB5ZXMsIGF0IHRoYXQgdGltZSBtYXliZSBzZG1hIGZpcm13YXJlDQo+IG5v
dCBsb2FkZWQuDQo+ID4+PiBpZiAodHJhbnNmZXItPmxlbiA8IHNwaV9pbXgtPmRldnR5cGVfZGF0
YS0+Zmlmb19zaXplKQ0KPiA+Pg0KPiA+PiBJbmRlZWQsIG1vc3Qgb2YgdGhlIHRyYW5zZmVycyB0
cmlnZ2VyZWQgYnkgdGhlIFNQSSBOT1IgZGlydmVyIGFyZQ0KPiA+PiBiZWxvdyBmaWZvX3NpemUg
YW5kIHdvcmsgZmluZSwgYnV0IHNvbWUgYXJlIGJpZ2dlci4gVGhlIHRyYW5zZmVycw0KPiA+PiB0
aGVyZWZvcmUgdHJ5IHRvIHVzZSBETUEsIGJ1dCB0aGUgZmlybXdhcmUgaXMgbm90IGxvYWRlZCB5
ZXQuDQo+ID4+DQo+ID4+IEhvdyBpcyB0aGlzIHN1cHBvc2VkIHRvIHdvcms/IFNob3VsZG4ndCBh
bGwgdHJhbnNmZXJzIHVzZSBQSU8gYXMgbG9uZw0KPiA+PiBhcyB0aGUgU0RNQSBmaXJtd2FyZSBp
cyBub3QgbG9hZGVkIHlldD8NCj4gPiBZZXMsIGZvciBlY3NwaSBzaG91bGQgd29yayB3aXRoIHJh
bSBzY3JpcHQsIGl0J3MgYmV0dGVyIGNoZWNrIGlmIHNkbWENCj4gPiBmaXJtd2FyZSBpcyByZWFk
eSBpbiBzcGlfaW14X2RtYV9jb25maWd1cmUoKSwgbmVlZCBtb2RpZmljYXRpb24gaW4gc2RtYQ0K
PiBkcml2ZXIgdG9vLg0KPiA+IEknbGwgY3JlYXRlIGFub3RoZXIgcGF0Y2ggYWZ0ZXIgdGhpcyBw
YXRjaCBzZXQgYWNjZXB0ZWQuDQo+IA0KPiBUaGlzIHN0aWxsIHNlZW1zIHRvIGJlIGJyb2tlbiB1
cHN0cmVhbS4gSXMgYW55b25lIHdvcmtpbmcgb24gZml4aW5nIFNQSQ0KPiArIERNQSBmb3IgaS5N
WDhNTT8gT3RoZXJ3aXNlIEkgd2lsbCBzZW5kIGEgcGF0Y2ggdGhhdCByZW1vdmVzIHRoZSBETUEN
Cj4gZnJvbSB0aGUgZWNzcGkgbm9kZXMgaW4gdGhlIGRldmljZXRyZWUuDQpTb3JyeSwgRnJpZWRl
ciwgbXkgcGF0Y2ggc2V0IGhhcyBiZWVuIGJsb2NrZWQgZm9yIHNvIGxvbmcgdGltZSBiZWNhdXNl
IEkgcmV2ZXJ0DQpzb21lIHBhdGNoZXMgYW5kIG5lZWQgZ2V0IGNvbW1pdCBmcm9tIHBhdGNoIG93
bmVyLCB1bmZvcnR1bmF0ZWx5LCBJIGRpZG4ndA0KZ2V0IGFueSBmZWVkYmFjayBmcm9tIHRoZW0g
YWx0aG91Z2ggSSBnb3QgQUNLIGZyb20gbWFpbnRhaW5lci4gSSdsbCBwaWNrIHVwDQp0aGVtLCBy
ZWJhc2UgYW5kIHJlc2VuZCBpdCB0aGVzZSBkYXlzLCB0aGVuIGNvdWxkIGFkZHJlc3MgeW91ciBp
c3N1ZSBsYXRlci4gIA0K

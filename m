Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839E1E01EC
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 12:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfJVKTX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 06:19:23 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:49120
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbfJVKTX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 06:19:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JERnTO8yazUhYcrtw8+b5FtOEdqoyv7UHCrplwxG/j4McrMjCFAhhfL29er+5GlMkzUc8IPzcfK+XsBTNONpDAjbGWTLHU2Zbao1vHWN/wSLw4Ks0GyxJ4ifUKia7CleTw23GM/U+Ki387Eejz1+h08VFyg0bU6rTl06fxOLM+lhl5ebCblnhHtNHKTymCxg05qy3YouQymFJo18bFiZroEdm4INaF5dSRyvuSYd2n3ih4WThJH2cMe80ofHARJtdNBugAbSfE6SSYBmg4z9MDhA8a7qpVrX28V4pWU1vrldmIeu+OXXwgZHThgqZ5LE1D7fP2DdnkEKyULCOrWKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEXo+FgS+06jNMcN7w1IAQzqn9p0BCbKhD/cRBotU90=;
 b=AiQqf3PStOl5gN1UBzRclZI0JUPJPtqIqbnJdSRtGcrycERtXkYJnaRE1BhEs/uC4pT7nZpQd/gHhekgtoClPtb9cC+LPOC2PHoKHSOwaAn3RN2PdyZK93i038iHR1AgxzjZfW6puP51AGYiKNLgz3vdeFLfmw3xq17QV69r4lHk9OopWJD6kdR7UrTl3tjcaaYTS/PsBtUJ771TmdN8jFlv4kBXounL2ZZS02ZQx1dBHazMao1wW7oQutGneu3rgZnjxwjlAt6ReR3akcr+/zqSZU706RmWU+rml/z8xnC8N79ncloWCQTNmGneEPbu1jVTJUenr/GA932dPriQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEXo+FgS+06jNMcN7w1IAQzqn9p0BCbKhD/cRBotU90=;
 b=B1vPM2M7ujx1TMduzkiQ/fweCvlHbcxdpzkbG0nCGcvBQp/eleVyLHOWrsLf8fQwTi9dtfyaw0I00ubp2eiDTDAEstisSWtiTSM5YJL7v0MMMmXaFDZmnUTBh9SPU1Vq9ZKmODjESxl7bU0YNu6ukfPFU/WpL928v2qWrSi0IjU=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.48.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 10:19:19 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 10:19:18 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Anders Roxell <anders.roxell@linaro.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data
 Path DMA Interface) support
Thread-Topic: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
Thread-Index: AQHVdzToZ1j6dYgSekKOe10vHO0HB6deU3YAgAAhjWCACBJZgIAADhxw
Date:   Tue, 22 Oct 2019 10:19:18 +0000
Message-ID: <VI1PR04MB443121007853185039A65534ED680@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190930020440.7754-1-peng.ma@nxp.com>
 <20191017041124.GN2654@vkoul-mobl>
 <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
 <CADYN=9JkQMawVnLoJ8sXAbV8NB_BK0zQA0PomJ583Agj12r8Cg@mail.gmail.com>
In-Reply-To: <CADYN=9JkQMawVnLoJ8sXAbV8NB_BK0zQA0PomJ583Agj12r8Cg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40bbecdf-e954-433e-e73d-08d756d94c94
x-ms-traffictypediagnostic: VI1PR04MB5055:|VI1PR04MB5055:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB505502847B24B1A70C0FE2B0ED680@VI1PR04MB5055.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(13464003)(316002)(54906003)(2906002)(33656002)(256004)(5024004)(14444005)(25786009)(66066001)(6916009)(71200400001)(71190400001)(7696005)(76176011)(6246003)(6116002)(99286004)(26005)(186003)(4326008)(6506007)(102836004)(9686003)(229853002)(6436002)(305945005)(7736002)(966005)(14454004)(55016002)(3846002)(6306002)(478600001)(74316002)(476003)(486006)(66446008)(11346002)(8936002)(66946007)(76116006)(446003)(66556008)(66476007)(64756008)(52536014)(81166006)(81156014)(86362001)(5660300002)(8676002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5055;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0P40TGXdeGg3ejpflfKGKie5YX2GeD5CJo9DpA309esQEbceLlKoE95UIHmqhzzggslG170GETYEOw3aS3pj3gTJM6UfopcxzbD7tmZ80bD1TnqyS2d+SQn174xZnZ0qMlItyZkOVL6EWYBisXpI09C1BKB5/WwCxf/Py391GOMqii+irsOxh87RR98TWRGFEz+iZgEc8+Vg5Rf3mNFsmCOYplaUTOkOz+yo2s9vrtykgee77legAIokne4p8Iu85ygA5MGxZ5gSiR8i09OynwzgOwR3O/ecN+TAGtu3JwoOWgpZVJ86gT6B+6WKeY7+6L1Jcd5+XFUIbIUNimlFoFwMZdJ1YGN3R15czWzlI5BYt/C22ZH9RYdQCD74Arf95fHwGuW+Nt14a2RRYPcNcGckbYF5u0PUlicxSdNHQLt7Mrl1d/vZhgHz8hYeqiWQDw7xEM0/9K5hgwCKz32cFvQixMn0BTzvhT23uQOhONs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bbecdf-e954-433e-e73d-08d756d94c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 10:19:18.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cWduJgtiNroQNLB6n1bYmjWumZY90XNTWuop2GtS6o3ML6Ew2lUOxavpXgNHx9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5055
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgQW5kZXJzICYmIFZpb2QsDQoNCkkgc2VudCB2NiBwYXRjaCB0byBmaXggdGhlIGJ1aWxkIGVy
cm9yLCBwbGVhc2UgY2hlY2suDQpQYXRjaHdvcmsgbGluazoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1kbWFlbmdpbmUvbGlzdC8/c2VyaWVzPTE5MTM5Nw0KDQpC
ZXN0IFJlZ2FyZHMsDQpQZW5nDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBB
bmRlcnMgUm94ZWxsIDxhbmRlcnMucm94ZWxsQGxpbmFyby5vcmc+DQo+U2VudDogMjAxOeW5tDEw
5pyIMjLml6UgMTc6MjcNCj5UbzogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPkNjOiBWaW5v
ZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBMZW8g
TGkNCj48bGVveWFuZy5saUBueHAuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj5kbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtFWFRdIFJlOiBbVjUg
MS8yXSBkbWFlbmdpbmU6IGZzbC1kcGFhMi1xZG1hOiBBZGQgdGhlDQo+RFBETUFJKERhdGEgUGF0
aCBETUEgSW50ZXJmYWNlKSBzdXBwb3J0DQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+T24g
VGh1LCAxNyBPY3QgMjAxOSBhdCAwODoxNiwgUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPiB3cm90
ZToNCj4+DQo+PiBIaSBWaW5vZCwNCj4+DQo+PiBUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIHJl
cGx5Lg0KPj4NCj4+IEJlc3QgUmVnYXJkcywNCj4+IFBlbmcNCj4+ID4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPj4gPkZyb206IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+PiA+
U2VudDogMjAxOeW5tDEw5pyIMTfml6UgMTI6MTENCj4+ID5UbzogUGVuZyBNYSA8cGVuZy5tYUBu
eHAuY29tPg0KPj4gPkNjOiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IExlbyBMaSA8bGVveWFu
Zy5saUBueHAuY29tPjsNCj4+ID5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbWFlbmdp
bmVAdmdlci5rZXJuZWwub3JnDQo+PiA+U3ViamVjdDogW0VYVF0gUmU6IFtWNSAxLzJdIGRtYWVu
Z2luZTogZnNsLWRwYWEyLXFkbWE6IEFkZCB0aGUNCj4+ID5EUERNQUkoRGF0YSBQYXRoIERNQSBJ
bnRlcmZhY2UpIHN1cHBvcnQNCj4+ID4NCj4+ID5DYXV0aW9uOiBFWFQgRW1haWwNCj4+ID4NCj4+
ID5PbiAzMC0wOS0xOSwgMDI6MDQsIFBlbmcgTWEgd3JvdGU6DQo+PiA+PiBUaGUgTUMoTWFuYWdl
bWVudCBDb21wbGV4KSBleHBvcnRzIHRoZSBEUERNQUkoRGF0YSBQYXRoIERNQQ0KPj4gPkludGVy
ZmFjZSkNCj4+ID4+IG9iamVjdCBhcyBhbiBpbnRlcmZhY2UgdG8gb3BlcmF0ZSB0aGUgRFBBQTIo
RGF0YSBQYXRoIEFjY2VsZXJhdGlvbg0KPj4gPj4gQXJjaGl0ZWN0dXJlIDIpIHFETUEgRW5naW5l
LiBUaGUgRFBETUFJIGVuYWJsZXMgc2VuZGluZyBmcmFtZS1iYXNlZA0KPj4gPj4gcmVxdWVzdHMg
dG8gcURNQSBhbmQgcmVjZWl2aW5nIGJhY2sgY29uZmlybWF0aW9uIHJlc3BvbnNlIG9uDQo+PiA+
PiB0cmFuc2FjdGlvbiBjb21wbGV0aW9uLCB1dGlsaXppbmcgdGhlIERQQUEyIFFCTWFuKFF1ZXVl
IE1hbmFnZXIgYW5kDQo+PiA+PiBCdWZmZXIgTWFuYWdlcg0KPj4gPj4gaGFyZHdhcmUpIGluZnJh
c3RydWN0dXJlLiBEUERNQUkgb2JqZWN0IHByb3ZpZGVzIHVwIHRvIHR3bw0KPj4gPj4gcHJpb3Jp
dGllcyBmb3IgcHJvY2Vzc2luZyBxRE1BIHJlcXVlc3RzLg0KPj4gPj4gVGhlIGZvbGxvd2luZyBs
aXN0IHN1bW1hcml6ZXMgdGhlIERQRE1BSSBtYWluIGZlYXR1cmVzIGFuZCBjYXBhYmlsaXRpZXM6
DQo+PiA+PiAgICAgICAxLiBTdXBwb3J0cyB1cCB0byB0d28gc2NoZWR1bGluZyBwcmlvcml0aWVz
IGZvciBwcm9jZXNzaW5nDQo+PiA+PiAgICAgICBzZXJ2aWNlIHJlcXVlc3RzLg0KPj4gPj4gICAg
ICAgLSBFYWNoIERQRE1BSSB0cmFuc21pdCBxdWV1ZSBpcyBtYXBwZWQgdG8gb25lIG9mIHR3byBz
ZXJ2aWNlDQo+PiA+PiAgICAgICBwcmlvcml0aWVzLCBhbGxvd2luZyBmdXJ0aGVyIHByaW9yaXRp
emF0aW9uIGluIGhhcmR3YXJlIGJldHdlZW4NCj4+ID4+ICAgICAgIHJlcXVlc3RzIGZyb20gZGlm
ZmVyZW50IERQRE1BSSBvYmplY3RzLg0KPj4gPj4gICAgICAgMi4gU3VwcG9ydHMgdXAgdG8gdHdv
IHJlY2VpdmUgcXVldWVzIGZvciBpbmNvbWluZyB0cmFuc2FjdGlvbg0KPj4gPj4gICAgICAgY29t
cGxldGlvbiBjb25maXJtYXRpb25zLg0KPj4gPj4gICAgICAgLSBFYWNoIERQRE1BSSByZWNlaXZl
IHF1ZXVlIGlzIG1hcHBlZCB0byBvbmUgb2YgdHdvIHJlY2VpdmUNCj4+ID4+ICAgICAgIHByaW9y
aXRpZXMsIGFsbG93aW5nIGZ1cnRoZXIgcHJpb3JpdGl6YXRpb24gYmV0d2VlbiBvdGhlcg0KPj4g
Pj4gICAgICAgaW50ZXJmYWNlcyB3aGVuIGFzc29jaWF0aW5nIHRoZSBEUERNQUkgcmVjZWl2ZSBx
dWV1ZXMgdG8gRFBJTw0KPj4gPj4gICAgICAgb3IgRFBDT04oRGF0YSBQYXRoIENvbmNlbnRyYXRv
cikgb2JqZWN0cy4NCj4+ID4+ICAgICAgIDMuIFN1cHBvcnRzIGRpZmZlcmVudCBzY2hlZHVsaW5n
IG9wdGlvbnMgZm9yIHByb2Nlc3NpbmcgcmVjZWl2ZWQNCj4+ID4+ICAgICAgIHBhY2tldHM6DQo+
PiA+PiAgICAgICAtIFF1ZXVlcyBjYW4gYmUgY29uZmlndXJlZCBlaXRoZXIgaW4gJ3BhcmtlZCcg
bW9kZSAoZGVmYXVsdCksDQo+PiA+PiAgICAgICBvciBhdHRhY2hlZCB0byBhIERQSU8gb2JqZWN0
LCBvciBhdHRhY2hlZCB0byBEUENPTiBvYmplY3QuDQo+PiA+PiAgICAgICA0LiBBbGxvd3MgaW50
ZXJhY3Rpb24gd2l0aCBvbmUgb3IgbW9yZSBEUElPIG9iamVjdHMgZm9yDQo+PiA+PiAgICAgICBk
ZXF1ZXVlaW5nL2VucXVldWVpbmcgZnJhbWUgZGVzY3JpcHRvcnMoRkQpIGFuZCBmb3INCj4+ID4+
ICAgICAgIGFjcXVpcmluZy9yZWxlYXNpbmcgYnVmZmVycy4NCj4+ID4+ICAgICAgIDUuIFN1cHBv
cnRzIGVuYWJsZSwgZGlzYWJsZSwgYW5kIHJlc2V0IG9wZXJhdGlvbnMuDQo+PiA+Pg0KPj4gPj4g
QWRkIGRwZG1haSB0byBzdXBwb3J0IHNvbWUgcGxhdGZvcm1zIHdpdGggZHBhYTIgcWRtYSBlbmdp
bmUuDQo+PiA+DQo+PiA+QXBwbGllZCBib3RoLCB0aGFua3MNCj4NCj5JIHNlZSB0aGlzIGVycm9y
IHdoZW4gSSdtIGJ1aWxkaW5nLg0KPg0KPldBUk5JTkc6IG1vZHBvc3Q6IG1pc3NpbmcgTU9EVUxF
X0xJQ0VOU0UoKSBpbg0KPmRyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1hL2RwZG1haS5vDQo+c2Vl
IGluY2x1ZGUvbGludXgvbW9kdWxlLmggZm9yIG1vcmUgaW5mb3JtYXRpb24NCj5FUlJPUjogImRw
ZG1haV9lbmFibGUiIFtkcml2ZXJzL2RtYS9mc2wtZHBhYTItcWRtYS9kcGFhMi1xZG1hLmtvXQ0K
PnVuZGVmaW5lZCENCj5FUlJPUjogImRwZG1haV9zZXRfcnhfcXVldWUiDQo+W2RyaXZlcnMvZG1h
L2ZzbC1kcGFhMi1xZG1hL2RwYWEyLXFkbWEua29dIHVuZGVmaW5lZCENCj5FUlJPUjogImRwZG1h
aV9nZXRfdHhfcXVldWUiDQo+W2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1hL2RwYWEyLXFkbWEu
a29dIHVuZGVmaW5lZCENCj5FUlJPUjogImRwZG1haV9nZXRfcnhfcXVldWUiDQo+W2RyaXZlcnMv
ZG1hL2ZzbC1kcGFhMi1xZG1hL2RwYWEyLXFkbWEua29dIHVuZGVmaW5lZCENCj5FUlJPUjogImRw
ZG1haV9nZXRfYXR0cmlidXRlcyINCj5bZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTIt
cWRtYS5rb10gdW5kZWZpbmVkIQ0KPkVSUk9SOiAiZHBkbWFpX29wZW4iIFtkcml2ZXJzL2RtYS9m
c2wtZHBhYTItcWRtYS9kcGFhMi1xZG1hLmtvXQ0KPnVuZGVmaW5lZCENCj5FUlJPUjogImRwZG1h
aV9jbG9zZSIgW2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1hL2RwYWEyLXFkbWEua29dDQo+dW5k
ZWZpbmVkIQ0KPkVSUk9SOiAiZHBkbWFpX2Rpc2FibGUiIFtkcml2ZXJzL2RtYS9mc2wtZHBhYTIt
cWRtYS9kcGFhMi1xZG1hLmtvXQ0KPnVuZGVmaW5lZCENCj5FUlJPUjogImRwZG1haV9yZXNldCIg
W2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1hL2RwYWEyLXFkbWEua29dDQo+dW5kZWZpbmVkIQ0K
Pm1ha2VbMl06ICoqKiBbLi4vc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0Ojk1OiBfX21vZHBvc3Rd
IEVycm9yIDENCj5tYWtlWzFdOiAqKiogWy9zcnYvc3JjL2tlcm5lbC9uZXh0L01ha2VmaWxlOjEy
ODI6IG1vZHVsZXNdIEVycm9yIDINCj5tYWtlOiAqKiogW01ha2VmaWxlOjE3OTogc3ViLW1ha2Vd
IEVycm9yIDINCj5tYWtlOiBUYXJnZXQgJ0ltYWdlJyBub3QgcmVtYWRlIGJlY2F1c2Ugb2YgZXJy
b3JzLg0KPm1ha2U6IFRhcmdldCAnbW9kdWxlcycgbm90IHJlbWFkZSBiZWNhdXNlIG9mIGVycm9y
cy4NCj4NCj5hbnkgb3RoZXIgdGhhdCBzZWUgdGhlIHNhbWUgPw0KPg0KPkNoZWVycywNCj5BbmRl
cnMNCg==

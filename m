Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F259CBFCF1
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 03:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfI0BzS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 21:55:18 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:40927
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbfI0BzS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 21:55:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEEhyLbg+dDqB70xDEvkI6Ld6ea1tvW8VyLHHjnvGzP6HZw3h4ULws+FMhQ76v8fuT4e6IOur7oAder1ndjanyLUWC+u5JqX2lREKZjBvpFRoGxqksR1/AwsAf2UohzlAi1QsF0ZRL86zjgtjYiBsGW5g+/lCQsq3zVyYK5JKZVaVT9KSB/t/DzgbfUhq5HJZCerpJojJU6EBkziSSPQFeN8dPudo79cy8eaeZkhkpSRj322ilm2d6Who4mDiBCtXsbHdf6+0IUu/1/KhQ2o/lzrAb6aK1xVsU7eaixohNtfTuEDuaXT6RrDy3Hy8zDhdAYZ7GlNeur12LB0UUBUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVV8MyAmvxdBFEEmeG9psM+kbTdh/A5dCpWuBNl+q8o=;
 b=EzqA6z2gfk9MNzgx6XRIk+9WBqYavaZgMmxbjeyAt6vlgdGr9qV8EN41MKZUHayF3UKQlG+urYRkWjpsNgh+gYsj40ZLyyS6O9r2/79BaDiJjNdYY2oatacN9AMHPWevVMQdOIDQtAP/0ufe0IA37Lc8VWw4PLGGhG7Qv8ytLae3mL6OH057illSG9owSeA6SOVMSpnVAsTKNKstEcr7zKv6R7arjXAyyuKMPIXUksWSxfHvhW5M82nNcfHpu40vwX2uDGBmjqO/2W+IMzDDxocGAVTFEw+qdg6LPKeRsYClxQ6WIN0wYdGV6bAtkpyjMtPMnx0HI+ebvrGXPfULig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVV8MyAmvxdBFEEmeG9psM+kbTdh/A5dCpWuBNl+q8o=;
 b=h0O9c+E4CZ2LIf8WPrrqqOmwmXfm6SDH6gYRwp/iVdDdVZ3VFQfh6lStZSzoVz9bEv/KwxrpB31rILXp7LL17fYzIEEmQeRb3y2eQ05RpAQFHBSdso3iWi+X0gSn8bljbRdsc8gG7nvDQcwMeRe/NZNdYHhVCXgvV5CJIiDKnCc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6750.eurprd04.prod.outlook.com (20.179.234.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Fri, 27 Sep 2019 01:55:14 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561%5]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 01:55:14 +0000
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
Thread-Index: AQHVH2TUeqmuIEjDz0ugonhEiODBJqc7eN4AgAFtyHCAADyMgIACPgtw
Date:   Fri, 27 Sep 2019 01:55:13 +0000
Message-ID: <VE1PR04MB6638B066EE28781A3C21973D89810@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190610081753.11422-12-yibin.gong@nxp.com>
 <29cf9f29-bdb4-94db-00b0-56ec36386f7a@kontron.de>
 <VE1PR04MB6638639EF4F580E04689538E89870@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <1307d229-4c49-80e3-04ba-377c0caeae9c@kontron.de>
In-Reply-To: <1307d229-4c49-80e3-04ba-377c0caeae9c@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6316e2a2-cdde-4e0b-53cc-08d742edbce8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VE1PR04MB6750:|VE1PR04MB6750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB675034C9E3CAA51C3EFDCDA989810@VE1PR04MB6750.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(76176011)(25786009)(6916009)(6116002)(3846002)(66476007)(66556008)(256004)(76116006)(64756008)(66446008)(66946007)(86362001)(54906003)(4001150100001)(316002)(71190400001)(71200400001)(8936002)(52536014)(7696005)(81156014)(55016002)(99286004)(9686003)(81166006)(6436002)(7416002)(102836004)(53546011)(6506007)(26005)(66066001)(6246003)(14454004)(74316002)(446003)(486006)(11346002)(476003)(4326008)(5660300002)(8676002)(186003)(33656002)(229853002)(478600001)(7736002)(305945005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6750;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eevZanXK3h0QPuX+Jao5biCE+NeLiCp33NuIsjmyAWLPgvLraqMm80BdiWaqlOJWJpNDZmDh54A9F21FZUMiur4Bp6q+nPql5gn2Q70phVrLlikEn7VsmjJM3XAjS5SIaSOPqVS87Gap8I1qKkY+fXRVUH2x46p71ZHDhqZ46qVemTErkALzOFQ1AU4JzzUGEG1g1/Tyv/PvoNlHor8FkU7xropfJfjrREeec9x6RA/EyjBhK9XeqMmndfA2cg5kDpWBhIPrZW6spL3rerf+MjlFfHlAnrFwXoBLP/Q0iZCJz7epnwWQO87dSPiGX5Q/pmouGOGfufnRU+XYUFG549SsNzIyjn9zSZJV3/L8CyKsYc8ZOaeqKFaaPLqqvxLtuG4eA+yj7id8KV9LDDl7pzQYt3GbSQ9E72cfF6ptSSY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6316e2a2-cdde-4e0b-53cc-08d742edbce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 01:55:13.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSvurupapxzvNRrxnYYeFPNtgCrh63t9UkQZjAtYtW/rjXpzQLUd/WKI43LvB90Uaq14Kvqob+ycjouPgEFqMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6750
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS05LTI1IDIyOjUzIFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZAa29u
dHJvbi5kZT4gd3JvdGU6DQo+IE9uIDI1LjA5LjE5IDEzOjI2LCBSb2JpbiBHb25nIHdyb3RlOg0K
PiA+IE9uIDIwMTktOS0yNCAyMToyOCBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJlbXBm
QGtvbnRyb24uZGU+DQo+IHdyb3RlOg0KPiA+Pg0KPiA+PiBIaSBSb2JpbiwNCj4gPj4NCj4gPj4+
IEZyb206IFJvYmluIEdvbmcgPHlpYmluLmdvbmcgYXQgbnhwLmNvbT4NCj4gPj4+DQo+ID4+PiBC
ZWNhdXNlIHRoZSBudW1iZXIgb2YgZWNzcGkxIHJ4IGV2ZW50IG9uIGkubXg4bW0gaXMgMCwgdGhl
IGNvbmRpdGlvbg0KPiA+Pj4gY2hlY2sgaWdub3JlIHN1Y2ggc3BlY2lhbCBjYXNlIHdpdGhvdXQg
ZG1hIGNoYW5uZWwgZW5hYmxlZCwgd2hpY2gNCj4gPj4+IGNhdXNlZA0KPiA+Pj4gZWNzcGkxIHJ4
IHdvcmtzIGZhaWxlZC4gQWN0dWFsbHksIG5vIG5lZWQgdG8gY2hlY2sNCj4gPj4+IGV2ZW50X2lk
MC9ldmVudF9pZDEgYW5kIHJlcGxhY2UgY2hlY2tpbmcgJ2V2ZW50X2lkMScgd2l0aA0KPiA+Pj4g
J0RNQV9ERVZfVE9fREVWJywgc28gdGhhdCBjb25maWd1cmUNCj4gPj4+IGV2ZW50X2lkMSBvbmx5
IGluIGNhc2UgREVWX1RPX0RFVi4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBH
b25nIDx5aWJpbi5nb25nIGF0IG54cC5jb20+DQo+ID4+PiBBY2tlZC1ieTogVmlub2QgS291bCA8
dmtvdWwgYXQga2VybmVsLm9yZz4NCj4gPj4NCj4gPj4gSSBoYXZlIGEgY3VzdG9tIGJvYXJkIHdp
dGggaS5NWDhNTSBhbmQgU1BJIGZsYXNoIG9uIGVjc3BpMS4gSSdtDQo+ID4+IGN1cnJlbnRseSB0
ZXN0aW5nIHdpdGggdjUuMyBhbmQgYXMgU1BJIGRpZG4ndCB3b3JrLCBJIHRyaWVkIHR3byBkaWZm
ZXJlbnQNCj4gdGhpbmdzOg0KPiA+Pg0KPiA+PiAxLiBSZW1vdmluZyAnZG1hcycgYW5kICdkbWEt
bmFtZXMnIGZyb20gdGhlIGVjc3BpMSBub2RlIGluDQo+IGlteDhtbS5kdHNpLA0KPiA+PiAgICAg
IHRvIHVzZSBQSU8gaW5zdGVhZCBvZiBETUEuIFRoaXMgd29ya3MgYXMgZXhwZWN0ZWQgYW5kIHRo
ZSBkcml2ZXINCj4gPj4gICAgICBib290cyB3aXRoIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXM6DQo+
ID4+DQo+ID4+ICAgICAgICAgIHNwaV9pbXggMzA4MjAwMDAuc3BpOiBkbWEgc2V0dXAgZXJyb3Ig
LTE5LCB1c2UgcGlvDQo+ID4+ICAgICAgICAgIG0yNXA4MCBzcGkwLjA6IG14MjV2ODAzNWYgKDEw
MjQgS2J5dGVzKQ0KPiA+PiAgICAgICAgICBzcGlfaW14IDMwODIwMDAwLnNwaTogcHJvYmVkDQo+
ID4+DQo+ID4+IDIuIEFwcGx5aW5nIHlvdXIgcGF0Y2hzZXQgYW5kIHVzZSBETUEuIEluIHRoaXMg
Y2FzZSwgdGhlIGZsYXNoIGFsc28NCj4gPj4gICAgICB3b3JrcyBmaW5lLCBidXQgdGhlcmUgYXJl
IHNvbWUgZXJyb3IgbWVzc2FnZXMgcHJpbnRlZCB3aGlsZQ0KPiBib290aW5nOg0KPiA+Pg0KPiA+
PiAgICAgICAgICBzcGlfbWFzdGVyIHNwaTA6IEkvTyBFcnJvciBpbiBETUEgUlgNCj4gPj4gICAg
ICAgICAgbTI1cDgwIHNwaTAuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMA0KPiA+PiAgICAg
ICAgICBzcGlfbWFzdGVyIHNwaTA6IGZhaWxlZCB0byB0cmFuc2ZlciBvbmUgbWVzc2FnZSBmcm9t
IHF1ZXVlDQo+ID4+ICAgICAgICAgIG0yNXA4MCBzcGkwLjA6IG14MjV2ODAzNWYgKDEwMjQgS2J5
dGVzKQ0KPiA+PiAgICAgICAgICBzcGlfaW14IDMwODIwMDAwLnNwaTogcHJvYmVkDQo+ID4+DQo+
ID4+IEl0IHdvdWxkIGJlIGdyZWF0IHRvIGdldCB5b3VyIHBhdGNoZXMgbWVyZ2VkIGFuZCBmaXgg
U1BJICsgRE1BLCBidXQNCj4gPj4gZm9yIGkuTVg4TU0sIHdlIG5lZWQgdG8gZ2V0IHJpZCBvZiB0
aGUgZXJyb3IgbWVzc2FnZXMuIERvIHlvdSBoYXZlIGFuDQo+ID4+IGlkZWEsIHdoYXQncyB3cm9u
Zz8NCj4gDQo+ID4gQ291bGQgeW91IGNoZWNrIGlmIHRoZSBsZW5ndGggb2Ygc3BpIG1lc3NhZ2Ug
aXMgYmlnZ2VyIHRoYW4gZmlmb19zaXplDQo+ID4gZHVyaW5nIHNwaV9ub3IgcHJvYmU/IElmIHll
cywgYXQgdGhhdCB0aW1lIG1heWJlIHNkbWEgZmlybXdhcmUgbm90IGxvYWRlZC4NCj4gPiBpZiAo
dHJhbnNmZXItPmxlbiA8IHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+Zmlmb19zaXplKQ0KPiANCj4g
SW5kZWVkLCBtb3N0IG9mIHRoZSB0cmFuc2ZlcnMgdHJpZ2dlcmVkIGJ5IHRoZSBTUEkgTk9SIGRp
cnZlciBhcmUgYmVsb3cNCj4gZmlmb19zaXplIGFuZCB3b3JrIGZpbmUsIGJ1dCBzb21lIGFyZSBi
aWdnZXIuIFRoZSB0cmFuc2ZlcnMgdGhlcmVmb3JlIHRyeSB0bw0KPiB1c2UgRE1BLCBidXQgdGhl
IGZpcm13YXJlIGlzIG5vdCBsb2FkZWQgeWV0Lg0KPiANCj4gSG93IGlzIHRoaXMgc3VwcG9zZWQg
dG8gd29yaz8gU2hvdWxkbid0IGFsbCB0cmFuc2ZlcnMgdXNlIFBJTyBhcyBsb25nIGFzIHRoZQ0K
PiBTRE1BIGZpcm13YXJlIGlzIG5vdCBsb2FkZWQgeWV0Pw0KWWVzLCBmb3IgZWNzcGkgc2hvdWxk
IHdvcmsgd2l0aCByYW0gc2NyaXB0LCBpdCdzIGJldHRlciBjaGVjayBpZiBzZG1hIGZpcm13YXJl
DQppcyByZWFkeSBpbiBzcGlfaW14X2RtYV9jb25maWd1cmUoKSwgbmVlZCBtb2RpZmljYXRpb24g
aW4gc2RtYSBkcml2ZXIgdG9vLg0KSSdsbCBjcmVhdGUgYW5vdGhlciBwYXRjaCBhZnRlciB0aGlz
IHBhdGNoIHNldCBhY2NlcHRlZC4gDQo+IA0KPiAoKyBDYzogbGludXgtc3BpQHZnZXIua2VybmVs
Lm9yZykNCg==

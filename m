Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D694BDD12
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404580AbfIYL1S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 07:27:18 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:39887
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404460AbfIYL1R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 07:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+F1+HPkS0uBnwSa3O/yIh6rbF4oGm94hQjYoMSLMUHCFwevgSoyyKzqDLlQJclqBIOCPf+bafshl0rax0HW3mrhpNI8aYAfBk8faszj3I2TmAou87/CdzuijpFzXQOOJ9zGqUItjfpun2bQ8sXau8YjFaRS2CHkxblIwzxLo3/CFj/3ISzK2CQ5RR/aAD1+UFavOkK4lXPtXhK558+C3IwstmkC1qZ0PqKe8aLtZPXxqe/vcampQFuUFOeY/TlhoTs4gnaOxgj6QxMFNerlFOh3cOFQUQWbINFymPqsXODedr+2neDcI8RK4MDsGGz6AjgR70h1dtNO9LLFk+1bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qO7ILLFmQNxwzN+9N1gQxBgSqJhTznjRVbG4QmHg8I=;
 b=Yhq8RKVi4oOyhp7nhO2Wrt9EjfEtFyzdRz99CnKOAe+LDzsVWzQlsFRAUMNn5o6nyQVNwz3y1kgiisHWxVrgoVsuXoKSJacvTjxnQHtPJuPy54vPrdWfHULuswRLeSG82dksu8S+UTRWZW4j5rpfRFgPJXPFVvA9wymgbc+hpwxPXYvtSAHJcAT4faBNkI1sVlGWOzKYlqbnesJTQmN8SXvOpgPBqhtBukdMnkT6IH5OH6ODdOavmYP7nxkROM986AeVwRSj+587taTG9atCLaMoUF33FO61xmXQOZAdSwITQp0ifz+YUk7SF+5Sxx9qjsaOpusjrBNIYgYW4dU4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qO7ILLFmQNxwzN+9N1gQxBgSqJhTznjRVbG4QmHg8I=;
 b=aJRVVrNPvgd3a7JsCGAHN9W0Vi+dN9gLZkKyYt6wObNTL8VmSfgG4qHJOuRV9NviwU7jMhxksf7pIC7fmSSvQJf/GMCBxKSmCZJib+67sRK2LqlCkffo7DHKLu4yjCOpdajUP9M0aNO9oa96S7T47bJvHv1EoVYnsTz6wmMcQWk=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6591.eurprd04.prod.outlook.com (20.179.234.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 25 Sep 2019 11:26:31 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561%5]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 11:26:31 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Topic: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHVH2TUeqmuIEjDz0ugonhEiODBJqc7eN4AgAFtyHA=
Date:   Wed, 25 Sep 2019 11:26:30 +0000
Message-ID: <VE1PR04MB6638639EF4F580E04689538E89870@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190610081753.11422-12-yibin.gong@nxp.com>
 <29cf9f29-bdb4-94db-00b0-56ec36386f7a@kontron.de>
In-Reply-To: <29cf9f29-bdb4-94db-00b0-56ec36386f7a@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [116.231.57.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b506a70e-fd56-45df-ecc7-08d741ab36e1
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VE1PR04MB6591:|VE1PR04MB6591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB65910C765D390CB2C5AF4DD589870@VE1PR04MB6591.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(5660300002)(6436002)(7416002)(229853002)(6916009)(6246003)(7696005)(4326008)(53546011)(6506007)(316002)(86362001)(476003)(7736002)(54906003)(33656002)(478600001)(14454004)(76176011)(256004)(64756008)(66446008)(11346002)(66556008)(66476007)(52536014)(99286004)(66946007)(4001150100001)(186003)(446003)(26005)(71190400001)(3846002)(6116002)(8936002)(76116006)(74316002)(81166006)(9686003)(2906002)(66066001)(102836004)(81156014)(25786009)(486006)(55016002)(305945005)(71200400001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6591;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vu4PvXgHjU7+P54i0i7kunDnpxdybREojATbBiZisR/aQheflKuyaYUCAo2W40tnqkAyDbfE9WM2N7X6e+nWLSMXNR0hQaK7N147H8PNPED6liutMzfm1kSRhxU44Bd8o1PvlOqRZRt4ot6b/DhZzvsw+MAKswoCOOU6kFSjL3NXlWYOXgeyabqR1KFMHfo7AGNEZxk2MD8yte2ysWxTYstcqx/PTplkGc/LP0iKK18/BBOzK/3X0NZBHbJ+PWmCvlYfCmHQ0tB/nwZX4aYoN1C7oE0lU8DIoWI4wW06s88t9ezUt06JsT60ShvLoySFGKI+EEtpZvL8JYoru5BRo+aMRBYXC18s3HfmmL1BUw57/v8C9BSN6uhYui8rKf1Mmls74HjmStq1KPExZWIpy9LltS+6rFcjQNoiuE1sDBk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b506a70e-fd56-45df-ecc7-08d741ab36e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 11:26:30.9335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7kBpWi1ijmbmC86jqi8nrDmDfKleOPdhRHL8inl0UqBJOAqUr2HPqDpJV9JKWlby4qglXgTAXJMbx0CBM48Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6591
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS05LTI0IDIxOjI4IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZAa29u
dHJvbi5kZT4gd3JvdGU6DQo+IA0KPiBIaSBSb2JpbiwNCj4gDQo+ID4gRnJvbTogUm9iaW4gR29u
ZyA8eWliaW4uZ29uZyBhdCBueHAuY29tPg0KPiA+DQo+ID4gQmVjYXVzZSB0aGUgbnVtYmVyIG9m
IGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRoZSBjb25kaXRpb24NCj4gPiBjaGVj
ayBpZ25vcmUgc3VjaCBzcGVjaWFsIGNhc2Ugd2l0aG91dCBkbWEgY2hhbm5lbCBlbmFibGVkLCB3
aGljaA0KPiA+IGNhdXNlZA0KPiA+IGVjc3BpMSByeCB3b3JrcyBmYWlsZWQuIEFjdHVhbGx5LCBu
byBuZWVkIHRvIGNoZWNrIGV2ZW50X2lkMC9ldmVudF9pZDENCj4gPiBhbmQgcmVwbGFjZSBjaGVj
a2luZyAnZXZlbnRfaWQxJyB3aXRoICdETUFfREVWX1RPX0RFVicsIHNvIHRoYXQNCj4gPiBjb25m
aWd1cmUNCj4gPiBldmVudF9pZDEgb25seSBpbiBjYXNlIERFVl9UT19ERVYuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nIGF0IG54cC5jb20+DQo+ID4gQWNr
ZWQtYnk6IFZpbm9kIEtvdWwgPHZrb3VsIGF0IGtlcm5lbC5vcmc+DQo+IA0KPiBJIGhhdmUgYSBj
dXN0b20gYm9hcmQgd2l0aCBpLk1YOE1NIGFuZCBTUEkgZmxhc2ggb24gZWNzcGkxLiBJJ20gY3Vy
cmVudGx5DQo+IHRlc3Rpbmcgd2l0aCB2NS4zIGFuZCBhcyBTUEkgZGlkbid0IHdvcmssIEkgdHJp
ZWQgdHdvIGRpZmZlcmVudCB0aGluZ3M6DQo+IA0KPiAxLiBSZW1vdmluZyAnZG1hcycgYW5kICdk
bWEtbmFtZXMnIGZyb20gdGhlIGVjc3BpMSBub2RlIGluIGlteDhtbS5kdHNpLA0KPiAgICAgdG8g
dXNlIFBJTyBpbnN0ZWFkIG9mIERNQS4gVGhpcyB3b3JrcyBhcyBleHBlY3RlZCBhbmQgdGhlIGRy
aXZlcg0KPiAgICAgYm9vdHMgd2l0aCB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzOg0KPiANCj4gICAg
ICAgICBzcGlfaW14IDMwODIwMDAwLnNwaTogZG1hIHNldHVwIGVycm9yIC0xOSwgdXNlIHBpbw0K
PiAgICAgICAgIG0yNXA4MCBzcGkwLjA6IG14MjV2ODAzNWYgKDEwMjQgS2J5dGVzKQ0KPiAgICAg
ICAgIHNwaV9pbXggMzA4MjAwMDAuc3BpOiBwcm9iZWQNCj4gDQo+IDIuIEFwcGx5aW5nIHlvdXIg
cGF0Y2hzZXQgYW5kIHVzZSBETUEuIEluIHRoaXMgY2FzZSwgdGhlIGZsYXNoIGFsc28NCj4gICAg
IHdvcmtzIGZpbmUsIGJ1dCB0aGVyZSBhcmUgc29tZSBlcnJvciBtZXNzYWdlcyBwcmludGVkIHdo
aWxlIGJvb3Rpbmc6DQo+IA0KPiAgICAgICAgIHNwaV9tYXN0ZXIgc3BpMDogSS9PIEVycm9yIGlu
IERNQSBSWA0KPiAgICAgICAgIG0yNXA4MCBzcGkwLjA6IFNQSSB0cmFuc2ZlciBmYWlsZWQ6IC0x
MTANCj4gICAgICAgICBzcGlfbWFzdGVyIHNwaTA6IGZhaWxlZCB0byB0cmFuc2ZlciBvbmUgbWVz
c2FnZSBmcm9tIHF1ZXVlDQo+ICAgICAgICAgbTI1cDgwIHNwaTAuMDogbXgyNXY4MDM1ZiAoMTAy
NCBLYnl0ZXMpDQo+ICAgICAgICAgc3BpX2lteCAzMDgyMDAwMC5zcGk6IHByb2JlZA0KPiANCj4g
SXQgd291bGQgYmUgZ3JlYXQgdG8gZ2V0IHlvdXIgcGF0Y2hlcyBtZXJnZWQgYW5kIGZpeCBTUEkg
KyBETUEsIGJ1dCBmb3INCj4gaS5NWDhNTSwgd2UgbmVlZCB0byBnZXQgcmlkIG9mIHRoZSBlcnJv
ciBtZXNzYWdlcy4gRG8geW91IGhhdmUgYW4gaWRlYSwNCj4gd2hhdCdzIHdyb25nPw0KQ291bGQg
eW91IGNoZWNrIGlmIHRoZSBsZW5ndGggb2Ygc3BpIG1lc3NhZ2UgaXMgYmlnZ2VyIHRoYW4gZmlm
b19zaXplIGR1cmluZw0Kc3BpX25vciBwcm9iZT8gSWYgeWVzLCBhdCB0aGF0IHRpbWUgbWF5YmUg
c2RtYSBmaXJtd2FyZSBub3QgbG9hZGVkLg0KaWYgKHRyYW5zZmVyLT5sZW4gPCBzcGlfaW14LT5k
ZXZ0eXBlX2RhdGEtPmZpZm9fc2l6ZSkNCj4gVGhhbmtzLA0KPiBGcmllZGVyDQo=

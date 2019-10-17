Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8BDA560
	for <lists+dmaengine@lfdr.de>; Thu, 17 Oct 2019 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbfJQGQR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Oct 2019 02:16:17 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:56303
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731726AbfJQGQQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Oct 2019 02:16:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtvGoIG8ZpijhMdVH+B+HbDIPoNZGNzXJYiL2vu5F2q7EF76JIhTRxfrRrxIMHu5o5FAmBucND2RAB6RDWDdgZG7Y/A5CTMUX5oybuxz7K1Qm2LXo/vVFSZHdtmXuyBN8+dcydNeX7NT/k4FELCqmZBWL+zUvJ12O+yIplblS3K2HzBeY3l3/3hyW7QlJg5imHMFCqEgfvXcthFaWl3BttDue+NStBPqOcPigV2heWjMAxOtQ3uJVTq/w5PYFjRgYti2GRIzrX3SAtkHmXBs5RpDxmQthYyFJr5wBAowqRvOAbKt4nTffcXB3sQ3o+U6lInID+Qt4/vYxjpiVUwIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA9ZKT5jtMLXRG/8y8ZTPexLndB+1CFwT/CpeTzVFjc=;
 b=I2jaMeGsY6SZdO2tNOYrISDrfp6slEZzGmY+kOAwlEGOK0t+uxWAm70WwzMFmTJP6Uam3CQChhIa1mJy9x3Lgzfc4xYoEXbOCh1sc6KQFE39eDxuVDEueny7TM3Sep0svbR/ndsrBKxmekd/V2gwmuNDRBUkELobGXVKBupRHmVJdlanXXeKcgH4L7J2jlF5jFLO0FsyVJMi3kCylPjEI96QBvEl0nImoluq5rVINzg9BmFrUk3synJpZ56EK+ddlOfN6RJpC7LsiZE+N1WHOIBvcgKtFWiEpxstRth7n6WawIh3D7isL2CZW3QbKlVclLD9S8MavMuJ7KQfAwDG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA9ZKT5jtMLXRG/8y8ZTPexLndB+1CFwT/CpeTzVFjc=;
 b=C1kvA1b2zvZj5qP7Mn/fbux9TmJLDvZCbOEHsZK4rXZM4Mi8mlDD5tDyy1iaQlCyaKjkI2Jq8ACu9IE345bgK7mldfOSGpUsciHVmz06CbmkBbKLhJaIyu+tYaYjp5OmxaI0DwjQH8snRRXwnAaSRlbqqvgaHie1nsZ99KcmX0s=
Received: from AM0PR04MB4420.eurprd04.prod.outlook.com (52.135.148.26) by
 AM0PR04MB6290.eurprd04.prod.outlook.com (20.179.34.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 17 Oct 2019 06:15:32 +0000
Received: from AM0PR04MB4420.eurprd04.prod.outlook.com
 ([fe80::945b:a8a3:fe1b:1f3]) by AM0PR04MB4420.eurprd04.prod.outlook.com
 ([fe80::945b:a8a3:fe1b:1f3%3]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 06:15:31 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data
 Path DMA Interface) support
Thread-Topic: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
Thread-Index: AQHVdzToZ1j6dYgSekKOe10vHO0HB6deU3YAgAAhjWA=
Date:   Thu, 17 Oct 2019 06:15:31 +0000
Message-ID: <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
References: <20190930020440.7754-1-peng.ma@nxp.com>
 <20191017041124.GN2654@vkoul-mobl>
In-Reply-To: <20191017041124.GN2654@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79979cc0-e960-461f-49ea-08d752c96a24
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB6290:|AM0PR04MB6290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6290E24B17C6C785AA7B101EED6D0@AM0PR04MB6290.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(13464003)(189003)(199004)(52536014)(11346002)(26005)(55016002)(6436002)(33656002)(5024004)(256004)(6506007)(14444005)(102836004)(478600001)(54906003)(446003)(71190400001)(71200400001)(186003)(4326008)(5660300002)(25786009)(76176011)(9686003)(476003)(486006)(44832011)(14454004)(316002)(6246003)(7696005)(66066001)(99286004)(64756008)(3846002)(76116006)(66446008)(81156014)(305945005)(86362001)(74316002)(8936002)(6116002)(7736002)(6916009)(2906002)(66556008)(66476007)(8676002)(66946007)(229853002)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6290;H:AM0PR04MB4420.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vi0VgsARczJkyQATXdQU3gpXM00prypz37kga2yTiKvw4lBiJB5FvtSb+J2qBNGjKCeT1aLNjzSRNDtwWKd2yhNmXnYfUhNFIyxeXwDwUdji80rKmlycBSZaTJsJ7jGxAKx/VeLvkCtZGBNt7mLaKmr3RTguA1c+28vOAz3WutgNqqfytaAzeb0vQbMGYDDYK+b03pVweqO5TVXmMH/Cphu+q/W8hqSJRmpCKY3t8WjGJFyf/6ORTIr0ZnicKgD/ACiJ4BwDBiotKRZ+v8joTH/5z+SzU28gAPUzlXKK3pgx1PMek6ilht54Qa7VZdn4ItDi1Pz27QF4Nr9NCKYjSniooUyg3U2A3k1Pjs5TFx4Elb0oNcZxVCcIZS29JhXIAdVZ2nMBF9VVEbu6pqOhYds+uKT7KUGBlU+noJTlhZE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79979cc0-e960-461f-49ea-08d752c96a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 06:15:31.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBem/TSYyT8HE8WQXbbIkJjolciImkRyxG3SkO1PceF/Jtbcf1dKoQOyjFgI6Xpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6290
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmVwbHkuDQoNCkJlc3QgUmVn
YXJkcywNClBlbmcNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtv
dWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqMTDUwjE3yNUgMTI6MTENCj5Ubzog
UGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPkNjOiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207
IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogW0VYVF0gUmU6IFtWNSAx
LzJdIGRtYWVuZ2luZTogZnNsLWRwYWEyLXFkbWE6IEFkZCB0aGUgRFBETUFJKERhdGENCj5QYXRo
IERNQSBJbnRlcmZhY2UpIHN1cHBvcnQNCj4NCj5DYXV0aW9uOiBFWFQgRW1haWwNCj4NCj5PbiAz
MC0wOS0xOSwgMDI6MDQsIFBlbmcgTWEgd3JvdGU6DQo+PiBUaGUgTUMoTWFuYWdlbWVudCBDb21w
bGV4KSBleHBvcnRzIHRoZSBEUERNQUkoRGF0YSBQYXRoIERNQQ0KPkludGVyZmFjZSkNCj4+IG9i
amVjdCBhcyBhbiBpbnRlcmZhY2UgdG8gb3BlcmF0ZSB0aGUgRFBBQTIoRGF0YSBQYXRoIEFjY2Vs
ZXJhdGlvbg0KPj4gQXJjaGl0ZWN0dXJlIDIpIHFETUEgRW5naW5lLiBUaGUgRFBETUFJIGVuYWJs
ZXMgc2VuZGluZyBmcmFtZS1iYXNlZA0KPj4gcmVxdWVzdHMgdG8gcURNQSBhbmQgcmVjZWl2aW5n
IGJhY2sgY29uZmlybWF0aW9uIHJlc3BvbnNlIG9uDQo+PiB0cmFuc2FjdGlvbiBjb21wbGV0aW9u
LCB1dGlsaXppbmcgdGhlIERQQUEyIFFCTWFuKFF1ZXVlIE1hbmFnZXIgYW5kDQo+PiBCdWZmZXIg
TWFuYWdlcg0KPj4gaGFyZHdhcmUpIGluZnJhc3RydWN0dXJlLiBEUERNQUkgb2JqZWN0IHByb3Zp
ZGVzIHVwIHRvIHR3byBwcmlvcml0aWVzDQo+PiBmb3IgcHJvY2Vzc2luZyBxRE1BIHJlcXVlc3Rz
Lg0KPj4gVGhlIGZvbGxvd2luZyBsaXN0IHN1bW1hcml6ZXMgdGhlIERQRE1BSSBtYWluIGZlYXR1
cmVzIGFuZCBjYXBhYmlsaXRpZXM6DQo+PiAgICAgICAxLiBTdXBwb3J0cyB1cCB0byB0d28gc2No
ZWR1bGluZyBwcmlvcml0aWVzIGZvciBwcm9jZXNzaW5nDQo+PiAgICAgICBzZXJ2aWNlIHJlcXVl
c3RzLg0KPj4gICAgICAgLSBFYWNoIERQRE1BSSB0cmFuc21pdCBxdWV1ZSBpcyBtYXBwZWQgdG8g
b25lIG9mIHR3byBzZXJ2aWNlDQo+PiAgICAgICBwcmlvcml0aWVzLCBhbGxvd2luZyBmdXJ0aGVy
IHByaW9yaXRpemF0aW9uIGluIGhhcmR3YXJlIGJldHdlZW4NCj4+ICAgICAgIHJlcXVlc3RzIGZy
b20gZGlmZmVyZW50IERQRE1BSSBvYmplY3RzLg0KPj4gICAgICAgMi4gU3VwcG9ydHMgdXAgdG8g
dHdvIHJlY2VpdmUgcXVldWVzIGZvciBpbmNvbWluZyB0cmFuc2FjdGlvbg0KPj4gICAgICAgY29t
cGxldGlvbiBjb25maXJtYXRpb25zLg0KPj4gICAgICAgLSBFYWNoIERQRE1BSSByZWNlaXZlIHF1
ZXVlIGlzIG1hcHBlZCB0byBvbmUgb2YgdHdvIHJlY2VpdmUNCj4+ICAgICAgIHByaW9yaXRpZXMs
IGFsbG93aW5nIGZ1cnRoZXIgcHJpb3JpdGl6YXRpb24gYmV0d2VlbiBvdGhlcg0KPj4gICAgICAg
aW50ZXJmYWNlcyB3aGVuIGFzc29jaWF0aW5nIHRoZSBEUERNQUkgcmVjZWl2ZSBxdWV1ZXMgdG8g
RFBJTw0KPj4gICAgICAgb3IgRFBDT04oRGF0YSBQYXRoIENvbmNlbnRyYXRvcikgb2JqZWN0cy4N
Cj4+ICAgICAgIDMuIFN1cHBvcnRzIGRpZmZlcmVudCBzY2hlZHVsaW5nIG9wdGlvbnMgZm9yIHBy
b2Nlc3NpbmcgcmVjZWl2ZWQNCj4+ICAgICAgIHBhY2tldHM6DQo+PiAgICAgICAtIFF1ZXVlcyBj
YW4gYmUgY29uZmlndXJlZCBlaXRoZXIgaW4gJ3BhcmtlZCcgbW9kZSAoZGVmYXVsdCksDQo+PiAg
ICAgICBvciBhdHRhY2hlZCB0byBhIERQSU8gb2JqZWN0LCBvciBhdHRhY2hlZCB0byBEUENPTiBv
YmplY3QuDQo+PiAgICAgICA0LiBBbGxvd3MgaW50ZXJhY3Rpb24gd2l0aCBvbmUgb3IgbW9yZSBE
UElPIG9iamVjdHMgZm9yDQo+PiAgICAgICBkZXF1ZXVlaW5nL2VucXVldWVpbmcgZnJhbWUgZGVz
Y3JpcHRvcnMoRkQpIGFuZCBmb3INCj4+ICAgICAgIGFjcXVpcmluZy9yZWxlYXNpbmcgYnVmZmVy
cy4NCj4+ICAgICAgIDUuIFN1cHBvcnRzIGVuYWJsZSwgZGlzYWJsZSwgYW5kIHJlc2V0IG9wZXJh
dGlvbnMuDQo+Pg0KPj4gQWRkIGRwZG1haSB0byBzdXBwb3J0IHNvbWUgcGxhdGZvcm1zIHdpdGgg
ZHBhYTIgcWRtYSBlbmdpbmUuDQo+DQo+QXBwbGllZCBib3RoLCB0aGFua3MNCj4NCj4tLQ0KPn5W
aW5vZA0K

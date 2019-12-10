Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A324118911
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLJNBj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 08:01:39 -0500
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:21591
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbfLJNBj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 08:01:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQws0X9khzbmzvFXomtEdAvuYiPzn8CA9qSP6lTlnqcAkW81rEK/s4ElUbVap5eMCIUUDPsIB4Cw8d6qtNu2yfe9IkrOyg/vV99oHnin5F+gYoTclaGvePVHZ17L5X3r4lbAQgbYVaILlm1v4N8GPzzI2jlRwanQISPnjymI8wWV89nGsBugXZsflpYp2JfzN23YsHemoQqCEXAdHhx2KwvkCz0+Ii9yn4LesoTm7axUixG/mP/I4OyZP4WtRF3GDPHjQalgmrLuKRkHOdjhDcB1/WCk+IcpZIivVriA0ZCQOa+tmgCtnSaSC6MHcs+Y149kyFEstPkOmKuoX56kTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9NaInt2HQ+R9J+/f6Vrg3GacP79RNP36bdBBrL3K8I=;
 b=IVVHD1emWjrBjdIIJ9KCMI+y4qZ/ygzFNSswT4Y1SW1QXocPtWTM/U/B2AfHDpDqfMWAkCPcLnZds+UksGaf+ib5peVL1tPHLQZxCtoC3tv8fIizRSJSH48xydsveFUMbCI0sNdtQbz6Qt5kgNp+HBVkfbsheUCpkdcmLw6LnKdmyQS1TqI6PHyzAnAriMPeAowH8VCvXSkAxermyaHZc5P71Xdor4rA/gfaQ2OsDW2TWT5mcEtUKT+/uCroqanttEXSFgg76mOItx9RY80L/wEDoDOpKMB04raUeEfi9Mo6ZynRXjVgi51ix+tEmpl3vTwawSAlKJoxrhtv0rdZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9NaInt2HQ+R9J+/f6Vrg3GacP79RNP36bdBBrL3K8I=;
 b=fYcI4Yrp4fWF0CILm5ME4I9sLlFpVJebJ+9XmVfvPKpNHcatRE/HEabEX9hpLJxR6na4Txh83RAj/AMlqUuUgJb5UbiKLREH8N06S/+9YSeT0/4o32pJqbFG03IjeJ4128XCX+VJLHpwczR43+j/eVlo6cidrg12fSGK1cxCQCU=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6446.eurprd04.prod.outlook.com (20.179.233.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Tue, 10 Dec 2019 13:01:29 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 13:01:29 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jlu@pengutronix.de" <jlu@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 1/3] dmaengine: imx-sdma: fix buffer ownership
Thread-Topic: [PATCH v5 1/3] dmaengine: imx-sdma: fix buffer ownership
Thread-Index: AQHVchby6WsIv+QhqUqHYVdym6wSTaeqHbhAgAl68ACAACZmMA==
Date:   Tue, 10 Dec 2019 13:01:29 +0000
Message-ID: <VE1PR04MB6638D0553E35E4C09AE0C6AC895B0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
 <20190923135808.815-2-philipp.puschmann@emlix.com>
 <VE1PR04MB6638A9E882D40FB7F8CB7F14895D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <eb584cf0-2be4-138f-e339-aaf9f6f203b0@emlix.com>
In-Reply-To: <eb584cf0-2be4-138f-e339-aaf9f6f203b0@emlix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [101.86.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f72167a-4167-4410-8d75-08d77d7112ca
x-ms-traffictypediagnostic: VE1PR04MB6446:|VE1PR04MB6446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB644635B2118C674264DFDE63895B0@VE1PR04MB6446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(54534003)(66556008)(71200400001)(66446008)(66476007)(76116006)(64756008)(316002)(186003)(8936002)(478600001)(55016002)(26005)(4326008)(110136005)(53546011)(6506007)(8676002)(86362001)(54906003)(9686003)(2906002)(81156014)(7416002)(52536014)(4001150100001)(7696005)(81166006)(33656002)(66946007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6446;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+FX844x0dFuUxsFLOIxTeupOFEw7NIUgz0R6/OY/SnzpYlXjy1hbKy7sXLh7NJ8U2I0JSrpDMymVzU9JN0R21FhzinleZnrTtWpJrc/kAQfTUCdxhiiXLhD1XRsWhLkHsfsLRMtHs5HJ6s5bHOY87MIpelBvnIgWHtb27SuV5g8gyzhEs62/P+8uhSyByhJ4pSNo/gJG2+RNcVvwJ3095SXB1feKDxv0GM1wv1uBt4dghuqzkhszfbtL/ro+71Llnd1kzsPfyW4YEmzBN7BiBeeNFUk5i8MHBDO1sZcODOvEocOn3UDCxSZw/hnHyjdTUUDyoyv28KZqaOnyLKOkB1x73iSQap6n50RO/Qt11VZ2SEHU3byQ3Ms4eaeV1P2YEx6lWIik/OnMXvz2evAnBqRvhzlNgR9SMQOHsRTTJhs+viZmBRTnpNTAn+c9vhEKHVP2HINZK6HWMIFENVnq3pUv1TTBzPf+xwJLQ0tB5lvqE52rbWl9e2rbAKTzmZb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f72167a-4167-4410-8d75-08d77d7112ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 13:01:29.4176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqnMUBFt/U8b4+KeCpFeBrc7pI1fZT1XeqALOiYz+a/8728tPz7jMU846A80lJ86FhNh9Vgg9vZR+8GJf5xtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6446
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS8xMi8xMCAxNzo0NSBQaGlsaXBwIFB1c2NobWFubiA8cGhpbGlwcC5wdXNjaG1hbm5A
ZW1saXguY29tPiB3cm90ZToNCj4gQW0gMDQuMTIuMTkgdW0gMTA6MTkgc2NocmllYiBSb2JpbiBH
b25nOg0KPiA+IE9uIDIwMTktOS0yMyBQaGlsaXBwIFB1c2NobWFubiA8cGhpbGlwcC5wdXNjaG1h
bm5AZW1saXguY29tPiB3cm90ZToNCj4gPj4gQkRfRE9ORSBmbGFnIG1hcmtzIG93bmVyc2hpcCBv
ZiB0aGUgYnVmZmVyLiBXaGVuIDEgU0RNQSBvd25zIHRoZQ0KPiA+PiBidWZmZXIsIHdoZW4gMCBB
Uk0gb3ducyBpdC4gV2hlbiBwcm9jZXNzaW5nIHRoZSBidWZmZXJzIGluDQo+ID4+IHNkbWFfdXBk
YXRlX2NoYW5uZWxfbG9vcCB0aGUgb3duZXJzaGlwIG9mIHRoZSBjdXJyZW50bHkgcHJvY2Vzc2Vk
DQo+ID4+IGJ1ZmZlciB3YXMgc2V0IHRvIFNETUEgYWdhaW4gYmVmb3JlIHJ1bm5pbmcgdGhlIGNh
bGxiYWNrIGZ1bmN0aW9uIG9mDQo+ID4+IHRoZSBidWZmZXIgYW5kIHdoaWxlIHRoZSBzZG1hIHNj
cmlwdCBtYXkgYmUgcnVubmluZyBpbiBwYXJhbGxlbC4gU28NCj4gPj4gdGhlcmUgd2FzIHRoZSBw
b3NzaWJpbGl0eSB0byBnZXQgdGhlIGJ1ZmZlciBvdmVyd3JpdHRlbiBieSBTRE1BDQo+ID4+IGJl
Zm9yZSBpdCBoYXMgYmVlbiBwcm9jZXNzZWQgYnkga2VybmVsDQo+ID4gRG9lcyB0aGlzIHBhdGNo
IG5lZWQgaW5kZWVkPyBJIGRvbid0IHRoaW5rIGFueSBkaWZmZXJlbmNlIGhlcmUgbW92ZQ0KPiA+
IGRvbmUgZmxhZyBiZWZvcmUgY2FsbGJhY2sgb3IgYWZ0ZXIgY2FsbGJhY2ssIGJlY2F1c2UgY2Fs
bGJhY2sgbmV2ZXINCj4gPiBjYXJlIHRoaXMgZmxhZyBhbmQgYWN0dWFsbHkgZG9uZSBmbGFnIGlz
IHNldHVwIGZvciBuZXh0IHRpbWUgcmF0aGVyIHRoYW4gdGhpcw0KPiB0aW1lLg0KPiBUaGUgY2Fs
bGJhY2sgZG9lc24ndCBjYXJlLCBidXQgdGhlIERNQSBjb250cm9sbGVyIGNhcmVzIGFib3V0IHRo
aXMgZmxhZy4gSSBzZWUgYQ0KPiBwb3NzaWJsZSByYWNlIGNvbmRpdGlvbiBoZXJlLiBJZiBpIHNl
dCB0aGUgRE9ORSBmbGFnIGZvciBhIHNwZWNpZmljIGJ1ZmZlcg0KPiBkZXNjcmlwdG9yIGJlZm9y
ZSBoYW5kbGluZyB0aGUgZGF0YSBiZWxvbmdpbmcgdG8gdGhpcyBidWZmZXIgZGVzY3JpcHRvciAo
YWthDQo+IHJ1bm5pbmcgdGhlIGNhbGxiYWNrIGZ1bmN0aW9uKSB0aGUgRE1BIHNjcmlwdCBydW5u
aW5nIGF0IHRoZSBzYW1lIHRpbWUgY291bGQNCj4gY29ycnVwdCB0aGF0IGRhdGEgd2hpbGUgYmVp
bmcgcHJvY2Vzc2VkLg0KPiBPciBpcyB0aGVyZSBhcmUgbWVjaGFuaXNtIHRoYXQgcHJldmVudHMg
dGhpcyBjYXNlLCB0aGF0IGkgaGF2bid0IGNvbnNpZGVyZWQNCj4gaGVyZS4NCkluIHRoZW9yeSB0
aGF0IG1heSBoYXBwZW4sIGJ1dCBpbiByZWFsIHdvcmxkIHRoYXQncyBub3QgdGhlIGNhc2U6DQox
LiBTRE1BIGlzIHJ1bm5pbmcgbXVjaCBzbG93ZXIgdGhhbiBDUFUsIGZvciBleGFtcGxlLCBvbiBp
Lk1YNlEgU0RNQSBpcyBydW5uaW5nDQphdCA2Nk1IeiB3aGlsZSBDUFUgaXMgcnVubmluZyBhdCAx
R0h6LiBCZXNpZGVzLCBTRE1BIHRyYW5zZmVyIGRhdGEgZGVwZW5kcyBvbiBmaWZvDQpkYXRhIG91
dHB1dCBmcmVxdWVuY3ksIHN1Y2ggYXMgVUFSVCA0TWh6LiBTbyB5b3VyIGNhc2UgbWF5IG5vdCBi
ZSBjYXVnaHQgdW5sZXNzDQp0aW1lLWNvbnN1bWluZyBmbG93IGludm9sdmVkIGluIGNhbGxiYWNr
IHdoaWNoIGlzIG5vdCByaWdodC4NCjIuIFRoZXJlIGFyZSBtdWx0aSBkZXNjcmlwdG9ycyhCRHMp
IHNldHVwIGZvciBjeWNsaWMgbW9kZSwgc28gdGhhdCBTRE1BIGNvbnRyb2xsZXIgYW5kIENQVSBj
b3VsZCBoYW5kbGUgZGF0YSBpbiBwYXJhbGxlbCB3aXRob3V0IGludGVyYWN0aW9ucyBieSB1c2lu
ZyBCRF9ET05FLiBDbGllbnQgZHJpdmVyIHNob3VsZCBjaG9vc2UgcHJvcGVyIEJEIG51bWJlciBh
bmQgdHJhbnNmZXIgc2l6ZSBvZiBCRCB0byBtYWtlIHN1cmUgY3ljbGljIHRyYW5zZmVyIHJ1bm5p
bmcgc21vb3RobHkgd2l0aG91dCBzdG9wLiBJbiB5b3VyIGNhc2UsIGFsbCBCRHMgY29uc3VtZWQg
YnkgU0RNQSBkdXJpbmcgdGhlIG5hcnJvdyB0aW1pbmcgd2luZG93IHdoaWNoIGlzIGJldHdlZW4g
QkRfRE9ORSBzZXQgYW5kIGNhbGxiYWNrIGRvbmUgYXQgQ1BVIHNpZGUoYWxsIGluIGludGVycnVw
dCBoYW5kbGVyKS4gVGhhdCBuZXZlciBoYXBwZW4gdW5sZXNzIHZlcnkgc21hbGwgQkQgc2l6ZSBz
ZXQgd3JvbmdseSwgc3VjaCBhcyBvbmx5IDMyIGJ5dGUgb3IgNjQgYnl0ZSBmb3Igb25lIEJELCBi
dXQgZ2VuZXJhbGx5IEJEIHNpemUgaXMgaW4gS0IgdW5pdC4NCj4gDQo+ID4gQmFzaWNhbGx5LCB0
aGlzIGZsYWcgc2hvdWxkIGJlDQo+ID4gc2V0IHRvIDEgcXVpY2tseSBhc2FwIHNvIHRoYXQgc2Rt
YSBjb3VsZCB1c2UgdGhpcyBiZCBhc2FwLiBJZiBkZWxheQ0KPiA+IHRoZSBmbGFnIG1heSBjYXVz
ZSBzZG1hIGNoYW5uZWwgc3RvcCBzaW5jZSBhbGwgQkRzIGNvbnN1bWVkLg0KPiANCj4gPiBDb3Vs
ZCB5b3UgdHJ5IGFnYWluIHlvdXIgY2FzZSB3aXRob3V0IHRoaXMgcGF0Y2g/DQo+IEkgZG9uJ3Qg
aGF2ZSB0aGUgaHcgdG8gcmVwcm9kdWNlIHRoaXMgYXZhaWxhYmxlIGF0IHRoZSBtb21lbnQgYnV0
IGFzIGkNCj4gcmVtZW1iZXIgaSBkaWQgcnVuIGl0IHdpdGhvdXQgdGhpcyBwYXRjaCBzdWNjZXNz
ZnVsbHkgYWxyZWFkeS4gVGhlIHByb2JsZW0gaQ0KPiBoYXZlIGRlc2NyaWJlZCBhYm92ZSB3YXMg
bW9yZSBhIGxvZ2ljYWwgb3IgdGhlb3JldGljYWwgb25lIHRoYW4gYSBwcm9ibGVtDQo+IHRoYXQg
cmVhbGx5IG9jY3VyZWQgd2l0aCBteSBzZXR1cC4NCj4gDQo+ID4+IGxlYWRpbmcgdG8ga2luZCBv
ZiByYW5kb20gZXJyb3JzIGluIHRoZSB1cHBlciBsYXllcnMsIGUuZy4gYmx1ZXRvb3RoLg0KPiA+
Pg0KPiA+PiBGaXhlczogMWVjMWU4MmYyNTEwICgiZG1hZW5naW5lOiBBZGQgRnJlZXNjYWxlIGku
TVggU0RNQSBzdXBwb3J0IikNCj4gPj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBQdXNjaG1hbm4g
PHBoaWxpcHAucHVzY2htYW5uQGVtbGl4LmNvbT4NCj4gPj4gLS0tDQo+ID4+DQo+ID4+IENoYW5n
ZWxvZyB2NToNCj4gPj4gIC0gbm8gY2hhbmdlcw0KPiA+Pg0KPiA+PiBDaGFuZ2Vsb2cgdjQ6DQo+
ID4+ICAtIGZpeGVkIHRoZSBmaXhlcyB0YWcNCj4gPj4NCj4gPj4gQ2hhbmdlbG9nIHYzOg0KPiA+
PiAgLSB1c2UgY29ycmVjdCBkbWFfd21iKCkgaW5zdGVhZCBvZiBkbWFfd2IoKQ0KPiA+PiAgLSBh
ZGQgZml4ZXMgdGFnDQo+ID4+DQo+ID4+IENoYW5nZWxvZyB2MjoNCj4gPj4gIC0gYWRkIGRtYV93
YigpDQo+ID4+DQo+ID4+ICBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgNCArKystDQo+ID4+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNk
bWEuYyBpbmRleA0KPiA+PiA5YmE3NGFiN2U5MTIuLmI0MjI4MTYwNGU1NCAxMDA2NDQNCj4gPj4g
LS0tIGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiA+PiArKysgYi9kcml2ZXJzL2RtYS9pbXgt
c2RtYS5jDQo+ID4+IEBAIC04MDIsNyArODAyLDYgQEAgc3RhdGljIHZvaWQgc2RtYV91cGRhdGVf
Y2hhbm5lbF9sb29wKHN0cnVjdA0KPiA+PiBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KPiA+PiAgCQkq
Lw0KPiA+Pg0KPiA+PiAgCQlkZXNjLT5jaG5fcmVhbF9jb3VudCA9IGJkLT5tb2RlLmNvdW50Ow0K
PiA+PiAtCQliZC0+bW9kZS5zdGF0dXMgfD0gQkRfRE9ORTsNCj4gPj4gIAkJYmQtPm1vZGUuY291
bnQgPSBkZXNjLT5wZXJpb2RfbGVuOw0KPiA+PiAgCQlkZXNjLT5idWZfcHRhaWwgPSBkZXNjLT5i
dWZfdGFpbDsNCj4gPj4gIAkJZGVzYy0+YnVmX3RhaWwgPSAoZGVzYy0+YnVmX3RhaWwgKyAxKSAl
IGRlc2MtPm51bV9iZDsgQEANCj4gLTgxNyw2DQo+ID4+ICs4MTYsOSBAQCBzdGF0aWMgdm9pZCBz
ZG1hX3VwZGF0ZV9jaGFubmVsX2xvb3Aoc3RydWN0IHNkbWFfY2hhbm5lbA0KPiA+PiAqc2RtYWMp
DQo+ID4+ICAJCWRtYWVuZ2luZV9kZXNjX2dldF9jYWxsYmFja19pbnZva2UoJmRlc2MtPnZkLnR4
LCBOVUxMKTsNCj4gPj4gIAkJc3Bpbl9sb2NrKCZzZG1hYy0+dmMubG9jayk7DQo+ID4+DQo+ID4+
ICsJCWRtYV93bWIoKTsNCj4gPj4gKwkJYmQtPm1vZGUuc3RhdHVzIHw9IEJEX0RPTkU7DQo+ID4+
ICsNCj4gPj4gIAkJaWYgKGVycm9yKQ0KPiA+PiAgCQkJc2RtYWMtPnN0YXR1cyA9IG9sZF9zdGF0
dXM7DQo+ID4+ICAJfQ0KPiA+PiAtLQ0KPiA+PiAyLjIzLjANCj4gPg0K

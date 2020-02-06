Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9B1541AB
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2020 11:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBFKRV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Feb 2020 05:17:21 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:50450 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgBFKRV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Feb 2020 05:17:21 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 167B167A900;
        Thu,  6 Feb 2020 11:17:16 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 6 Feb 2020
 11:17:15 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.005; Thu, 6 Feb 2020 11:17:15 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Robin Gong <yibin.gong@nxp.com>
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
Subject: Re: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Topic: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHVctvU4cuMSjzwIEqWCaN8EgDgaac8IOgAgAA51YCAAks3gIDQEMQA
Date:   Thu, 6 Feb 2020 10:17:15 +0000
Message-ID: <862c498f-3c15-fac4-4f17-a30c2e11bb3e@kontron.de>
References: <20190610081753.11422-12-yibin.gong@nxp.com>
 <29cf9f29-bdb4-94db-00b0-56ec36386f7a@kontron.de>
 <VE1PR04MB6638639EF4F580E04689538E89870@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <1307d229-4c49-80e3-04ba-377c0caeae9c@kontron.de>
 <VE1PR04MB6638B066EE28781A3C21973D89810@VE1PR04MB6638.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6638B066EE28781A3C21973D89810@VE1PR04MB6638.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D04AC711B1A41C4A8E13C635F1736633@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 167B167A900.A2B18
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, vkoul@kernel.org,
        yibin.gong@nxp.com
X-Spam-Status: No
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksDQoNCk9uIDI3LjA5LjE5IDAzOjU1LCBSb2JpbiBHb25nIHdyb3RlOg0KPiBPbiAyMDE5LTkt
MjUgMjI6NTMgU2NocmVtcGYgRnJpZWRlciA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPiB3
cm90ZToNCj4+IE9uIDI1LjA5LjE5IDEzOjI2LCBSb2JpbiBHb25nIHdyb3RlOg0KPj4+IE9uIDIw
MTktOS0yNCAyMToyOCBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24u
ZGU+DQo+PiB3cm90ZToNCj4+Pj4NCj4+Pj4gSGkgUm9iaW4sDQo+Pj4+DQo+Pj4+PiBGcm9tOiBS
b2JpbiBHb25nIDx5aWJpbi5nb25nIGF0IG54cC5jb20+DQo+Pj4+Pg0KPj4+Pj4gQmVjYXVzZSB0
aGUgbnVtYmVyIG9mIGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRoZSBjb25kaXRp
b24NCj4+Pj4+IGNoZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBjaGFu
bmVsIGVuYWJsZWQsIHdoaWNoDQo+Pj4+PiBjYXVzZWQNCj4+Pj4+IGVjc3BpMSByeCB3b3JrcyBm
YWlsZWQuIEFjdHVhbGx5LCBubyBuZWVkIHRvIGNoZWNrDQo+Pj4+PiBldmVudF9pZDAvZXZlbnRf
aWQxIGFuZCByZXBsYWNlIGNoZWNraW5nICdldmVudF9pZDEnIHdpdGgNCj4+Pj4+ICdETUFfREVW
X1RPX0RFVicsIHNvIHRoYXQgY29uZmlndXJlDQo+Pj4+PiBldmVudF9pZDEgb25seSBpbiBjYXNl
IERFVl9UT19ERVYuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWli
aW4uZ29uZyBhdCBueHAuY29tPg0KPj4+Pj4gQWNrZWQtYnk6IFZpbm9kIEtvdWwgPHZrb3VsIGF0
IGtlcm5lbC5vcmc+DQo+Pj4+DQo+Pj4+IEkgaGF2ZSBhIGN1c3RvbSBib2FyZCB3aXRoIGkuTVg4
TU0gYW5kIFNQSSBmbGFzaCBvbiBlY3NwaTEuIEknbQ0KPj4+PiBjdXJyZW50bHkgdGVzdGluZyB3
aXRoIHY1LjMgYW5kIGFzIFNQSSBkaWRuJ3Qgd29yaywgSSB0cmllZCB0d28gZGlmZmVyZW50DQo+
PiB0aGluZ3M6DQo+Pj4+DQo+Pj4+IDEuIFJlbW92aW5nICdkbWFzJyBhbmQgJ2RtYS1uYW1lcycg
ZnJvbSB0aGUgZWNzcGkxIG5vZGUgaW4NCj4+IGlteDhtbS5kdHNpLA0KPj4+PiAgICAgICB0byB1
c2UgUElPIGluc3RlYWQgb2YgRE1BLiBUaGlzIHdvcmtzIGFzIGV4cGVjdGVkIGFuZCB0aGUgZHJp
dmVyDQo+Pj4+ICAgICAgIGJvb3RzIHdpdGggdGhlIGZvbGxvd2luZyBtZXNzYWdlczoNCj4+Pj4N
Cj4+Pj4gICAgICAgICAgIHNwaV9pbXggMzA4MjAwMDAuc3BpOiBkbWEgc2V0dXAgZXJyb3IgLTE5
LCB1c2UgcGlvDQo+Pj4+ICAgICAgICAgICBtMjVwODAgc3BpMC4wOiBteDI1djgwMzVmICgxMDI0
IEtieXRlcykNCj4+Pj4gICAgICAgICAgIHNwaV9pbXggMzA4MjAwMDAuc3BpOiBwcm9iZWQNCj4+
Pj4NCj4+Pj4gMi4gQXBwbHlpbmcgeW91ciBwYXRjaHNldCBhbmQgdXNlIERNQS4gSW4gdGhpcyBj
YXNlLCB0aGUgZmxhc2ggYWxzbw0KPj4+PiAgICAgICB3b3JrcyBmaW5lLCBidXQgdGhlcmUgYXJl
IHNvbWUgZXJyb3IgbWVzc2FnZXMgcHJpbnRlZCB3aGlsZQ0KPj4gYm9vdGluZzoNCj4+Pj4NCj4+
Pj4gICAgICAgICAgIHNwaV9tYXN0ZXIgc3BpMDogSS9PIEVycm9yIGluIERNQSBSWA0KPj4+PiAg
ICAgICAgICAgbTI1cDgwIHNwaTAuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMA0KPj4+PiAg
ICAgICAgICAgc3BpX21hc3RlciBzcGkwOiBmYWlsZWQgdG8gdHJhbnNmZXIgb25lIG1lc3NhZ2Ug
ZnJvbSBxdWV1ZQ0KPj4+PiAgICAgICAgICAgbTI1cDgwIHNwaTAuMDogbXgyNXY4MDM1ZiAoMTAy
NCBLYnl0ZXMpDQo+Pj4+ICAgICAgICAgICBzcGlfaW14IDMwODIwMDAwLnNwaTogcHJvYmVkDQo+
Pj4+DQo+Pj4+IEl0IHdvdWxkIGJlIGdyZWF0IHRvIGdldCB5b3VyIHBhdGNoZXMgbWVyZ2VkIGFu
ZCBmaXggU1BJICsgRE1BLCBidXQNCj4+Pj4gZm9yIGkuTVg4TU0sIHdlIG5lZWQgdG8gZ2V0IHJp
ZCBvZiB0aGUgZXJyb3IgbWVzc2FnZXMuIERvIHlvdSBoYXZlIGFuDQo+Pj4+IGlkZWEsIHdoYXQn
cyB3cm9uZz8NCj4+DQo+Pj4gQ291bGQgeW91IGNoZWNrIGlmIHRoZSBsZW5ndGggb2Ygc3BpIG1l
c3NhZ2UgaXMgYmlnZ2VyIHRoYW4gZmlmb19zaXplDQo+Pj4gZHVyaW5nIHNwaV9ub3IgcHJvYmU/
IElmIHllcywgYXQgdGhhdCB0aW1lIG1heWJlIHNkbWEgZmlybXdhcmUgbm90IGxvYWRlZC4NCj4+
PiBpZiAodHJhbnNmZXItPmxlbiA8IHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+Zmlmb19zaXplKQ0K
Pj4NCj4+IEluZGVlZCwgbW9zdCBvZiB0aGUgdHJhbnNmZXJzIHRyaWdnZXJlZCBieSB0aGUgU1BJ
IE5PUiBkaXJ2ZXIgYXJlIGJlbG93DQo+PiBmaWZvX3NpemUgYW5kIHdvcmsgZmluZSwgYnV0IHNv
bWUgYXJlIGJpZ2dlci4gVGhlIHRyYW5zZmVycyB0aGVyZWZvcmUgdHJ5IHRvDQo+PiB1c2UgRE1B
LCBidXQgdGhlIGZpcm13YXJlIGlzIG5vdCBsb2FkZWQgeWV0Lg0KPj4NCj4+IEhvdyBpcyB0aGlz
IHN1cHBvc2VkIHRvIHdvcms/IFNob3VsZG4ndCBhbGwgdHJhbnNmZXJzIHVzZSBQSU8gYXMgbG9u
ZyBhcyB0aGUNCj4+IFNETUEgZmlybXdhcmUgaXMgbm90IGxvYWRlZCB5ZXQ/DQo+IFllcywgZm9y
IGVjc3BpIHNob3VsZCB3b3JrIHdpdGggcmFtIHNjcmlwdCwgaXQncyBiZXR0ZXIgY2hlY2sgaWYg
c2RtYSBmaXJtd2FyZQ0KPiBpcyByZWFkeSBpbiBzcGlfaW14X2RtYV9jb25maWd1cmUoKSwgbmVl
ZCBtb2RpZmljYXRpb24gaW4gc2RtYSBkcml2ZXIgdG9vLg0KPiBJJ2xsIGNyZWF0ZSBhbm90aGVy
IHBhdGNoIGFmdGVyIHRoaXMgcGF0Y2ggc2V0IGFjY2VwdGVkLg0KDQpUaGlzIHN0aWxsIHNlZW1z
IHRvIGJlIGJyb2tlbiB1cHN0cmVhbS4gSXMgYW55b25lIHdvcmtpbmcgb24gZml4aW5nIFNQSSAN
CisgRE1BIGZvciBpLk1YOE1NPyBPdGhlcndpc2UgSSB3aWxsIHNlbmQgYSBwYXRjaCB0aGF0IHJl
bW92ZXMgdGhlIERNQSANCmZyb20gdGhlIGVjc3BpIG5vZGVzIGluIHRoZSBkZXZpY2V0cmVlLg0K
DQpUaGFua3MsDQpGcmllZGVy
